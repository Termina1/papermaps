class PhotoPresenter
  def self.to_map_json photo
    {
      #time:     photo.time,
      description:  photo.description,
      username: photo.username,
      longitude: photo.location.longitude,
      latitude:  photo.location.latitude,
      id: photo.id,
      thumbnail_image_url:  photo.images.thumbnail,
      low_resolution_image_url: photo.images.low_resolution,
      standard_resolution_image_url:  photo.images.standard_resolution
    }
  end
end