require File.dirname(__FILE__) + '/test_helper.rb'

class TestInstance < Test::Unit::TestCase

  def setup
    @state = SqlState.for('25008')
  end

  def test_name_of_class
    assert_equal 'SqlState::HeldCursorRequiresSameIsolationLevel', @state.name
  end

  def test_state_code_on_instance
    assert_equal '25008', @state.new.sql_state
  end

  def test_message_on_instance
    assert_equal 'Held Cursor Requires Same Isolation Level', @state.new.message
  end

end
