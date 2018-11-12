class History
  include Mongoid::Document
  field :content, type: Array
  field :date, :type => Time, default: ->{ Time.now }
  field :ip, type: String
end
