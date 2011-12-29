Factory.define :user do |user|
  user.name "Jacob Robertson"
  user.email "g.jacob.robertson@gmail.com"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.define :group do |group|
  group.name "The Treasury"
  group.description "The fine gentlemen and ladies of 584 N Superior Ave"
end
