Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  # 管理者
  devise_for :admins, controllers:{
    sessions:      "admins/sessions",
    passwords:     "admins/passwords",
    registrations: "admins/registrations"
  }

  namespace :admin do
    resources :onlines, only: [:index, :show, :edit, :update]
  end

  get 'admins/top'


  # 塾生
  devise_for :onlines, controllers:{
  	sessions:      "onlines/sessions",
		passwords:     "onlines/passwords",
		registrations: "onlines/registrations"
  }

  resources :onlines, only: [:show, :edit, :update]

  get "onlines/:id/delete_me" => "onlines#delete_me", as: "online_delete_me"
  put "onlines/:id/delete_me" => "onlines#withdraw", as: "online_withdraw"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
