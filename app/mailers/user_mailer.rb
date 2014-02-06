class UserMailer < ActionMailer::Base
  def created_task(person, project, task)
    @person = person
    @project = project
    @task = task
    mail(:to => person.email, :from => "Chronos <no-reply@ncm.org>", :subject => project.name + ": Task No. "  + task.task_number.to_s)
  end
  
  def updated_task(person, project, task)
    @person = person
    @project = project
    @task = task
    mail(:to => person.email, :from => "Chronos <no-reply@ncm.org>", :subject => project.name + ": Task No. "  + task.task_number.to_s)
  end
end
