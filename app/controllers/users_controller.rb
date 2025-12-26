class UsersController < ApplicationController
  def show
    # URLの末尾にあるID（/users/1 など）を元に、特定のユーザーを取得する
    @user = User.find(params[:id])
    # そのユーザーが投稿したプロトタイプ一覧を取得する
    @prototypes = @user.prototypes
  end
end
