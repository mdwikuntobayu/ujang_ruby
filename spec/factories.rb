FactoryGirl.define do
	factory :user do |user|
		user.id "1"
		user.name "mdwikuntobayu"
		user.email "mdwikuntobayu@gmail.com"
		user.password "foobar"
		user.password_confirmation "foobar"
	end
end
