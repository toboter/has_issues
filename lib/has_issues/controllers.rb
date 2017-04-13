require 'has_issues/shared_helper'

module HasIssues
  module Controllers
    def self.included(base)
      base.helper HasIssues::SharedHelper
    end
    
    protected

    def has_issues_set_new_comment(issue, user)
      return if issue.nil? || issue.config.new_comment_style != :t
      new_comment = Comment.new
      new_comment.issue = issue
      new_comment.creator = user
      @new_comment = new_comment # if new_comment.can_be_created_by?(user)
    end
    
    def has_issues_issues_show(issueable)
      user = HasIssues.current_user_proc.call(self)	
      issues = issueable.issues
      # raise Commontator::SecurityTransgression unless thread.can_be_read_by?(user)
      # issues.mark_as_read_for(user)
      # @commontator_page = params[:page] || 1
      # @commontator_per_page = params[:per_page] || thread.config.comments_per_page
      # @commontator_thread_show = true
      # commontator_set_new_comment(thread, user)
    end
  end
end

ActionController::Base.send :include, HasIssues::Controllers