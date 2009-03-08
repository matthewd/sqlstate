require File.dirname(__FILE__) + '/test_helper.rb'

class TestInstance < Test::Unit::TestCase

  def setup
    @state = SqlState.for('25008')
  end

  def test_class_name
    assert_equal 'SqlState::HeldCursorRequiresSameIsolationLevel', @state.name
  end

end
