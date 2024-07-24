# frozen_string_literal: true

Rails.application.routes.draw do
  resources :organizations do
    resources :payroll_periods, except: [:show]
  end

  root 'organizations#index'
end
