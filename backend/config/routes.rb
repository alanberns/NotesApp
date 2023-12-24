Rails.application.routes.draw do
  
  # root "posts#index"

  namespace :api, defaults: { format: "json" } do
    resources :notes
    #get "notes/archived" => "notes#list_archived_notes"
    resources :user
    post "login" => "authentication#create"
    #get "logout" => "authentication#destroy"
  end
  
  get "up" => "rails/health#show", as: :rails_health_check
end