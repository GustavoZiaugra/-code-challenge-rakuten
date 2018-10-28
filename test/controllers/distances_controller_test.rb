require 'test_helper'

class DistancesControllerTest < ActionDispatch::IntegrationTest

  test "Create Distance" do
      post '/api/v1/distance', params: 'A B 5'
      assert_response :ok
      result = JSON.parse(response.body)
      assert_equal "Distance created or updated with success", result["message"]
    end

  test "Error when send more or less than 3 params" do
    post '/api/v1/distance', params: 'A 5'
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Amount of parameters are invalid", result["message"]

    post '/api/v1/distance', params: 'A B 5 F'
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Amount of parameters are invalid", result["message"]
  end

  test "Try to Create a Distance with params distance as a string" do
    post '/api/v1/distance', params: 'A B C'
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Some params are invalid", result["message"]
  end

  test "Try to Create a Distance without params" do
    post '/api/v1/distance', params: ''
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "There are no params", result["message"]
  end

end
