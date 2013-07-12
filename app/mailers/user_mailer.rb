class UserMailer < ActionMailer::Base
  def created_task(person, project, task)
    @person = person
    @project = project
    @task = task
    mail(:to => person.email, :from => "Ticketing System <no-reply@ncm.org>", :subject => "New Task Assignment")
  end
  
  def updated_task(person, project, task)
    @person = person
    @project = project
    @task = task
    mail(:to => person.email, :from => "Ticketing System <no-reply@ncm.org>", :subject => "Task Assignment Update")
  end
end
