require "minitest_helper"

describe Article do
  it "should add the title text" do
    article = Article.create!(:title => "testing with minitest")
    assert_equal article.title, "testing with minitest"
  end
end
