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
  
  def comment_task(person, project, task, comment)
    @person = person
    @project = project
    @task = task
    @comment = comment
    mail(:to => person.email, :from => "Chronos <no-reply@ncm.org>", :subject => project.name + ": Task No. "  + task.task_number.to_s, :content_type => "text/html")
  end
end
