class IdentitiesController < ApplicationController
  def index
    @identities = current_user.identities
  end

  def destroy
    @identity = current_user.identities.find(params[:id])
    @identity.destroy
    render :nothing => true
  end
end
