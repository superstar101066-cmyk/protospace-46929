class PrototypesController < ApplicationController
  # ログインしていないユーザーをログイン画面へリダイレクトさせる
  # index（トップページ）とshow（詳細ページ）は、ログインしていなくても見れるように設定
  before_action :authenticate_user!, except: [:index, :show]

  def index # 一覧表示用の処理
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create # 保存のための処理
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      # 保存されたときはルートパス（トップページ）に戻る
      redirect_to root_path
    else
      # 保存されなかったときは新規投稿ページへ戻る
      # renderを用いることで、入力済みの項目（画像以外）が保持される
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # Pathパラメータ（URLの末尾の数字）を使って、データベースから1件取得
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    #プロトタイプに紐づく全てのコメントを取得し、ユーザー情報もまとめて取得（includes）する
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    # 投稿者本人でない場合はトップページへ戻す
    unless current_user.id == @prototype.user_id
      redirect_to root_path
    end
    @comment = Comment.new

  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
       redirect_to prototype_path(@prototype) # 更新後は詳細ページへ
    else
      render :edit, status: :unprocessable_entity # 失敗時は編集ページを再表示
    end
  end

  def destroy
    # 削除対象のプロトタイプを取得
    prototype = Prototype.find(params[:id])
    # データベースから削除
    prototype.destroy
    # トップページへリダイレクト
    redirect_to root_path
  end

  private

  def prototype_params
    # title, catch_copy, concept, imageを許可し、現在ログインしているユーザーのID(current_user.id)をmergeする
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

