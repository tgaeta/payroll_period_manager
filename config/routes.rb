Rails.application.routes.draw do
  get 'payroll_periods/index'
  get 'payroll_periods/create'
  get 'payroll_periods/update'
  get 'payroll_periods/destroy'
  get 'organizations/index'
  get 'organizations/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
