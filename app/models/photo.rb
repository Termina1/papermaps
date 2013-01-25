class Photo
  include Mongoid::Document

  field :photo_id,   type: BigDecimal
  field :time

  field :username
  field :description
  field :standard_resolution_image_url
  field :thumbnail_image_url
  field :low_resolution_image_url
  field :longitude
  field :latitude

  def images
    Struct.new(:standard_resolution, :low_resolution, :thumbnail).new(
      standard_resolution_image_url, low_resolution_image_url, thumbnail_image_url
    )
  end

  def location
    Struct.new(:longitude, :latitude).new longitude, latitude
  end
end