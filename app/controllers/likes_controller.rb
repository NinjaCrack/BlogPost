class LikesController < ApplicationController
    before_action :require_login
    before_action :set_post 

    def create
        @post = Post.find(params[:post_id])
        @like = @post.likes.build(user: current_user)

        if @like.save
            redirect_to posts_path, notice: "Post liked!"
        else
            redirect_to posts_path, alert: "you have already liked this post."
        end
    end

    def destroy
        @like = @post.likes.find(params[:id])

        if @like.user == current_user
            @like.destroy
            redirect_to posts_path(@post), notice: "Like removed."
        else
            redirect_to posts_path(@post), alert: "Unable to remove like."
        end
    end

    private
    def set_post
        @post = Post.find(params[:post_id])
    end

end