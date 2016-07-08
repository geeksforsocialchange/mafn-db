Rails.application.routes.draw do

  resources :volunteers

  resources :representatives

  resources :partners

  resources :projects

  resources :organisations

  resources :question_lists

  resources :attendances

  resources :member_locations

  resources :locations
  resources :question_responses
  resources :question_sets do
    member do
      get 'respond/:member', to: 'question_sets#respond'
      post 'respond/:member', to: 'question_sets#batch_create'
      get 'respond', to: 'question_sets#show'
    end
  end
  resources :questions
  post 'update_calendar', to: 'events#update_calendar'
  resources :events
  resources :members

  get 'welcome/index'

  resources :exports, only: [:index] do
    collection do
      get 'events'
      get 'events_demographics'
      get 'events_feedback'
      get 'questionnaire'
      get 'members'
      get 'followup_questionnaire', to: 'exports#questionnaire', defaults: { followup: true }
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
