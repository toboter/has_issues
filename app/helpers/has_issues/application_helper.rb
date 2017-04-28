module HasIssues
  module ApplicationHelper

    # Returns a dynamic path based on the provided parameters
    def issueable_issue_path(issueable, issue)
       issueable.blank? ? 
         eval("main_app.#{issue.issueable.class.name.downcase+'_' unless issue.issueable.blank?}has_issues_path#{'(' + issue.issueable.class.name.downcase + '_id: ' + issue.issueable.id.to_s + ')' unless issue.issueable.blank?}") + "/issues/#{issue.id.to_s}" : 
         url_for(issue)
     # eval("#{issueable.class.name.downcase+'_' unless issueable.blank?}has_issues_path#{'(' + issueable.class.name.downcase + '_id: ' + issueable.id.to_s + ')' unless issueable.blank?}") + "/issues/#{issue.id.to_s}"
    end
    
    def markdown(text)
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
      options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        footnotes: false
      }
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
    
  end
end
