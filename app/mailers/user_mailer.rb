class UserMailer < ApplicationMailer

  def signup(user)
    @user = user
    mail(to: 'chris@chrisvannoy.com', subject: "Welcome to Chirpy!")
  end

  def share(chirp, email)
    @chirp = chirp
    mail(to: email, subject: "Check out this awesome chirp!")
  end

end
