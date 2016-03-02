Rails.application.routes.draw do
  get '/index' => "home#index"
  get "/about" => "home#about"

  root "home#index"
end
