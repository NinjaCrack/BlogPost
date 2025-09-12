class UsersController < ApplicationController
    before_action :set_user, only: [ :show, :edit, :update ] # Ensure user is set for show, edit, and update actions
    before_action :require_login, only: [ :edit, :update ] # Ensure user is logged in before accessing edit or update actions
    before_action :correct_user, only: [ :edit, :update ] # Ensure only the correct user can edit or update their profile
    def new
        @user = User.new # Initialize a new User object for the form
    end

    def create # Handle form submission to create a new user
        @user = User.new(user_params) # Create a new User with the submitted parameters
        if @user.save # Attempt to save the user to the database
            session[:user_id] = @user.id # Log the user in by setting the session user_id
            redirect_to posts_path, notice: "User created successfully!" # Redirect to the user's show page with a success message
        else
            render :new, status: :unprocessable_entity # If save fails, re-render the new user form
        end
    end

    def show # Display a user's profile
        @user = User.find(params[:id]) # Find the user by ID from the URL parameters
        @posts = @user.posts.order(created_at: :desc) # Fetch the user's posts, ordered by creation date
    end

    # Edit user profile
    def edit
      # @user is already set by set_user
    end

    def update # Handle form submission to update a user's profile
        if @user.update(user_params) # Attempt to update the user with the submitted parameters
            redirect_to @user, notice: "Profile updated successfully!" # Redirect to the user's show page with a success message
        else
            render :edit, status: :unprocessable_entity # If update fails, re-render the edit
        end
    end




    # following and unfollowing actions
    def follow
        user = User.find(params[:id]) # Find the user to follow by ID from the URL parameters
        current_user.follow(user) # Call the follow method on the current user
        redirect_to user_path(user) # Redirect back to the user's profile
    end

    def unfollow
        user = User.find(params[:id]) # Find the user to unfollow by ID from the URL parameters
        current_user.unfollow(user) # Call the unfollow method on the current user
        redirect_to user_path(user) # Redirect back to the user's profile
    end

    # list of followers and following
    def followers
        @user = User.find(params[:id]) # Find the user by ID from the URL
        @followers = @user.followers # Fetch the list of followers for the user
    end

    def following
        @user = User.find(params[:id]) # Find the user by ID from the URL
        @following = @user.following # Fetch the list of users that the user is following
    end


    private

    def set_user # Set the user based on the ID from the URL parameters
        @user = User.find(params[:id]) # Find the user by ID
    end

    def user_params # Strong parameters to prevent mass assignment vulnerabilities
        params.require(:user).permit(:username, :name, :email, :bio, :gender, :password, :password_confirmation, :profile_picture) # Permit only the specified attributes
    end

    def correct_user # Ensure that only the correct user can edit or update their profile
        redirect_to root_path, alert: "You are not authorized to perform this action." unless @user == current_user
    end
end
