require 'test_helper'

module HasIssues
  class CommentsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @comment = has_issues_comments(:one)
    end

    test "should get index" do
      get comments_url
      assert_response :success
    end

    test "should get new" do
      get new_comment_url
      assert_response :success
    end

    test "should create comment" do
      assert_difference('Comment.count') do
        post comments_url, params: { comment: { body: @comment.body, creator_id: @comment.creator_id, creator_type: @comment.creator_type, editor_id: @comment.editor_id, editor_type: @comment.editor_type, issues_id: @comment.issues_id } }
      end

      assert_redirected_to comment_url(Comment.last)
    end

    test "should show comment" do
      get comment_url(@comment)
      assert_response :success
    end

    test "should get edit" do
      get edit_comment_url(@comment)
      assert_response :success
    end

    test "should update comment" do
      patch comment_url(@comment), params: { comment: { body: @comment.body, creator_id: @comment.creator_id, creator_type: @comment.creator_type, editor_id: @comment.editor_id, editor_type: @comment.editor_type, issues_id: @comment.issues_id } }
      assert_redirected_to comment_url(@comment)
    end

    test "should destroy comment" do
      assert_difference('Comment.count', -1) do
        delete comment_url(@comment)
      end

      assert_redirected_to comments_url
    end
  end
end
