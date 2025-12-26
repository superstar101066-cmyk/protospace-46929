class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype) # 保存できたら詳細ページへ
    else
      # 保存できなかった場合、詳細ページを再描画するために必要なデータを揃える
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  private
  def comment_params
    # contentを許可し、user_idとprototype_idをマージする
    # prototype_idはURL（/prototypes/:prototype_id/comments）から取得するためparams[:prototype_id]となる
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end