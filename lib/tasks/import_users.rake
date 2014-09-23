task :import_users => :environment do
  export_users_file = File.open('data/valid_users.json', 'r')
  import_users_file = File.open('data/imported_valid_users.json', 'w')

  users_json = JSON.parse(export_users_file.read)
  imported_json = []

  users_json.each do |info|
    current_sign_in_at = info.delete('current_sign_in_at')
    begin
      user = User.new(info)
      raise 'Убрать skip_confirmation перед релизом!' if Rails.env.production?
      user.skip_confirmation!
      if user.save(:validate => false)
        updated_info = info.merge('id' => user.id)
        imported_json << updated_info

        RedisUserConnector.set(user.id, user.as_json(:only => [:surname, :name, :patronymic, :email]).to_a.flatten)
      end
    rescue ActiveRecord::RecordNotUnique
      puts "Пользователь с #{info['email']} уже существует"
    end
  end

  import_users_file.write(imported_json.to_json)
end
