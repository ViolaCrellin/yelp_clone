class Restaurant < ActiveRecord::Base
  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating).to_i
  end

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "http://pixel.nymag.com/imgs/daily/grub/2015/10/15/15-south-park.w190.h190.2x.jpg"
 validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
