SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |primary|
    if user_signed_in?
      primary.item :users,     I18n.t('page_title.users.index'),     users_path                    if current_user.admin?
    else
      primary.item :main_page, I18n.t('page_title.main_page.index'), root_path
    end

    primary.item :questions, 'Задать вопрос', 'http://profile.tusur.ru/conversations/new?conversation%5Buser_groups%5D%5B%5D=37', link: { target: '_blank' }
  end
end

SimpleNavigation.register_renderer :first_renderer  => FirstRenderer
SimpleNavigation.register_renderer :second_renderer => SecondRenderer
SimpleNavigation.register_renderer :mobile_menu_renderer => MobileMenuRenderer
