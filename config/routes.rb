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

  resources :health, only: [:index]
end
