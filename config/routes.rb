Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post 'store' => 'data#store'
      get 'compute' => 'data#compute'
    end
  end
end
