require "rails_helper"

RSpec.describe "Posts", type: :feature do
  let(:post) { Post.create(name: 'Bob', title: 'Hello', content: 'World') }

  it "visiting the index" do
    visit posts_path
    assert_selector "h1", text: "Posts"
  end

  it "creating a Post" do
    visit posts_path
    click_on "New Post"

    fill_in "Content", with: post.content
    fill_in "Name", with: post.name
    fill_in "Title", with: post.title
    click_on "Create Post"
  end

  it "updating a Post" do
    visit posts_path(post)
    click_on "Edit", match: :first

    fill_in "Content", with: post.content
    fill_in "Name", with: post.name
    fill_in "Title", with: post.title
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  it "destroying a Post" do
    visit posts_path(post)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
