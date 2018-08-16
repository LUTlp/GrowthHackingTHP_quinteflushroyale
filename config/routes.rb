Rails.application.routes.draw do


  root to: 'home#index'
  get '/qui-sommes-nous', to: 'home#who'
  get '/je-veux-y-participer', to: 'home#new'
  post '/je-veux-y-participer', to: 'home#create'
  get '/etudiant', to: 'home#etudiant'
  get '/ville', to: 'home#ville'

end
