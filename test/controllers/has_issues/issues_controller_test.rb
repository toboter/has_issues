require 'test_helper'

module HasIssues
  class IssuesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @issue = has_issues_issues(:one)
    end

    test "should get index" do
      get issues_url
      assert_response :success
    end

    test "should get new" do
      get new_issue_url
      assert_response :success
    end

    test "should create issue" do
      assert_difference('Issue.count') do
        post issues_url, params: { issue: { closed_at: @issue.closed_at, closer_id: @issue.closer_id, closer_type: @issue.closer_type, issueable_id: @issue.issueable_id, issueable_type: @issue.issueable_type, issuer_id: @issue.issuer_id, issuer_type: @issue.issuer_type, title: @issue.title } }
      end

      assert_redirected_to issue_url(Issue.last)
    end

    test "should show issue" do
      get issue_url(@issue)
      assert_response :success
    end

    test "should get edit" do
      get edit_issue_url(@issue)
      assert_response :success
    end

    test "should update issue" do
      patch issue_url(@issue), params: { issue: { closed_at: @issue.closed_at, closer_id: @issue.closer_id, closer_type: @issue.closer_type, issueable_id: @issue.issueable_id, issueable_type: @issue.issueable_type, issuer_id: @issue.issuer_id, issuer_type: @issue.issuer_type, title: @issue.title } }
      assert_redirected_to issue_url(@issue)
    end

    test "should destroy issue" do
      assert_difference('Issue.count', -1) do
        delete issue_url(@issue)
      end

      assert_redirected_to issues_url
    end
  end
end
