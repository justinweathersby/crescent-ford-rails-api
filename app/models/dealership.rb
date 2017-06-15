class Dealership < ApplicationRecord
  resourcify

  has_many :users

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  has_attached_file :background_image, styles: { medium: "600x600>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  # -- For socket.io rooms
 def unique_id
   ENV['IONIC_APP_ID'] + '.' + self.id.to_s
 end
end
