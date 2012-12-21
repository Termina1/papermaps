class InstagramService
  attr_accessor :tag, :count

  def initialize(opts = {})
    @tag = opts[:tag]
    @count = opts[:count]
  end

  def get_media
    Instagram.tag_recent_media @tag, count: @count
  end
end