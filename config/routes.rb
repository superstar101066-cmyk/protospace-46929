Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  # prototypesの中にcommentsを（入れ子）にする
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: :create
  end

  resources :users, only: :show
end
