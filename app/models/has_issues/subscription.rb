module HasIssues
  class Subscription < ApplicationRecord
    belongs_to :subscriber, polymorphic: true
    belongs_to :issue

    validates_presence_of :subscriber, :issue
    validates_uniqueness_of :issue_id, :scope => [:subscriber_type, :subscriber_id]

  end
end
