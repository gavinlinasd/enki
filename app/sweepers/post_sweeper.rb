class PostSweeper < ActionController::Caching::Sweeper
  observe Post

  def after_create(post)
    expire_cache(post)
  end

  def after_update(post)
    expire_cache(post)
  end

  def after_destroy(post)
    expire_cache(post)
  end
  
  # helper function for expire action
  def expire_cache(post)
    expire_action :controller => '/posts', :action => 'index'
    expire_action :controller => '/posts', :action => 'show'
  end
end
