module ForumUser

  # attributes

  DEFAULT_AVATAR = "/images/avatars/d3_1.jpg"

  def avatar_image
    "<img src='#{avatar.nilblank || DEFAULT_AVATAR}' class='avatar' />"
  end


  # filters

  def posts_roots
    posts.all(parent_id: nil)
  end

  def replies
    posts.all(:parent_id.not => nil)
  end

  def posts_lasts
    posts.all(limit: 20)
  end

  # actions

  def mine?(post)
    post.user == self
  end

  def post(forum, attributes)
    forum.posts.new attributes.merge(user_id: self.id)
  end

  def reply(post, attributes)
    post.forum.posts.new attributes.merge(user_id: self.id, parent_id: post.id)
  end

end