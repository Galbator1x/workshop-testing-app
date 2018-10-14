class PostService
  class << self
    def create!(post_params, image_url)
      post = Post.new post_params
      AttachImageJob.perform_later(post.id, image_url) if post.save
      post
    end

    def attach_image!(post_id, image_url)
      post = Post.find(post_id)
      post.image.attach(io: open(image_url), filename: SecureRandom.uuid)
    end
  end
end
