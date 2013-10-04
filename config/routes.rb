Fcanvas::Application.routes.draw do

  root 'home#index'
  post 'page_tab' => 'home#index'
  get 'page_tab' => 'home#index'
  get 'pleas_like_this_page' => 'home#please_like_this_page'
end
