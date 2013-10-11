Fcanvas::Application.routes.draw do

  get "canvas/index"
  root 'home#index'
  get 'canvas' => 'home#canvas'
  post 'page_tab' => 'home#index'
  get 'page_tab' => 'home#index'
  get 'please_like_this_page' => 'home#please_like_this_page'
  
  resources :wall_posts, only: [:create]
end
