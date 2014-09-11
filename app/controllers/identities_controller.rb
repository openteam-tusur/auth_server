class IdentitiesController < ApplicationController
  def destroy
    current_user.identities.find(params[:id]).destroy
    redirect_to edit_user_registration_path
  end
end
