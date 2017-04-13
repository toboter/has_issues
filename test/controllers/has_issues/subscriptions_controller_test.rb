require 'test_helper'

module HasIssues
  class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @subscription = has_issues_subscriptions(:one)
    end

    test "should get index" do
      get subscriptions_url
      assert_response :success
    end

    test "should get new" do
      get new_subscription_url
      assert_response :success
    end

    test "should create subscription" do
      assert_difference('Subscription.count') do
        post subscriptions_url, params: { subscription: { issue_id: @subscription.issue_id, subscriber_id: @subscription.subscriber_id, subscriber_type: @subscription.subscriber_type } }
      end

      assert_redirected_to subscription_url(Subscription.last)
    end

    test "should show subscription" do
      get subscription_url(@subscription)
      assert_response :success
    end

    test "should get edit" do
      get edit_subscription_url(@subscription)
      assert_response :success
    end

    test "should update subscription" do
      patch subscription_url(@subscription), params: { subscription: { issue_id: @subscription.issue_id, subscriber_id: @subscription.subscriber_id, subscriber_type: @subscription.subscriber_type } }
      assert_redirected_to subscription_url(@subscription)
    end

    test "should destroy subscription" do
      assert_difference('Subscription.count', -1) do
        delete subscription_url(@subscription)
      end

      assert_redirected_to subscriptions_url
    end
  end
end
