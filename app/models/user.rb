class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :comments, dependent: :destroy 
  has_many :orders
  has_one_attached :avatar

  validate :image_type

  def image_type
    if avatar.attached?
  		if !avatar.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'Image needs to be JPEG or PNG')
      end
    end
  end
end
