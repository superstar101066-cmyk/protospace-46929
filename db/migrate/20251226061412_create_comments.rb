class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text       :content,    null: false # コメントのテキスト
      t.references :user,       null: false, foreign_key: true # 投稿したユーザー
      t.references :prototype,  null: false, foreign_key: true # コメントされたプロトタイプ
      t.timestamps
    end
  end
end
