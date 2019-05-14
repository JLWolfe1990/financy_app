class AuthorizationsController < ApplicationController
  #todo
  skip_before_action :verify_authenticity_token, only: [:link]
  before_action :add_allow_credentials_headers

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*' # the domain you're making the request from
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Allow-Headers'] = 'accept, content-type'
  end

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

  def unauthorize
    @authorization = Authorization.find(link_params[:id])
    @authorization.unauthorize!

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
