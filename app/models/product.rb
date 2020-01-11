class Product < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy 
	has_many :order_items
	has_many_attached :images
	validates :name, presence: true
	validates :price, presence: true
	validates :quantity, presence: true 
	validates :description, presence: true 
	validate :image_type

	after_save ThinkingSphinx::RealTime.callback_for(:product)

	def image_type
		images.each do |image|
			if !image.content_type.in?(%('image/jpeg image/png'))
				errors.add(:images, 'Image needs to be JPEG or PNG')
			end
		end 
	end 
end

