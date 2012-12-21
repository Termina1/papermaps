class Photo
  include RiakStorage

  attr_accessor :username, :url, :gps, :description, :date

  def self.get_last(count=50)
    get_ordered_by_date count
  end
end