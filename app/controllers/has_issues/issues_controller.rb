require_dependency "has_issues/application_controller"

module HasIssues
  class IssuesController < ApplicationController
    before_action :set_issueable
    before_action :set_issue, only: [:show, :edit, :update, :destroy, :close, :reopen]

    # GET /issues
    def index
      @issues = @issueable.blank? ? Issue.order(created_at: :desc) : @issueable.issues
    end

    # GET /issues/1
    def show
      @participants = @issue.comments.map{|c| c.creator }.uniq
    end

    # GET /issues/new
    def new
      @issue = Issue.new
      @issue.comments.new
    end

    def edit
    end

    # POST /issues
    def create
      @issue = Issue.new(issue_params)
      @issue.comments.first.creator = @user
      @issue.comments.first.issue = @issue
      @issue.issuer = @user
      @issue.issueable = @issueable

      if @issue.save
        redirect_to @issue, notice: 'Issue was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /issues/1
    def update
      if @issue.update(issue_params)
        redirect_to @issue, notice: 'Issue was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /issues/1
    def destroy
      @issue.destroy
      redirect_to issues_url, notice: 'Issue was successfully destroyed.'
    end

    # PUT /issues/1/close
    def close
      # security_transgression_unless @thread.can_be_edited_by?(@user)

      @issue.errors.add(:base, t('has_issues.thread.errors.already_closed')) \
        unless @issue.close(@user)

      # @show_all = true

      respond_to do |format|
        format.html { redirect_to [@issuebale, @issue] }
        format.js { render :show }
      end
    end
    
    # PUT /issues/1/reopen
    def reopen
      # security_transgression_unless @thread.can_be_edited_by?(@user)

      @issue.errors.add(:base, t('has_issues.thread.errors.not_closed')) \
        unless @issue.reopen

      # @show_all = true

      respond_to do |format|
        format.html { redirect_to [@issuebale, @issue] }
        format.js { render :show }
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_issueable
        @issueable = []
        params.each do |name, value|
          if name =~ /(.+)_id$/
            @issueable.push($1.classify.constantize.find(value))
          end
        end
        @issueable = @issueable.last if @issueable.length >= 1
        nil
      end

      def set_issue
        @issue = Issue.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def issue_params
        params.require(:issue).permit(:title, :closed, :comments_attributes => [:body])
      end
  end
end
