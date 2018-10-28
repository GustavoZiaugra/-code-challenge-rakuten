Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'distance', to: 'distances#create', as: :distance_create
      get 'cost', to: 'costs#value', as: :cost_value
    end
  end
end
