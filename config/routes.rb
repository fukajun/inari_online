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


  # 受講生
  get "onlines/policy" => "onlines#policy", as: "online_policy"
  get "onlines/:id/delete_me" => "onlines#delete_me", as: "online_delete_me"
  put "onlines/:id/delete_me" => "onlines#withdraw", as: "online_withdraw"

  devise_for :onlines, controllers:{
  	sessions:      "onlines/sessions",
		passwords:     "onlines/passwords",
		registrations: "onlines/registrations"
  }

  devise_scope :online do
    post "onlines/sign_up/confirm", to: "onlines/registrations#confirm"
    get "onlines/sign_up/complete", to: "onlines/registrations#complete"
  end

  resources :onlines, only: [:show, :edit, :update]

end
