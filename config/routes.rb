HasIssues::Engine.routes.draw do
  resources :issues do
    resources :comments
    resources :subscriptions

    member do
      put 'close'
      put 'reopen'
    end
  end
end