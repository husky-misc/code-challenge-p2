FactoryBot.define do
    factory :history do
      ip { "172.31.255.255" }
      content { [10, 5, 9, 8] }
    end
end