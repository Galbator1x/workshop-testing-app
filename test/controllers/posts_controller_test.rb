require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @post = posts(:one)
  end

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    stub_request(:get, 'https://cdn-images-1.medium.com/max/1600/1*9hd_8qR0CMZ8L0pVbFLjDw.png')
      .to_return(body: File.read('test/fixtures/files/image.png'))

    assert_difference('Post.count') do
      perform_enqueued_jobs do
        post posts_url, params: { post: {
          body: @post.body,
          name: @post.name,
          image_url: 'https://cdn-images-1.medium.com/max/1600/1*9hd_8qR0CMZ8L0pVbFLjDw.png'
        } }
      end
    end

    assert { Post.last.image.attached? }
    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch post_url(@post), params: { post: { body: @post.body, name: @post.name } }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
