require File.dirname(__FILE__) + '/test_helper.rb'

class TestSqlstate < Test::Unit::TestCase

  def test_defined_class_can_be_retrieved
    assert_equal 'TT000', 
      SqlState.dup.class_eval {
        define_class 'TT', 'Test Error Class'
        self.for('TT000')::SQL_STATE
      }
  end

  def test_for_returns_class
    assert_instance_of Class, SqlState.for('25008')
  end

  def test_specific_state_is_subclass_of_parent_state
    assert_operator SqlState.for('25008'), :<, SqlState.for('25000')
  end

  def test_base_state_is_subclass_of_root
    assert_operator SqlState.for('25000'), :<, SqlState
  end

end
