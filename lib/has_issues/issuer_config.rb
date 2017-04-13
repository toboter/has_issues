module HasIssues
  class IssuerConfig
    HasIssues::ISSUER_ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end
  
    def initialize(options = {})
      HasIssues::ISSUER_ATTRIBUTES.each do |attribute|
        self.send attribute.to_s + '=', options[attribute] || HasIssues.send(attribute)
      end
    end
  end
end
