module HasIssues
  class Issue < ApplicationRecord

    belongs_to :closer, polymorphic: true
    belongs_to :issuer, polymorphic: true
    belongs_to :issueable, polymorphic: true

    has_many :comments, dependent: :destroy
    has_many :subscriptions, dependent: :destroy

    validates_presence_of :issueable, :unless => :is_closed?
    validates_presence_of :issuer, :unless => :is_closed?

    accepts_nested_attributes_for :comments

    def ordered_comments(unfiltered = false)
      vc = unfiltered ? comments : filtered_comments
      case config.comment_order.to_sym
      when :l then vc.order('created_at DESC')
      when :e then vc.order('created_at ASC')
      else vc
      end
    end

    def is_closed?
      !closed_at.blank?
    end

    def close(user = nil)
      return false if is_closed?
      self.closed_at = Time.now
      self.closer = user
      save
    end

    def reopen
      return false unless is_closed? && !issueable.nil?
      self.closed_at = nil
      save
    end


  end
end
