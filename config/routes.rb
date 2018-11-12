Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      post 'store' => 'data#store'
      get 'compute' => 'data#compute'
      get 'histories' => 'histories#index'
      get 'admin/histories' => 'histories#admin_index'
    end
  end
end
