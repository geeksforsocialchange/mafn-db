Rails.application.routes.draw do

  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc'

  devise_for :users

  resources :arrangers
  resources :attendances
  resources :events
  resources :calendars do
    collection do
      get 'update_events'
    end
    member do
      get 'update_event'
    end
  end
  resources :locations
  resources :member_locations
  resources :members do
    collection do
      get 'cards'
      get 'export_preview'
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

  root 'welcome#index'
end
