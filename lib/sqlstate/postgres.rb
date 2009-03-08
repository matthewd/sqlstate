
require 'sqlstate/standard'

class SqlState::PostgresError < SqlState
  extend SqlStateRoot

  # The PostgreSQL-specific informational fields that are available from
  # an SqlState exception that has been raised from PostgreSQL. This
  # module is extended into all exceptions returned by
  # SqlState::PostgresError#create.
  #
  # These fields are in addition to +message+, which should contain the
  # single-line "primary message" from the PostgreSQL server.
  #
  # Any values not made available by the server should be left set to
  # nil.
  module Details
    # A potentially multi-line description, containing more specific
    # information as to what caused the error. Contains only facts, not
    # speculation.
    attr_accessor :details

    # A potentially multi-line suggestion of action that may be taken to
    # resolve the issue; may be speculative.
    attr_accessor :hint

    attr_accessor :context


    attr_accessor :source_file

    attr_accessor :source_line

    attr_accessor :source_function


    # The user query that was executing at the time the error occurred.
    attr_accessor :query

    # A character (not byte) offset into the +query+, indicating
    # specifically where to look for the error.
    attr_accessor :query_position

    # An internally constructed SQL query that was being evaluated on
    # the server, as a result of the given user +query+, at the time of
    # the error.
    attr_accessor :internal_query

    # A character (not byte) offset into the +internal_query+,
    # indicating specifically where to look for the error.
    attr_accessor :internal_position
  end

  # Creates an exception representing the given SQLSTATE code, as
  # generated from PostgreSQL. Should be used in preference to calling
  # #for then #new, because it adds PostgreSQL-specific fields (as
  # defined in Details) to the returned exception -- even ones defined
  # in the standard.
  def self.create(sql_state, message=nil)
    obj = super
    obj.send(:extend, Details)
    obj
  end


  define_class 'P0', 'PL/pgSQL Error' do |k|
    k.define '001', 'RAISE EXCEPTION'
    k.define '002', 'No Data Found'
    k.define '003', 'Too Many Rows'
  end

  define_class 'XX', 'Internal Error' do |k|
    k.define '001', 'Data Corrupted'
    k.define '002', 'Index Corrupted'
  end

  define '08P01', 'Protocol Violation'

  define '0LP01', 'Invalid Grant Operation'

  define '22P06', 'Nonstandard Use Of Escape Character'
  define '22P01', 'Floating Point Exception'
  define '22P02', 'Invalid Text Representation'
  define '22P03', 'Invalid Binary Representation'
  define '22P04', 'Bad Copy File Format'
  define '22P05', 'Untranslatable Character'

  define '23502', 'Not Null Violation'
  define '23503', 'Foreign Key Violation'
  define '23505', 'Unique Violation'
  define '23514', 'Check Violation'

  define '25P01', 'No Active SQL Transaction'
  define '25P02', 'In Failed SQL Transaction'

  define '2BP01', 'Dependent Objects Still Exist'

  define '39P01', 'Trigger Protocol Violated'
  define '39P02', 'SRF Protocol Violated'

  define '40P01', 'Deadlock Detected'

  define '42601', 'Syntax Error'
  define '42501', 'Insufficient Privilege'
  define '42846', 'Cannot Coerce'
  define '42803', 'Grouping Error'
  define '42P19', 'Invalid Recursion'
  define '42830', 'Invalid Foreign Key'
  define '42602', 'Invalid Name'
  define '42622', 'Name Too Long'
  define '42939', 'Reserved Name'
  define '42804', 'Datatype Mismatch'
  define '42P18', 'Indeterminate Datatype'
  define '42809', 'Wrong Object Type'
  define '42703', 'Undefined Column'
  define '42883', 'Undefined Function'
  define '42P01', 'Undefined Table'
  define '42P02', 'Undefined Parameter'
  define '42704', 'Undefined Object'
  define '42701', 'Duplicate Column'
  define '42P03', 'Duplicate Cursor'
  define '42P04', 'Duplicate Database'
  define '42723', 'Duplicate Function'
  define '42P05', 'Duplicate Prepared Statement'
  define '42P06', 'Duplicate Schema'
  define '42P07', 'Duplicate Table'
  define '42712', 'Duplicate Alias'
  define '42710', 'Duplicate Object'
  define '42702', 'Ambiguous Column'
  define '42725', 'Ambiguous Function'
  define '42P08', 'Ambiguous Parameter'
  define '42P09', 'Ambiguous Alias'
  define '42P10', 'Invalid Column Reference'
  define '42611', 'Invalid Column Definition'
  define '42P11', 'Invalid Cursor Definition'
  define '42P12', 'Invalid Database Definition'
  define '42P13', 'Invalid Function Definition'
  define '42P14', 'Invalid Prepared Statement Definition'
  define '42P15', 'Invalid Schema Definition'
  define '42P16', 'Invalid Table Definition'
  define '42P17', 'Invalid Object Definition'

  define '55P02', 'Cant Change Runtime Param'
  define '55P03', 'Lock Not Available'

  define '57P01', 'Admin Shutdown'
  define '57P02', 'Crash Shutdown'
  define '57P03', 'Cannot Connect Now'

  define '58P01', 'Undefined File'
  define '58P02', 'Duplicate File'
end

