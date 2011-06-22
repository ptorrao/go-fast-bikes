Factory.define :user do |user|
  user.name                  "Mickey Mouse"
  user.email                 "mickey.mouse@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :order do |order|
  order.notes "I need this to be dispatched as soon as possible!"
  order.association :user
end