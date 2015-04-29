Rails.application.routes.draw do
  resources :jobs, only: %i{ index }
  root 'jobs#index'
end

