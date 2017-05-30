Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/createproject', to: 'projects#create'
      get '/requestproject', to: 'projects#show'
    end
  end
end
