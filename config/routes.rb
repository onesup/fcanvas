Fcanvas::Application.routes.draw do

  get "page_tab/index"
  get "page_tab/fan_gate"
  get "m/index"
  root 'home#index'
  get 'canvas' => 'home#canvas'
  get 'page_tab' => 'page_tab#index'
  get 'mobile' => 'm#index'
  get 'page_tab_gate' => 'page_tab#fan_gate'
  get 'mobile_gate' => 'm#fan_gate'
  post 'page_tab' => 'home#index'
  get 'page_tab' => 'home#index'
  get 'please_like_this_page' => 'home#please_like_this_page'
  
  resources :wall_posts, only: [:create]
end
