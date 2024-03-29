Rails.application.routes.draw do
  
  # root "posts#index"

  namespace :api, defaults: { format: "json" } do
    resources :notes
    #get "notes/archived" => "notes#list_archived_notes"
    get "/user" => "users#show"
    put "/user" => "users#update"
    delete "/user" => "users#destroy"
    post "/user" => "users#create"
    post "login" => "authentication#login"
    post "/user/create" => "users#create"
    patch "/notes/:id/toggle" => "notes#toggle"
    get "/categories" => "categories#index"
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end