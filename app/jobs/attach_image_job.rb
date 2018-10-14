class AttachImageJob < ApplicationJob
  require 'httparty'

  queue_as :default

  def perform(post_id, image_url)
    PostService.attach_image!(post_id, image_url)
  end
end
