class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  
  has_one_attached :group_image
  
  def get_group_image
    (profile_image.attached?) ? group_image : 'no_image.jpg'
  end
end
