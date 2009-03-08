
module SqlState::SqlStateClass
  attr_reader :sqlstate_subclasses
  attr_writer :sqlstate_prefix
  def self.extended(target)
    target.instance_variable_set :@sqlstate_subclasses, {}
  end
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
  def subclass_for(sql_state)
    sqlstate_subclasses[sql_state]
  end
end

module SqlState::SqlStateRoot
  include SqlState::SqlStateClass

  def self.extended(target)
    target.instance_variable_set :@sqlstate_subclasses, {}
  end

  def set_parent_root(v)
    @parent_root = v
  end
  def parent_root
    defined?(@parent_root) ?
      @parent_root :
      self == SqlState ?
        nil :
        SqlState
  end

  def class_for(state)
    sqlstate_subclasses[state[0, 2] + '000']
  end
  def for(sql_state)
    subclass = subclass_for(sql_state)
    subclass ||= class_for(sql_state).subclass_for(sql_state) if class_for(sql_state)
    subclass ||= parent_root.for(sql_state) if parent_root
    subclass || self
  end

  def create(sql_state, *args)
    self.for(sql_state).new(sql_state, *args)
  end

  def define_class(prefix, description)
    klass = define("#{prefix}000", description)
    klass.send :extend, SqlState::SqlStateClass
    klass.sqlstate_prefix = prefix
    yield klass if block_given?
    klass
  end

  def define(sql_state, description)
    parent = class_for(sql_state)
    parent ||= parent_root && parent_root.class_for(sql_state)
    super(sql_state, description, parent)
  end
end

