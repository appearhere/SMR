Rails.application.routes.draw do
  resources :jobs, only: %i{ index } do
    resources :candidates
  end

  root 'jobs#index'
end

