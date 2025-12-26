class Prototype < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # プロトタイプ画像との紐付け
  has_one_attached :image

  # プロトタイプの投稿に必要な情報のバリデーション
  validates :title,      presence: true # プロトタイプの名称
  validates :catch_copy, presence: true # キャッチコピー
  validates :concept,    presence: true # コンセプト
  validates :image,      presence: true # プロトタイプの画像
end
