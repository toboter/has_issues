module HasIssues
  class IssueableConfig
    HasIssues::ISSUEABLE_ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end
  
    def initialize(options = {})
      HasIssues::ISSUEABLE_ATTRIBUTES.each do |attribute|
        self.send attribute.to_s + '=', options[attribute] || HasIssues.send(attribute)
      end
    end
  end
end