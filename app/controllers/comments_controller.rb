class CommentsController < ApplicationController
    before_action :require_login # Ensure user is logged in before accessing any action

    def create # Handle form submission to create a new comment
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params) # Create a new Comment associated with the post using strong parameters
        @comment.user = current_user # Associate the comment with the currently logged-in user

        if @comment.save # Attempt to save the comment to the database
            redirect_to posts_path, notice: "Comment added successfully!" # Redirect to the posts index with a success message
        else
            redirect_to posts_path, alert: "Failed to add comment." # If save fails, redirect back with an alert message
        end
    end

    def destroy # Handle deletion of a comment
        @comment = Comment.find(params[:id]) # Find the comment by ID from the URL parameters
        if @comment.user == current_user || @comment.post.user == current_user # Ensure only the comment author or post author can delete the comment
            @comment.destroy # Delete the comment from the database
            redirect_to posts_path, notice: "Comment deleted successfully!" # Redirect to the posts index with a success message
        else
            redirect_to posts_path, alert: "You are not authorized to delete this comment." # If not authorized, redirect back with an alert message
        end
    end

    private
    def comment_params # Strong parameters to prevent mass assignment vulnerabilities
        params.require(:comment).permit(:body) # Permit only the specified attributes
    end
end
