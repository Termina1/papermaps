class PhotosRepository
  def self.get_last(count = 50)
    ordered_photos.limit count
  end

  def self.populate_from_instagram(tag, count = 5)
    response = get_raw_photos_data_by_tag tag, count

    photos = response.data.map { |media_block| create_new_photo media_block }
    save_last_photo_id photos
  end

  private

  def self.create_new_photo(attrs)
    if attrs.location.present?
      photo_attrs = {
        photo_id: attrs.id,
        username: attrs.user.username,
        time: attrs.created_time,
        description: attrs.caption.try(:text),
        standard_resolution_image_url: attrs.images.standard_resolution.url,
        thumbnail_image_url: attrs.images.thumbnail.url,
        low_resolution_image_url: attrs.images.low_resolution.url,
        longitude: attrs.location.longitude,
        latitude: attrs.location.latitude,
      }

      Photo.create photo_attrs
    end
  end

  def self.get_raw_photos_data_by_tag(tag, count)
    InstagramService.new(tag: tag, max_id: get_last_saved_photo_id, count: count).get_media
  end

  def self.save_last_photo_id(photos)
    LastPhotoId.first.update(photo_id: photos.first.id) if photos.first
  end

  def self.ordered_photos
    Photo.desc(:time)
  end

  def self.get_last_saved_photo_id
    ordered_photos.first.try :photo_id
  end
end