require 'has_issues/issuer_config'

module HasIssues
  module ActsAsIssuer
    def self.included(base)
      base.class_attribute :is_issuer
      base.is_issuer = false
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def acts_as_issuer(options = {})
        class_eval do
          cattr_accessor :issuer_config
          self.issuer_config = HasIssues::IssuerConfig.new(options)
          self.is_issuer = true

          has_many :issues, as: :issuer, class_name: 'HasIssues::Issue'
          has_many :comments, as: :creator, class_name: 'HasIssues::Comment'
          has_many :subsriptions, as: :subscriber, class_name: 'HasIssues::Subscription', dependent: :destroy

        end
      end
      
    end
  end
end

ActiveRecord::Base.send :include, HasIssues::ActsAsIssuer