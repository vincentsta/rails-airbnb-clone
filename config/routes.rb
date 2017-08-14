Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#home'
  resources :jobs, only: [ :index, :show] do
    resources :job_requests, only: [ :create ]
  end
  resources :user, only: [ :show]

  namespace :recruiter do
    # TODO: pour la vue recruteur - controlleur non cree (P2)
    resources :companies, only: [:show]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
