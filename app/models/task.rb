class Task < ApplicationRecord 
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels, source: :label
  has_many_attached :images
  # has_one_attached :image
  
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  paginates_per 7

  scope :title_search, -> (title) { where('title LIKE ?', "%#{title}%")}
  scope :status_search, -> (status) { where('status LIKE ?', "%#{status}%")}
  scope :limit_sort, -> { order(sort_expired: :ASC)}
  scope :nil_limit, -> { where.not(sort_expired: nil)}

  enum priority: { Low: 0, Mid: 1, High: 2}

  def start_time
    self.sort_expired
  end 
end