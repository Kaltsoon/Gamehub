class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(username: params[:username])
		if((not user.nil?) and user.authenticate params[:password])
			session[:user_id]=user.id
			redirect_to "/", notice: "Welcome back #{user}!"
		else
			redirect_to signin_path, notice: "Wrong username or password!"
		end
	end

	def destroy
		session[:user_id]=nil
		redirect_to "/", notice: "Bye, bye!"
	end
end