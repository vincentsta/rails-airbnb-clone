Rails.application.routes.draw do
  devise_for :users
  root to: 'jobs#home'
  resources :jobs, only: [ :index, :show] do

    collection do
      post 'filtered', to: "jobs#filter" # For filter on index page
    end
    resources :job_requests, only: [ :create, :edit, :update ]
    
  end
  resources :users, only: [ :show]

  namespace :recruiter do
    # TODO: pour la vue recruteur - controlleur non cree (P2)
    resources :companies, only: [:show]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
