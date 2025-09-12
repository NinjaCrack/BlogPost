class SessionsController < ApplicationController

    def new # Render the login form
        redirect_to posts_path if current_user # If the user is already logged in, redirect to posts index
    end

    def create # Handle form submission to log in a user
        user = User.find_by(email: params[:email]) # Find the user by email

        if user&.authenticate(params[:password]) # Authenticate the user with the provided password
            session[:user_id] = user.id
            redirect_to posts_path, notice: "Logged in successfully!" # Redirect to the posts index with a success message
        else
            flash.now[:alert] = "Invalid email or password" # Set an alert message for invalid credentials
            render :new, status: :unprocessable_entity # Re-render the login form
        end
    end

    def destroy # Log out the user
        session[:user_id] = nil # Clear the session user_id
        redirect_to login_path, notice: "Logged out successfully!" # Redirect to the login page with a success message
    end
end