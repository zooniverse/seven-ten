Rails.application.routes.draw do
  defaults format: 'json' do
    resources :metrics
    resources :projects
    resources :splits
    resources :variants

    root 'application#root'
  end
end
