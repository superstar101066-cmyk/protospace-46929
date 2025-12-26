class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  # contentカラムが空ではないことを確認するバリデーション
  validates :content, presence: true
end
