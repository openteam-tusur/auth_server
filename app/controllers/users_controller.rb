class UsersController < ApplicationController
  def index
    redirect_to root_path, :alert => I18n.t('not_authorized') unless current_user.present? && current_user.admin?
    @users = User.order('surname, name, patronymic').text_search(params[:search]).page params[:page]
  end

  def search
    search = User.search do
      with(:fullname).starting_with(params[:term])
    end

    render :json => search.results.map(&:search_json)
  end
end
