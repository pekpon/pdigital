class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@papioldigital.com"
  default :to => "papioldigital@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "Missatge web: #{message.subject}")
  end
end