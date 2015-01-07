class User < ActiveRecord::Base
	has_many	:posts
	has_many	:comments
	validates :username, :presence => { :message => "Username cannot be empty." }
	validates	:username, :uniqueness => { :message => "Username already exists."}
	validates :password, :length => { :minimum =>6, :too_short => "Password must be at least 6 characters long."}
end
