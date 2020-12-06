Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  devise_for :admins

  devise_for :students, controllers:{
  	sessions:      "students/sessions",
		passwords:     "students/passwords",
		registrations: "students/registrations" 
  }
  root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
