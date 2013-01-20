class PostsController < ApplicationController
  
  # TODO: caches these actions
  # should be expired under admin_post_controller
  # caches_action :index, :layout => false
  # caches_action :show, :layout => false

  # cache_sweeper :post_sweeper, :only => [:create, :update, :destroy]

 
  def index
    @tag = params[:tag]
    @posts = Post.find_recent(:tag => @tag, :include => :tags)

    respond_to do |format|
      format.html
      format.atom { render :layout => false }
    end
  end

  def show
    @post = Post.find_by_permalink(*([:year, :month, :day, :slug].collect {|x| params[x] } << {:include => [:approved_comments, :tags]}))
    @comment = Comment.new
  end
end
