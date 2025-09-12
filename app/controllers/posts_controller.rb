class PostsController < ApplicationController
    before_action :require_login # Ensure user is logged in before accessing any action

    def index
        following_ids = current_user.following_ids
        @posts = Post.where(user_id: [ current_user.id ] + following_ids)
                .includes(:user, :likes, :comments)
                .order(created_at: :desc)
    end


    def new # Render the form for creating a new post
        @post = Post.new # Initialize a new Post object for the form
        @posts = Post.includes(:user, :likes).order(created_at: :desc)
    end

    def show
        @post = Post.find(params[:id]) # Find the post by ID from the URL parameters
        @comments = @post.comments.includes(:user).order(created_at: :desc) # Fetch comments for the post, including associated users, ordered by creation date
        @likes = @post.likes.includes(:user).order(created_at: :desc) # Fetch likes for the post, including associated users, ordered by creation date
    end


    def create # Handle form submission to create a new post
        @post = current_user.posts.build(post_params) # Create a new Post associated with the current user using strong parameters
        if @post.save # Attempt to save the post to the database
            redirect_to posts_path, notice: "Post created successfully!" # Redirect to the posts index with a success message
        else
            render :new, status: :unprocessable_entity # If save fails, re-render the new post form
        end
    end

    # newfeed action to show posts from followed users
    # def newsfeed
    # end

    private
    def post_params # Strong parameters to prevent mass assignment vulnerabilities
        params.require(:post).permit(:caption, :image) # Permit only the specified attributes
    end
end
