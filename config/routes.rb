# frozen_string_literal: true

require 'csv'

Rails.application.routes.draw do
  get 'main/index'

  get 'publications/index'
  post 'publications/upload'

  get 'author/index'
  post 'author/upload'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
end
