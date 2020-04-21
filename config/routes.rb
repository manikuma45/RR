Rails.application.routes.draw do
  root to: 'learnings#index'

  resources :learnings do
    collection do
      get :history
      post :relearn
      post :check_item
    end
  end

  devise_for :users, controllers: {
        registrations: 'users/registrations'
}

  resources :users, only: [:show]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
