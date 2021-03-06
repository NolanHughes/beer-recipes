Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root "users#show"

  get '/styles/most_popular' => 'styles#most_popular'

  get '/recipes/smash_beers' => 'recipes#smash_beers'
  get '/all_recipes' => 'recipes#all_recipes', as: 'all_recipes'

  get '/fermentables' => 'fermentables#index'
  get '/hops' => 'hops#index'
  get '/yeasts' => 'yeasts#index'

  resources :recipes do
    resources :comments
  end

  resources :users, only: [:show] do
    resources :recipes
  end

end
