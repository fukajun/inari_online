Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/top'
  get 'homes/about'

  devise_for :admins

  devise_for :onlines, controllers:{
  	sessions:      "onlines/sessions",
		passwords:     "onlines/passwords",
		registrations: "onlines/registrations" 
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
