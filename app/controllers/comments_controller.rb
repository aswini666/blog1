class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:content, :post_id))
    @comment.user = current_user
    @comment.save
    redirect_to @post, notice: "Comment created successfully"
  end



  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to posts_path, notice: "Comment deleted successfully"
  end
end
