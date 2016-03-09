Rails.application.routes.draw do
  get '/index' => "home#index"
  get "/about" => "home#about"

  resources :projects do
    resources :tasks
  end
  patch '/projects/:project_id/tasks/:id/done(.:format)' => "tasks#done", as: 'project_task_done'

  resources :discussions do
    resources :comments
  end

  resources :users
  resources :sessions ,only: [:new,:create,:destroy]

  post "/user/password" => "users#password", as: 'user_password'
  patch "/user/password_update" => "users#password_update", as: 'update_user_password'

  resources :projects do
    resources :favourite_projects, only: [:create,:destroy]
  end

  root "home#index"
end
