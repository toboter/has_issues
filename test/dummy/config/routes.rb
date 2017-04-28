Rails.application.routes.draw do
  # has_issues_for [:examples, :subjects]
  # Alle HasIssues engines müssen an der gleichen Stelle gemounted sein. Also at: "/" oder at: "/e"
  
  mount HasIssues::Engine, at: "/x"

  resources :examples do 
    mount HasIssues::Engine, at: "/e"
  end
  resources :subjects do
    mount HasIssues::Engine, at: "/s"
  end


end
