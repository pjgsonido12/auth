class UserMailer < ActionMailer::Base
  def registration_confirmation(person)
    @person = person
    mail(:to => person.email, :from => "Ticketing System <no-reply@ncm.org>", :subject => "Task Assignment")
  end
end
