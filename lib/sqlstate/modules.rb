
module SqlState::SqlStateClass
  # A hash mapping SQLSTATE codes to the classes that represent them.
  attr_reader :sqlstate_subclasses
  private :sqlstate_subclasses

  # The first two characters in the SQLSTATE code, which identifies the
  # "class" of State.
  attr_accessor :sqlstate_prefix
  private :sqlstate_prefix, :sqlstate_prefix=

  class << self
    # Invoked when this module is added to a class; initializes the
    # sqlstate_subclasses hash.
    def extended(target) # :nodoc:
      target.instance_variable_set :@sqlstate_subclasses, {}
    end
  end

  # Defines a particular SQLSTATE code, underneath this class, given its
  # description. The constant name will be generated from the
  # description. If specified, +parent+ will be used as the superclass,
  # otherwise, this class will be used as both parent and superclass.
  def define(suffix, description, parent=nil)
    parent ||= self
    sql_state = (defined?(@sqlstate_prefix) ? @sqlstate_prefix : '') + suffix
    name = description.gsub(/([A-Za-z])([A-Za-z0-9]+)/) { $1.upcase + $2.downcase }.gsub(/[^A-Za-z0-9]+/, '')
    klass = Class.new(parent)
    klass.const_set :SQL_STATE, sql_state
    klass.const_set :MESSAGE, description
    root = defined?( @root ) ? @root : self
    klass.instance_variable_set :@root, root
    root.const_set name, klass
    sqlstate_subclasses[sql_state] = klass
  end
  protected :define

  # Looks up the given SQLSTATE code, and returns the corresponding
  # class if there is an exact match registered as a child of this
  # class.
  def subclass_for(sql_state)
    sqlstate_subclasses[sql_state]
  end
  private :subclass_for
end

module SqlState::SqlStateRoot
  include SqlState::SqlStateClass

  class << self
    # Invoked when this module is added to a class; initializes the
    # sqlstate_subclasses hash.
    def extended(target) # :nodoc:
      SqlState::SqlStateClass.extended(target)
    end
  end

  # Returns the Ruby Class representing the SQLSTATE Class identified by
  # the first two characters in the given SQLSTATE code.
  def class_for(state)
    sqlstate_subclasses[state[0, 2] + '000']
  end
  private :class_for

  # Returns the Ruby Class that best represents the given SQLSTATE code,
  # trying first for an exact match, then a match based on the Class
  # (first two characters), then finally falling back to this class
  # itself.
  def for(sql_state)
    subclass = subclass_for(sql_state)
    if klass = class_for(sql_state)
      subclass ||= klass.send(:subclass_for, sql_state)
    end
    if superclass.respond_to?(:for)
      subclass ||= superclass.for(sql_state)
    end
    subclass || self
  end

  # Creates an instance representing the given SQLSTATE code. Should
  # generally be used in preference to calling #for then #new, because
  # it can be overridden by a vendor subclass, to allow for additional,
  # vendor-specific fields, even on standard errors.
  def create(sql_state, *args)
    self.for(sql_state).new(sql_state, *args)
  end

  # Defines a two-letter SQLSTATE class (and its corresponding 000
  # generic state code). If a block is given, yields the newly created
  # class -- extended with SqlState::SqlStateClass -- providing a simple
  # way to define further state codes within this SQLSTATE class. The
  # constant name will be generated from the description.
  def define_class(prefix, description)
    klass = define("#{prefix}000", description)
    klass.send :extend, SqlState::SqlStateClass
    klass.send :sqlstate_prefix=, prefix
    yield klass if block_given?
    klass
  end
  protected :define_class

  # Defines a particular SQLSTATE code, given its description. The
  # constant name will be generated from the description. Will
  # automatically locate the SQLSTATE class the given code should be
  # defined underneath.
  def define(sql_state, description)
    parent = class_for(sql_state)
    if superclass.respond_to?(:class_for, true)
      parent ||= superclass.send(:class_for, sql_state)
    end
    super(sql_state, description, parent)
  end
  protected :define
end

