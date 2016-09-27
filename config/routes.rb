Rails.application.routes.draw do

  devise_for :users

  resources :arrangers
  resources :attendances
  resources :events
  resources :locations
  resources :member_locations
  resources :members do
    collection do
      get 'cards'
    end
    member do
      get 'card'
    end
  end
  resources :organisations
  resources :partners
  resources :projects
  resources :question_lists
  resources :question_responses
  resources :question_sets do
    member do
      get 'respond/:member', to: 'question_sets#respond'
      post 'respond/:member', to: 'question_sets#batch_create'
      get 'respond', to: 'question_sets#show'
    end
  end
  resources :questions
  resources :representatives
  resources :users
  resources :volunteers

  resources :exports, only: [:index] do
    collection do
      get 'events'
      get 'events_demographics'
      get 'events_feedback'
      get 'questionnaire'
      get 'members'
      get 'projects'
      get 'followup_questionnaire', to: 'exports#questionnaire', defaults: { followup: true }
    end
  end

  post 'update_calendar', to: 'events#update_calendar'

  root 'welcome#index'
end
