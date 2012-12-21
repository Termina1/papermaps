class PhotoPresenter
  def self.to_map_json photo
    {
      date:     photo.time,
      caption:  photo.description,
      username: photo.username,
      location: {
        longitude: photo.location.longitude,
        latitude:  photo.location.latitude
      },
      images: {
        small:  photo.images.thumbnail,
        medium: photo.images.low_resolution,
        large:  photo.images.standard_resolution
      }
    }
  end
end