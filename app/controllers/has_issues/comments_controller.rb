require_dependency "has_issues/application_controller"

module HasIssues
  class CommentsController < ApplicationController
    before_action :set_issue
    before_action :set_comment, only: [:edit, :update, :destroy]


    # GET /comments/new
    def new
      @comment = @issue.comments.new
    end

    # GET /comments/1/edit
    def edit
    end

    # POST /comments
    def create
      @comment = Comment.new(comment_params)
      @comment.creator = @user

      respond_to do |format|
        if @comment.save
          @comment.issue.reopen if @comment.issue.is_closed?
          format.html { redirect_to @issue, notice: 'Comment was successfully created.' }
          format.js
        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /comments/1
    def update
      @comment.editor = @user

      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @issue, notice: 'Comment was successfully updated.' }
          format.js
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /comments/1
    def destroy
      @comment.destroy
      
      respond_to do |format|
        format.html { redirect_to @issue, notice: 'Comment was successfully removed.' }
        format.js
      end
  end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_issue
         @issue = Issue.find(params[:issue_id])
      end

      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def comment_params
        params.require(:comment).permit(:issue_id, :creator_id, :creator_type, :editor_id, :editor_type, :body)
      end
  end
end
