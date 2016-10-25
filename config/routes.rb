require 'sidekiq/web'
Rails.application.routes.draw do
  defaults format: 'json' do
    resources :data_requests
    resources :metrics
    resources :projects
    resources :split_user_variants
    resources :splits
    resources :variants

    root 'application#root'
    mount Sidekiq::Web => '/sidekiq'
  end
end
