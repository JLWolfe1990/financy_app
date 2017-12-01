class AuthorizationsController < ApplicationController
  #todo
  skip_before_action :verify_authenticity_token, only: [:link]

  def index
    @authorizations = current_user.authorizations
  end

  def create
    @authorization = Authorization.new create_params
    if @authorization.save
      redirect_to authorizations_path
    else
      render :new
    end
  end

  def new
    @authorization = Authorization.new
  end

  def link
    public_token = link_params[:plaid_token]
    institution_id = PlaidInstitution.find_by(plaid_id: link_params[:plaid_institution_id])

    @authorization = Authorization.find(link_params[:id])
    @authorization.update public_token: public_token, plaid_institution: institution_id

    @authorization.retreive_access_token!

    redirect_to authorizations_path
  end

  def add_accounts
    @authorization = Authorization.find(params.fetch(:id))
    @authorization.create_accounts!

    redirect_to accounts_path
  end

  private

  def create_params
    params.fetch(:authorization).permit(:id, :user_id, :plaid_institution_id, :name)
  end

  def link_params
    params.permit(:id, :plaid_token, :plaid_institution_id)
  end
end
