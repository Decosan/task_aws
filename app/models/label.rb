class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy

  validates :title, presence: true, length: {maximum: 25}, uniqueness: true
end
