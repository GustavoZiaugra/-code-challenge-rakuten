require 'test_helper'

class CostsControllerTest < ActionDispatch::IntegrationTest

  test "When params missing show error" do
    get '/api/v1/cost?origin=A&destination=C&weight='
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Amount of parameters are invalid", result["message"]

    get '/api/v1/cost?origin=&destination=C&weight=9'
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Amount of parameters are invalid", result["message"]

    get '/api/v1/cost?origin=A&destination=&weight=10'
    assert_response :unprocessable_entity
    result = JSON.parse(response.body)
    assert_equal "Amount of parameters are invalid", result["message"]
  end

   test "Validates if weight is invalid" do
     get '/api/v1/cost?origin=A&destination=C&weight=-50'
     assert_response :unprocessable_entity
     result = JSON.parse(response.body)
     assert_equal "Weight is invalid", result["message"]

     get '/api/v1/cost?origin=A&destination=C&weight=51'
     assert_response :unprocessable_entity
     result = JSON.parse(response.body)
     assert_equal "Weight is invalid", result["message"]

     get '/api/v1/cost?origin=A&destination=C&weight=F'
     assert_response :unprocessable_entity
     result = JSON.parse(response.body)
     assert_equal "Weight is invalid", result["message"]
   end

   test "validate if cost calculation is valid" do
     Distance.create(origin: "A", destination: "B", distance: 10)
     Distance.create(origin: "B", destination: "C", distance: 15)
     Distance.create(origin: "A", destination: "C", distance: 30)
     get '/api/v1/cost?origin=A&destination=C&weight=5'
     assert_response :ok
     assert_equal "18.75", response.body
   end

   test "validate if no path return error" do
     Distance.create(origin: "A", destination: "B", distance: 10)
     Distance.create(origin: "B", destination: "C", distance: 15)
     Distance.create(origin: "A", destination: "C", distance: 30)
     get '/api/v1/cost?origin=Y&destination=Z&weight=5'
     assert_response :unprocessable_entity
     result = JSON.parse(response.body)
     assert_equal "There is no path between origin and destination", result["message"]
   end

end
