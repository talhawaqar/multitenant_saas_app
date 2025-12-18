class UsersController < ApplicationController
  before_action :fetch_user, only: [:show, :resend_invitation]
  def index
    @users = User.all
  end

  def resend_invitation
    if @user.invitation_accepted_at.present?
      redirect_to users_path, alert: "User with email #{@user.email} already accepted the invitation"
    else
      @user.invite!
      redirect_to users_path, notice: "Invitation resend to User with email #{@user.email}"
    end
  end

  def show
  end

  private
    def fetch_user
      @user = User.find(params[:id])
    end
end
