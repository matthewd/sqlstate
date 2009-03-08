require File.dirname(__FILE__) + '/test_helper.rb'

class TestSqlstate < Test::Unit::TestCase

  def test_defined_class_can_be_retrieved
    root = SqlState.dup
    root.define_class 'TT', 'Test Error Class'
    assert_equal 'TT000', root.for('TT000')::SQL_STATE
  end

  def test_for_returns_class
    assert_instance_of Class, SqlState.for('25008')
  end

  def test_specific_state_is_subclass_of_parent_state
    assert_operator SqlState.for('25008'), :<, SqlState.for('25000')
  end

  def test_base_state_is_subclass_of_generic_state
    assert_operator SqlState.for('25000'), :<, SqlState.for('00000')
  end

end
