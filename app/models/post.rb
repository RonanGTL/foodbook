class Post < ActiveRecord::Base
	belongs_to	:user
	has_many	:comments
	validates :category, :inclusion => { :in => ["Asian","American","European","International"], :message => "You must select one from Asian, American, Indian and Western."}
	validates :title, :presence => { :message => "You must enter the title."}
	mount_uploader :image, ImageUploader
end
