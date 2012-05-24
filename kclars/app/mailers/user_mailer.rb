class UserMailer < ActionMailer::Base
  default :from => "from@example.com"
  def registration_confirmation(student)
   recipients student.email
   from "kcl.krapp@gmail.com"
   subject "thank you for using my app"
   body    "Use the following code to verify your account: #{student.password}"

  end
end
