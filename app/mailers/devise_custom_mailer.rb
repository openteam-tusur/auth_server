class DeviseCustomMailer < Devise::Mailer
  before_filter :add_inline_attachment!

  def confirmation_instructions(record, token, opts={})
    super
  end

  def reset_password_instructions(record, token, opts={})
    super
  end

  def unlock_instructions(record, token, opts={})
    super
  end

  private

  def add_inline_attachment!
    attachments.inline['logo.png'] = { :content => File.read(Rails.root.join('app/assets/images/logo.png')), :content_id => "<logo.png@#{Settings['app.host']}>" }
  end
end
