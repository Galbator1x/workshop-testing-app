class AttachImageJob < ApplicationJob
  require 'httparty'

  queue_as :default

  def perform(post_id, image_url)
    post = Post.find(post_id)
    post.image.attach(io: open(image_url), filename: SecureRandom.uuid)
  end
end
