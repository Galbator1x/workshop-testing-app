class AttachImageJob < ApplicationJob
  require 'httparty'

  queue_as :default

  def perform(post_id, image_url)
    post = Post.find(post_id)
    path = Rails.root.join('storage', "#{SecureRandom.uuid}.png")
    open(path, 'wb') do |file|
      file << HTTParty.get(image_url).body
    end
    post.image.attach(io: File.open(path))
  end
end
