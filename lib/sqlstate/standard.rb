
require 'sqlstate/core'

class SqlState < StandardError
  # The following was initially populated from the PostgreSQL docs:
  # http://developer.postgresql.org/pgdocs/postgres/errcodes-appendix.html.
  # Extend with other codes defined by the SQL Standard as encountered.

  define_class '03', 'SQL Statement Not Yet Complete'

  define_class '08', 'Connection Exception' do |k|
    k.define '003', 'Connection Does Not Exist'
    k.define '006', 'Connection Failure'
    k.define '001', 'SQL-Client Unable to Establish SQL-Connection'
    k.define '004', 'SQL-Server Rejected Establishment of SQL-Connection'
    k.define '007', 'Transaction Resolution Unknown'
  end

  define_class '09', 'Triggered Action Exception'

  define_class '0B', 'Invalid Transation Initiation'

  define_class '0F', 'Locator Exception' do |k|
    k.define '001', 'Invalid Locator Specification'
  end

  define_class '0L', 'Invalid Grantor'

  define_class '0P', 'Invalid Role Specification'

  define_class '20', 'Case Not Found'

  define_class '21', 'Cardinality Violation'

  define_class '22', 'Data Exception' do |k|
    k.define '02E', 'Array Subscript Error'
    k.define '021', 'Character Not In Repertoire'
    k.define '008', 'DateTime Field Overflow'
    k.define '012', 'Division By Zero'
    k.define '005', 'Error In Assignment'
    k.define '00B', 'Escape Character Conflict'
    k.define '022', 'Indicator Overflow'
    k.define '015', 'Interval Field Overflow'
    k.define '01E', 'Invalid Argument For Logarithm'
    k.define '01F', 'Invalid Argument For Power Function'
    k.define '01G', 'Invalid Argument For Width Bucket Function'
    k.define '018', 'Invalid Character Value For Cast'
    k.define '007', 'Invalid DateTime Format'
    k.define '019', 'Invalid Escape Character'
    k.define '00D', 'Invalid Escape Octet'
    k.define '025', 'Invalid Escape Sequence'
    k.define '010', 'Invalid Indicator Parameter Value'
    k.define '020', 'Invalid Limit Value'
    k.define '023', 'Invalid Parameter Value'
    k.define '01B', 'Invalid Regular Expression'
    k.define '009', 'Invalid Time Zone Displacement Value'
    k.define '00C', 'Invalid Use Of Escape Character'
    k.define '00G', 'Most Specific Type Mismatch'
    k.define '004', 'Null Value Not Allowed'
    k.define '002', 'Null Value No Indicator Parameter'
    k.define '003', 'Numeric Value Out Of Range'
    k.define '026', 'String Data Length Mismatch'
    k.define '001', 'String Data Right Truncation'
    k.define '011', 'Substring Error'
    k.define '027', 'Trim Error'
    k.define '024', 'Unterminated C String'
    k.define '00F', 'Zero Length Character String'
    k.define '00L', 'Not An XML Document'
    k.define '00M', 'Invalid XML Document'
    k.define '00N', 'Invalid XML Content'
    k.define '00S', 'Invalid XML Comment'
    k.define '00T', 'Invalid XML Processing Instruction'
  end

  define_class '23', 'Integrity Constraint Violation' do |k|
    k.define '001', 'Restrict Violation'
  end

  define_class '24', 'Invalid Cursor State'

  define_class '25', 'Invalid Transaction State' do |k|
    k.define '001', 'Active SQL Transaction'
    k.define '002', 'Branch Transaction Already Active'
    k.define '008', 'Held Cursor Requires Same Isolation Level'
    k.define '003', 'Inappropriate Access Mode For Branch Transaction'
    k.define '004', 'Inappropriate Isolation Level For Branch Transaction'
    k.define '005', 'No Active SQL Transaction For Branch Transaction'
    k.define '006', 'Read Only SQL Transaction'
    k.define '007', 'Schema And Data Statement Mixing Not Supported'
  end

  define_class '26', 'Invalid SQL Statement Name'

  define_class '27', 'Triggered Data Change Violation'

  define_class '28', 'Invalid Authorization Specification'

  define_class '2B', 'Dependent Privilege Descriptors Still Exist'

  define_class '2D', 'Invalid Transaction Termination'

  define_class '2F', 'SQL Routine Exception' do |k|
    k.define '005', 'SQL Routine: Function Executed No Return Statement'
    k.define '002', 'SQL Routine: Modifying SQL Data Not Permitted'
    k.define '003', 'SQL Routine: Prohibited SQL Statement Attempted'
    k.define '004', 'SQL Routine: Reading SQL Data Not Permitted'
  end

  define_class '34', 'Invalid Cursor Name'

  define_class '38', 'External Routine Exception' do |k|
    k.define '001', 'External Routine: Containing SQL Not Permitted'
    k.define '002', 'External Routine: Modifying SQL Data Not Permitted'
    k.define '003', 'External Routine: Prohibited SQL Statement Attempted'
    k.define '004', 'External Routine: Reading SQL Data Not Permitted'
  end

  define_class '39', 'External Routine Invocation Exception' do |k|
    k.define '001', 'Invalid SQLState Returned'
    k.define '004', 'External Routine Invocation: Null Value Not Allowed'
  end

  define_class '3B', 'Savepoint Exception' do |k|
    k.define '001', 'Invalid Savepoint Specification'
  end

  define_class '3D', 'Invalid Catalog Name'

  define_class '3F', 'Invalid Schema Name'

  define_class '40', 'Transaction Rollback' do |k|
    k.define '002', 'Transaction Integrity Constraint Violation'
    k.define '001', 'Serialization Failure'
    k.define '003', 'Statement Completion Unknown'
  end

  define_class '42', 'Syntax Error Or Access Rule Violation'

  define_class '44', 'WITH CHECK OPTION Violation'



  # Are these classes standard? PostgreSQL defines some subclasses as
  # 5?P??, which suggests they are. They also seem to match DB2 codes,
  # at least in part. The ADO and Oracle docs don't mention any of them,
  # though, and chapter 17 of "Understanding the New SQL" (Melton,
  # Simon) states that the (1992) standard only defines codes matching
  # [0-4A-H]?[0-4A-H]??.

  define_class '53', 'Insufficient Resources' do |k|
    k.define '100', 'Disk Full'
    k.define '200', 'Out Of Memory'
    k.define '300', 'Too Many Connections'
  end

  define_class '54', 'Program Limit Exceeded' do |k|
    k.define '001', 'Statement Too Complex'
    k.define '011', 'Too Many Columns'
    k.define '023', 'Too Many Arguments'
  end

  define_class '55', 'Object Not In Prerequisite State' do |k|
    k.define '006', 'Object In Use'
  end

  define_class '57', 'Operator Intervention' do |k|
    k.define '014', 'Query Canceled'
  end

  define_class '58', 'System Error' do |k|
    k.define '030', 'IO Error'
  end


  define_class 'F0', 'Config File Error' do |k|
    k.define '001', 'Lock File Exists'
  end
end

