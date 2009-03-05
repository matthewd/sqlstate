
require 'sqlstate/modules'

class SqlState < StandardError
  extend SqlStateRoot

  SQL_STATE = 'HY000'
  MESSAGE = 'Unrecognised SQL Error'

  attr_reader :sql_state
  def initialize(sql_state=self.class::SQL_STATE, message=self.class::MESSAGE)
    @sql_state = sql_state
    super(message)
  end
end

