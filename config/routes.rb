Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  api_guard_routes for: 'users', controller: {
    registration: 'users/registration',
    authentication: 'users/authentication',
    passwords: 'users/passwords',
    tokens: 'users/tokens'
  }

  namespace :api do
    namespace :v1 do

      resources :contacts, only: [:index, :delete] do
        collection do
          get 'detail/:id', to: 'contacts#show', as: 'contacts_show'
          post 'import', to: 'contacts#importer', as: 'contacts_import'
          get 'import/files', to: 'contacts#imported_files', as: 'contacts_imported_files'
          get 'failed/logs', to: 'contacts#failed_contacts', as: 'contacts_failed_contacts'
        end
      end
      get 'health_check', to: 'health_check#index', as: 'health_check_base'
      get 'whoami', to: 'health_check#who_am_i', as: 'who_am_i'
    end
  end
end
