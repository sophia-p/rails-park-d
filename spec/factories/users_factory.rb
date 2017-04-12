FactoryGirl.define do
	factory :user do 
		username "johndoe"
		email "johndoe@email.com"
		password "password"
	end

	# factory :user2, class: User do
	# 	username "janesmith"
	# 	email "janesmith@email.com"
	# 	password "password"
	# end	

	# factory :user3, class: User do
	# 	username "hansolo"
	# 	email "hansolo@email.com"
	# 	password "password"
	# end
	# factory :user4, class: User do
	# 	username "mrrogers"
	# 	email "mrrogers@email.com"
	# 	password "password"
	# end	
	# factory :user5, class: User do
	# 	username "bettywhite"
	# 	email "bettywhite@email.com"
	# 	password "password"
	# end			
end