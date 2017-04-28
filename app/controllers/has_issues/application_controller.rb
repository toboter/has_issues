module HasIssues
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_user
    layout 'application'

    protected

    def set_user
      @user = HasIssues.current_user_proc.call(self)
    end

  end
end
