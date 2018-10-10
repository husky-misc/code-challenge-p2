Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get 'compute', to:'compute#show'
      post 'store', to:'store#create'
    end
  end
end
