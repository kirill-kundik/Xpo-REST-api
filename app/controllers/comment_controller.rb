class CommentController < ApplicationController
  load_and_authorize_resource

  # GET /comment
  def index
    render_resource @comments
  end

  # POST /comment
  def create
    authorize_create! model: Comment
    @comment = Comment.create comment_params
    render_resource @comment
  end

  # GET /comment/{id}
  def show
    render_resource @comment
  end

  # PUT /comment/{id}
  def update
    @comment.update comment_params
    render_resource @comment
  end

  # DELETE /comment/{id}
  def destroy
    @comment.destroy
    render_resource @comment
  end

  private

  def comment_params
    params.permit :text, :user_id, :expo_id
  end
end
