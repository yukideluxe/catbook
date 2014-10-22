class CatMailer < ActionMailer::Base
	default from: "catbook@esdeluxe.com"

	def welcome_email(cat)
		@cat = cat
		@url  = 'http://example.com/login'
		mail(to: @cat.email, subject: 'Welcome to Catbook')
	end
end
