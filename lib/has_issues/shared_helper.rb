module HasIssues
  module SharedHelper
    def has_issue_track(issueable)
      user = HasIssues.current_user_proc.call(self)
      issues = issueable.issues
      
      render(:partial => 'has_issues/shared/issues',
             :locals => { issues: issues,
                          issueable: issueable,
                          user: user }).html_safe
    end

    def issueable_issues_path(issueable)
      eval("#{issueable.class.name.downcase+'_' unless issueable.blank?}has_issues_path#{'(' + issueable.class.name.downcase + '_id: ' + issueable.id.to_s + ')' unless issueable.blank?}") + "/issues"
    end

    def all_issues_path
      main_app.has_issues_path + '/issues'
    end

    def has_issues_gravatar_image_tag(user, border = 1, options = {})
      email = HasIssues.has_issues_email(user) || ''
      name = HasIssues.has_issues_name(user) || ''

      base = request.ssl? ? "s://secure" : "://www"
      hash = Digest::MD5.hexdigest(email)
      url = "http#{base}.gravatar.com/avatar/#{hash}?#{options.to_query}"
      
      image_tag(url, { :alt => name,
                       :title => name,
                       :border => border })
    end
    
  end
end