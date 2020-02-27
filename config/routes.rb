Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/admin' do
    resources :users
    resources :books
    resources :libraries do
      member do
        post :assign_book
      end
    end
    post 'unassign_book', to: 'books#unassign'
  end
  root to: "homes#index"
  get 'admin_home', to: 'homes#admin_home'
  get 'author_home', to: 'homes#author_home'
end
