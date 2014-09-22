class Avatar < ActiveRecord::Base
  attr_accessor :gravatar

  belongs_to :user
  belongs_to :identity

  normalize_attribute :identity_id, :with => [:strip, :blank] do |value|
    v = value.presence.try(:to_i)
    v.zero? ? nil : v
  end

  validates_inclusion_of :identity_id, :in => ->(avatar) { avatar.user.identity_ids }, :allow_nil => true

  def url
    identity ? identity.image : user.gravatar_url
  end
end
