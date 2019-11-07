# Rails.application.routes.draw do
#   resources :articles
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# end

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :articles, only: %i[create show index] do
      get :avatar, on: :member
    end
  end
  root to: "api/articles#index"

end