require File.dirname(__FILE__) + '/test_helper.rb'
require 'sqlstate/postgres'

class TestPostgres < Test::Unit::TestCase

  def test_is_subclass_of_root
    assert_operator SqlState::PostgresError, :<, SqlState
  end

  def test_subclass_of_generic_class
    assert_operator SqlState::PostgresError.for('40P01'), :<, SqlState::PostgresError.for('40000')
  end

  def test_custom_class_subclasses_vendor_root
    assert_operator SqlState::PostgresError.for('P0001'), :<, SqlState::PostgresError
  end

  def test_custom_subclass_doesnt_pollute_global_space
    # Unknown state code returns root
    assert_equal SqlState.for('40P01'), SqlState
  end

  def test_custom_class_doesnt_pollute_global_space
    # Unknown state code returns root
    assert_equal SqlState.for('P0000'), SqlState
  end

end
