FactoryBot.define do
    factory :datum do
      rotations { 3 }
      index  { 2 }
      content { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11] }
    end
end