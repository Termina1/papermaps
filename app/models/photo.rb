class Photo
  include RiakStorage

  attr_accessor :id, :username, :description, :time
  attr_writer   :standard_resolution_image_url, :thumbnail_image_url,
                :low_resolution_image_url, :longitude, :latitude

  def initialize(opts={})
    opts.each_pair do |k, v|
      send("#{k}=", v)
    end
  end

  def self.get_last(count=50)
    get_ordered_by_date count
  end

  def self.populate_from_instagram(tag, count = 5)
    loader = InstagramService.new tag: tag, max_id: get_last_saved_photo_id, count: count

    response = loader.get_media

    photos = response.data.map do |media_block|
      new(
        id: media_block.id,
        username: media_block.user.username,
        time: media_block.created_time,
        description: media_block.caption.try(:text),
        standard_resolution_image_url: media_block.images.standard_resolution.url,
        thumbnail_image_url: media_block.images.thumbnail.url,
        low_resolution_image_url: media_block.images.low_resolution.url,
        longitude: media_block.location.longitude,
        latitude: media_block.location.latitude,
      ) if media_block.location.present?
    end

    photos.compact.each &:save
    save_last_saved_photo_id photos.first.id if photos.first
  end

  def images
    Struct.new(:standard_resolution, :low_resolution, :thumbnail).new(
      @standard_resolution_image_url, @low_resolution_image_url, @thumbnail_image_url
    )
  end

  def location
    Struct.new(:longitude, :latitude).new @longtitude, @latitude
  end
end