require File.dirname(__FILE__) + '/test_helper.rb'
require 'sqlstate/postgres'

class TestPostgres < Test::Unit::TestCase

  def test_is_subclass_of_root
    assert_operator SqlState::PostgresError, :<, SqlState
  end

  def test_name_of_subclass
    assert_equal 'SqlState::PostgresError::DeadlockDetected', SqlState::PostgresError.for('40P01').name
  end

  def test_subclass_of_generic_class
    assert_operator SqlState::PostgresError.for('40P01'), :<, SqlState::PostgresError.for('40000')
  end

  def test_custom_class_subclasses_vendor_root
    assert_operator SqlState::PostgresError.for('P0001'), :<, SqlState::PostgresError
  end

  def test_standard_subclass_from_vendor_root_is_same_as_from_global_root
    assert_equal SqlState::PostgresError.for('22012'), SqlState.for('22012')
  end

  def test_custom_subclass_doesnt_pollute_global_space
    # Unknown state code returns root
    assert_equal SqlState.for('40P01'), SqlState
  end

  def test_custom_class_doesnt_pollute_global_space
    # Unknown state code returns root
    assert_equal SqlState.for('P0000'), SqlState
  end

  def test_custom_subclass_has_details_when_created
    assert_respond_to SqlState::PostgresError.create('40P01'), :details=
  end

  def test_standard_subclass_has_details_when_created_through_postgres
    assert_respond_to SqlState::PostgresError.create('22012'), :details=
  end

  def test_standard_subclass_doesnt_have_details_when_created_directly
    assert !SqlState.create('22012').respond_to?(:details=)
  end

  def test_standard_subclass_is_recognised_when_created_through_postgres
    assert_equal 'SqlState::DivisionByZero', 
      SqlState::PostgresError.for('22012').name
  end

end
