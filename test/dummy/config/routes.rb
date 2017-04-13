Rails.application.routes.draw do
  mount HasIssues::Engine, at: "/", as: "has_issues"

  resources :examples do
    mount HasIssues::Engine, at: "/", as: "has_issues"
  end
  resources :subjects do
    mount HasIssues::Engine, at: "/", as: "has_issues"
  end

end
