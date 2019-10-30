class User < ApplicationRecord
  has_one_attached :avatar
  
  has_secure_password
  before_validation {email.downcase!}
  before_destroy :least_one
  # before_update :thumbnail

  has_many :tasks , dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups, source: :group
  
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }


  private

  # def thumbnail
  #   return self.avatar.variant(resize: '400 x 250')
  # end

  def least_one
    if self.admin? && User.all.where(admin: "true").count == 1
      # return false　ではなく throw :abort
      throw :abort
    end
  end

end

