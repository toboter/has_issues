module HasIssues
  class Comment < ApplicationRecord
    belongs_to :issue
    belongs_to :creator, polymorphic: true
    belongs_to :editor, polymorphic: true

    validates_presence_of :creator, :on => :create
    validates_presence_of :editor, :on => :update
    validates_presence_of :issue
    validates_presence_of :body

    validates_uniqueness_of :body,
      :scope => [:creator_type, :creator_id, :issue_id],
      :message => I18n.t('has_issues.comment.errors.double_posted')

    def is_modified?
      !editor.nil?
    end

    def is_latest?
      issue.comments.last == self
    end

  end
end
