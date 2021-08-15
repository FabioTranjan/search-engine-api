# frozen_string_literal: true

Rails.application.routes.draw do
  get '/search', to: 'search#search'
end
