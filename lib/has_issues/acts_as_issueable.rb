require 'has_issues/issueable_config'

module HasIssues
  module ActsAsIssueable
    def self.included(base)
      base.class_attribute :is_issueable
      base.is_issueable = false
      base.extend(ClassMethods)
    end

    module ClassMethods
      def acts_as_issueable(options = {})
        class_eval do
          cattr_accessor :issueable_config
          self.issueable_config = HasIssues::IssueableConfig.new(options)
          self.is_issueable = true

          has_many :issues, as: :issueable,
                            class_name: 'HasIssues::Issue'

          validates_presence_of :issue

        end
      end

    end
  end
end

ActiveRecord::Base.send :include, HasIssues::ActsAsIssueable