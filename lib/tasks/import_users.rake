task :import_users => :environment do
  users_file = File.open('data/valid_users.json', 'r').read
  users_json = JSON.parse(users_file)

  users_json.each do |info|
    current_sign_in_at = info.delete('current_sign_in_at')
    begin
      user = User.new(info)
      user.save(:validate => false)
    rescue ActiveRecord::RecordNotUnique
      puts "Пользователь с #{info['email']} уже существует"
    end
  end
end
