# frozen_string_literal: true

Rails.application.routes.draw do
  resources :reviews, except: %i[show new edit]
  devise_for :admins
  resources :rooms do
    resource :booking, only: %i[new create show]
    resources :images, only: %i[index create destroy]
  end
  get 'rooms/:room_id/images/edit', to: 'images#edit'
  patch 'rooms/:id/image', to: 'rooms#delete_image'
  resources :bookings, only: %i[index update destroy]
  resolve('Booking') { [:booking] }
  post 'bookings/csv', to: 'bookings#generate_csv'
  post 'bookings/xlsx', to: 'bookings#generate_xlsx'
  get 'bookings/statistics', to: 'bookings#statistics'
  patch '/', to: 'home#update'
  root to: 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
