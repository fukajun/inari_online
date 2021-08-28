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
    resources :studies, only: [:index, :show, :edit, :update, :destroy]
    resources :payments, only: [:index, :edit, :update, :destroy]
    resources :calendars, only: [:index, :update]
    resources :notifications, only: [:index, :new, :create, :show, :destroy]
  end

  get 'admins/top'


  # 受講生
  get 'onlines/top'

  devise_for :onlines, controllers:{
  	sessions:      "onlines/sessions",
		passwords:     "onlines/passwords",
		registrations: "onlines/registrations"
  }

  devise_scope :online do
    get "onlines/sign_up/policy" => "onlines/registrations#policy", as: "online_policy"
    post "onlines/sign_up/confirm", to: "onlines/registrations#confirm"
    get "onlines/sign_up/complete/:id", to: "onlines/registrations#complete", as: "onlines_sign_up_complete"
  end

  resources :onlines, only: [:show, :edit, :update]
  resources :studies, only: [:index, :show]
  resources :payments, only: [:index, :create]
  resources :notifications, only: [:show]

  namespace :math do
    resources :ia_first, only: [:index, :update]
    get "ia_first/:id/test", to: "ia_first#test", as: "ia_first_test"
    get "ia_first/:id/test_answer", to: "ia_first#test_answer", as: "ia_first_test_answer"
    get "ia_first/:id/exercise", to: "ia_first#exercise", as: "ia_first_exercise"
    get "ia_first/:id/exercise_answer", to: "ia_first#exercise_answer", as: "ia_first_exercise_answer"
    get "ia_first/postphone", to: "ia_first#postphone", as: "ia_first_postphone"
  end

end
