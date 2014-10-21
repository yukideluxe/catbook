class CatMailer < ActionMailer::Base
  default from: "catbook@esdeluxe.com"

  def welcome(cat)
    @cat = cat

    mail to: "#{@cat.name} <#{@cat.email}>", subject: "Welcome to CatBook! Miauuuuu"
  end
end
