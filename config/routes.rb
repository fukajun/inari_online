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
    resources :calendars, only: [:update]
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
  resources :notifications, only: [:index, :show]
  resources :reports, only: [:index]

  namespace :math do
    resources :ia_first, only: [:index, :update]
    get "ia_first/:id/test", to: "ia_first#test", as: "ia_first_test"
    get "ia_first/:id/test_answer", to: "ia_first#test_answer", as: "ia_first_test_answer"
    get "ia_first/:id/exercise", to: "ia_first#exercise", as: "ia_first_exercise"
    get "ia_first/:id/exercise_answer", to: "ia_first#exercise_answer", as: "ia_first_exercise_answer"
    get "ia_first/postphone", to: "ia_first#postphone", as: "ia_first_postphone"

    resources :ia_second, only: [:index, :update]
    get "ia_second/:id/test", to: "ia_second#test", as: "ia_second_test"
    get "ia_second/:id/test_answer", to: "ia_second#test_answer", as: "ia_second_test_answer"
    get "ia_second/:id/exercise", to: "ia_second#exercise", as: "ia_second_exercise"
    get "ia_second/:id/exercise_answer", to: "ia_second#exercise_answer", as: "ia_second_exercise_answer"
    get "ia_second/postphone", to: "ia_second#postphone", as: "ia_second_postphone"

    resources :iib_first, only: [:index, :update]
    get "iib_first/:id/test", to: "iib_first#test", as: "iib_first_test"
    get "iib_first/:id/test_answer", to: "iib_first#test_answer", as: "iib_first_test_answer"
    get "iib_first/:id/exercise", to: "iib_first#exercise", as: "iib_first_exercise"
    get "iib_first/:id/exercise_answer", to: "iib_first#exercise_answer", as: "iib_first_exercise_answer"
    get "iib_first/postphone", to: "iib_first#postphone", as: "iib_first_postphone"

    resources :iib_second, only: [:index, :update]
    get "iib_second/:id/test", to: "iib_second#test", as: "iib_second_test"
    get "iib_second/:id/test_answer", to: "iib_second#test_answer", as: "iib_second_test_answer"
    get "iib_second/:id/exercise", to: "iib_second#exercise", as: "iib_second_exercise"
    get "iib_second/:id/exercise_answer", to: "iib_second#exercise_answer", as: "iib_second_exercise_answer"
    get "iib_second/postphone", to: "iib_second#postphone", as: "iib_second_postphone"

    resources :iiic_first, only: [:index, :update]
    get "iiic_first/:id/test", to: "iiic_first#test", as: "iiic_first_test"
    get "iiic_first/:id/test_answer", to: "iiic_first#test_answer", as: "iiic_first_test_answer"
    get "iiic_first/:id/exercise", to: "iiic_first#exercise", as: "iiic_first_exercise"
    get "iiic_first/:id/exercise_answer", to: "iiic_first#exercise_answer", as: "iiic_first_exercise_answer"
    get "iiic_first/postphone", to: "iiic_first#postphone", as: "iiic_first_postphone"

    resources :iiic_second, only: [:index, :update]
    get "iiic_second/:id/test", to: "iiic_second#test", as: "iiic_second_test"
    get "iiic_second/:id/test_answer", to: "iiic_second#test_answer", as: "iiic_second_test_answer"
    get "iiic_second/:id/exercise", to: "iiic_second#exercise", as: "iiic_second_exercise"
    get "iiic_second/:id/exercise_answer", to: "iiic_second#exercise_answer", as: "iiic_second_exercise_answer"
    get "iiic_second/postphone", to: "iiic_second#postphone", as: "iiic_second_postphone"

    resources :ex1_first, only: [:index, :update]
    get "ex1_first/:id/lecture", to: "ex1_first#lecture", as: "ex1_first_lecture"
    get "ex1_first/:id/exercise", to: "ex1_first#exercise", as: "ex1_first_exercise"
    get "ex1_first/:id/homework", to: "ex1_first#homework", as: "ex1_first_homework"
    get "ex1_first/:id/test", to: "ex1_first#test", as: "ex1_first_test"
    get "ex1_first/:id/test_answer", to: "ex1_first#test_answer", as: "ex1_first_test_answer"
    get "ex1_first/postphone", to: "ex1_first#postphone", as: "ex1_first_postphone"

    resources :ex1_second, only: [:index, :update]
    get "ex1_second/:id/lecture", to: "ex1_second#lecture", as: "ex1_second_lecture"
    get "ex1_second/:id/exercise", to: "ex1_second#exercise", as: "ex1_second_exercise"
    get "ex1_second/:id/homework", to: "ex1_second#homework", as: "ex1_second_homework"
    get "ex1_second/:id/test", to: "ex1_second#test", as: "ex1_second_test"
    get "ex1_second/:id/test_answer", to: "ex1_second#test_answer", as: "ex1_second_test_answer"
    get "ex1_second/postphone", to: "ex1_second#postphone", as: "ex1_second_postphone"

    resources :ex2_first, only: [:index, :update]
    get "ex2_first/:id/lecture", to: "ex2_first#lecture", as: "ex2_first_lecture"
    get "ex2_first/:id/exercise", to: "ex2_first#exercise", as: "ex2_first_exercise"
    get "ex2_first/:id/homework", to: "ex2_first#homework", as: "ex2_first_homework"
    get "ex2_first/:id/test", to: "ex2_first#test", as: "ex2_first_test"
    get "ex2_first/:id/test_answer", to: "ex2_first#test_answer", as: "ex2_first_test_answer"
    get "ex2_first/postphone", to: "ex2_first#postphone", as: "ex2_first_postphone"

    resources :ex2_second, only: [:index, :update]
    get "ex2_second/:id/lecture", to: "ex2_second#lecture", as: "ex2_second_lecture"
    get "ex2_second/:id/exercise", to: "ex2_second#exercise", as: "ex2_second_exercise"
    get "ex2_second/:id/homework", to: "ex2_second#homework", as: "ex2_second_homework"
    get "ex2_second/:id/test", to: "ex2_second#test", as: "ex2_second_test"
    get "ex2_second/:id/test_answer", to: "ex2_second#test_answer", as: "ex2_second_test_answer"
    get "ex2_second/postphone", to: "ex2_second#postphone", as: "ex2_second_postphone"

    resources :ex3_first, only: [:index, :update]
    get "ex3_first/:id/lecture", to: "ex3_first#lecture", as: "ex3_first_lecture"
    get "ex3_first/:id/exercise", to: "ex3_first#exercise", as: "ex3_first_exercise"
    get "ex3_first/:id/homework", to: "ex3_first#homework", as: "ex3_first_homework"
    get "ex3_first/:id/test", to: "ex3_first#test", as: "ex3_first_test"
    get "ex3_first/:id/test_answer", to: "ex3_first#test_answer", as: "ex3_first_test_answer"
    get "ex3_first/postphone", to: "ex3_first#postphone", as: "ex3_first_postphone"

    resources :ex3_second, only: [:index, :update]
    get "ex3_second/:id/lecture", to: "ex3_second#lecture", as: "ex3_second_lecture"
    get "ex3_second/:id/exercise", to: "ex3_second#exercise", as: "ex3_second_exercise"
    get "ex3_second/:id/homework", to: "ex3_second#homework", as: "ex3_second_homework"
    get "ex3_second/:id/test", to: "ex3_second#test", as: "ex3_second_test"
    get "ex3_second/:id/test_answer", to: "ex3_second#test_answer", as: "ex3_second_test_answer"
    get "ex3_second/postphone", to: "ex3_second#postphone", as: "ex3_second_postphone"
  end

  #保護者
  get "parents/sign_in", to: "parents/sessions#new", as: "new_parent_session"
  post "parents/sign_in", to: "parents/sessions#create", as: "parent_session"
  delete "parents/sign_out", to: "parents/sessions#destroy", as: "destroy_parent_session"

end
