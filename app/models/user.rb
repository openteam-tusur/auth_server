class User < ActiveRecord::Base
  include Gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable,              :trackable,
         :validatable,              :confirmable,
         :omniauthable,             :timeoutable,
         :async

  validates_email_format_of :email,            :message    => I18n.t('email_wrong_format'),
                            :check_mx => true, :mx_message => I18n.t('no_email_servirce')

  normalize_attributes  :surname, :name, :patronymic
  validates_presence_of :surname, :name, :email

  delegate :url, :to => :avatar, :prefix => true

  VALIDATORS = {
    :should_contains_only_cyrillic_chars => /\A[а-яё -]+\z/i,
    :should_starts_with_capital_letter => /\A[А-ЯЁ]/,
    :should_looks_like_name => /\A([А-ЯЁ][а-яё]*)([ -][А-ЯЁ]?[а-яё]+)*\z/
  }

  VALIDATORS.each do |message, format|
    validates_format_of :surname, :name, :with => format, :message => message, :allow_nil => true
  end

  has_many :identities, :dependent => :destroy
  has_one  :avatar, :dependent => :destroy
  has_gravatar :secure => true, :size => 96

  after_create :create_avatar

  serialize :user_agent

  paginates_per 15

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    user = User.new if user.nil?

    if identity.user != user
      identity.name = auth.info.name
      identity.image = auth.info.image
      identity.url = auth.info.urls.values_at('GitHub', 'Twitter').compact[0]
      identity.user = user
      identity.save!
    end

    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      user.identities << (Identity.find_for_oauth(session['devise.oauth_data']) || [])
    end
  end

  def self.text_search(query)
    if query.present?
      all.where('email ILIKE :query OR surname ILIKE :query OR name ILIKE :query OR patronymic ILIKE :query', :query => "%#{query}%" )
    else
      all
    end
  end

  def after_database_authentication
   RedisUserConnector.set(self.id, self.as_json(:only => [:surname, :name, :patronymic, :email]).to_a.flatten)
  end

  def admin?
    role == 'admin'
  end

  def fullname
    [surname, name, patronymic].compact.join(' ')
  end

  def to_s
    "#{fullname} <#{email}>"
  end
end
