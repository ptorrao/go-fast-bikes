Factory.define :user do |user|
  user.name                  "Mickey Mouse"
  user.email                 "mickey.mouse@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end