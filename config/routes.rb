Rails.application.routes.draw do
  # Route configuration for devise
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {
               sessions: 'user_sessions',
               registrations: 'user_registrations'
             },
             defaults: {
               format: :json
             }

  get '/me', to: 'user#me'

  namespace :api do
    resources :keywords, only: [:index] do
      collection do
        post 'batch', to: 'keywords#batch'
      end
    end
  end

  resources :health, only: [:index]
end
