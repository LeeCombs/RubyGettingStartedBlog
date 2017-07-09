class CommentsController < ApplicationController
  
  # Only authenticated users can delete comments
  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

  def create
    # Get the associated article of the comment, and create this comment for it
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    # Get the associated article of the comment, and remove this comment of it
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end