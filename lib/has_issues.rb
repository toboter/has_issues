require "has_issues/engine"
require 'has_issues/controllers'
require 'bootstrap-sass'
require 'simple_form'
require 'redcarpet'
require 'turbolinks'

module HasIssues
  # Can be set in initializer only
  ENGINE_ATTRIBUTES = [
    :current_user_proc,
    :javascript_proc,
    :mentions_enabled
  ]

  # Can be set in initializer or passed as an option to acts_as_issuer
  ISSUER_ATTRIBUTES = [
    :user_name_proc,
    :user_link_proc,
    :user_avatar_proc,
    :user_email_proc,
    :user_mentions_proc
  ]
  
  # Can be set in initializer or passed as an option to has_issues
  ISSUEABLE_ATTRIBUTES = [
    :comment_filter,
    :issue_read_proc,
    :issue_moderator_proc,
    :comment_editing,
    :comment_deletion,
    :moderator_permissions,
    :comment_order,
    :new_comment_style,
    :comments_per_page,
    :email_from_proc,
    :issue_subscription,
    :email_from_proc,
    :issueable_name_proc,
    :comment_url_proc
  ]

  DEPRECATED_ATTRIBUTES = [

  ]
  
  (ENGINE_ATTRIBUTES + ISSUER_ATTRIBUTES + \
    ISSUEABLE_ATTRIBUTES).each do |attribute|
    mattr_accessor attribute
  end

  DEPRECATED_ATTRIBUTES.each do |deprecated, replacement|
    define_singleton_method(deprecated) do
      @deprecated_method_called = true
      replacement_string = (replacement.nil? ? 'No replacement is available. You can safely remove it from your configuration file.' : "Use `#{replacement.to_s}` instead.")
      warn "\n[has_issues] Deprecation: `config.#{deprecated.to_s}` is deprecated and has been disabled. #{replacement_string}\n"
    end

    define_singleton_method("#{deprecated.to_s}=") do |obj|
      send(deprecated)
    end
  end
  
  def self.configure
    @deprecated_method_called = false
    yield self
    warn "\n[has_issues] We recommend that you backup the config/initializers/has_issues.rb file, rename or remove it, run rake has_issues:install:initializers to copy the new default one, then configure it to your liking.\n" if @deprecated_method_called
  end

# -----

  def self.issuer_config(user)
    (user && user.is_issuer) ? user.issuer_config : self
  end

  def self.issueable_config(obj)
    (obj && obj.is_issueable) ? obj.issueable_config : self
  end

  def self.issuer_name(user)
    issuer_config(user).user_name_proc.call(user)
  end

  def self.issuer_link(user, routing_proxy)
    issuer_config(user).user_link_proc.call(user, routing_proxy)
  end

  def self.issuer_email(user, mailer = nil)
    issuer_config(user).user_email_proc.call(user, mailer)
  end

  def self.issuer_avatar(user, view)
    issuer_config(user).user_avatar_proc.call(user, view)
  end

  def self.issuer_mentions(user, search_phrase)
    issuer_config(user).user_mentions_proc.call(user, search_phrase)
  end

  def self.issueable_name(issueable)
    issueable_config(issueable).issueable_name_proc.call(issueable)
  end

  def self.comment_url(comment, routing_proxy)
    issueable_config(comment.issue.issueable).comment_url_proc.call(comment, routing_proxy)
  end

end

require 'has_issues/acts_as_issuer'
require 'has_issues/acts_as_issueable'