class IdentitiesController < ApplicationController
  inherit_resources
  belongs_to :user

  actions :index, :destroy

  def destroy
    destroy!{
      render :nothing => true and return
    }
  end
end
