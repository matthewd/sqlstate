
require 'sqlstate/modules'

class SqlState < StandardError
  extend SqlStateRoot

  # The SQLSTATE code this class is defined as representing. A given
  # instance's +sql_state+ value may differ, if the instance is a
  # representation of an unrecognised code.
  SQL_STATE = 'HY000'

  # The default message corresponding with this exception type; used if
  # no message is supplied when creating a new exception instance.
  MESSAGE = 'Unrecognised SQL Error'

  # The SQLSTATE code represented by this exception
  attr_reader :sql_state

  # Creates a new instance of this exception class. Calling #create on
  # the relevant "vendor root", such as SqlState::PostgresError, is the
  # most effective means of creating an instance, as this gives the
  # vendor root a chance to extend it with vendor-specific fields.
  def initialize(sql_state=self.class::SQL_STATE, message=self.class::MESSAGE)
    @sql_state = sql_state
    super(message)
  end
end

