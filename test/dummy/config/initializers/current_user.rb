ActionController::Base.class_exec do
  helper_method :current_user

  def current_user
    @current_user ||= User.first
  end
end