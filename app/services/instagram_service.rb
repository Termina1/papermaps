class InstagramService
  attr_accessor :tag, :count, :max_id

  def initialize(opts = {})
    @tag    = opts[:tag]
    @count  = opts[:count]
    @max_id = opts[:max_id]
  end

  def get_media
    Instagram.tag_recent_media @tag, count: @count, max_id: max_id
  end
end