class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  def index
    @members = Member.all
  end

  def invite
    current_tenant = Tenant.first
    email = params[:email]
    user_from_email = User.where(email: email).first
    
    if user_from_email.present?
      member = Member.where(user: user_from_email, tenant: current_tenant)
      if member.present?
        redirect_to members_path, notice: "The organizatioin #{current_tenant} has already a user with email #{email}"
      else
         Member.create(user: user_from_email, tenant: current_tenant)
         redirect_to members_path, notice: "#{email} was successfully invited to join the organization #{current_tenant}"
      end
      
    elsif user_from_email.nil?
      new_user = User.invite!({email: email}, current_user) # devise invitable
      Member.create(user: new_user, tenant: current_tenant)
      redirect_to members_path, notice: "email #{email} sent to invite the tenant #{current_tenant}"
    end
  end

  # GET /members/1
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:user_id, :tenant_id)
    end
end
