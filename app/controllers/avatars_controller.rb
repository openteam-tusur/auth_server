class AvatarsController < ApplicationController
  before_action :find_avatar

  def edit
  end

  def update
    if @avatar.update(avatar_params)
      redirect_to :edit_avatar, :notice => 'Аватар успешно выбран'
    else
      flash.now[:alert] = 'При выборе аватара произошла ошибка'
      render :edit
    end
  end

  private

  def find_avatar
    @avatar = current_user.avatar
  end

  def avatar_params
    params.require(:avatar).permit(:identity_id)
  end
end
