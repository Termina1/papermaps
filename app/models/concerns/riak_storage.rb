module RiakStorage
  extend ActiveSupport::Concern

  BUCKET_NAME = "photos"

  included do
    attr_accessor :client, :bucket
    cattr_accessor :client, :bucket

    self.client ||= Riak::Client.new
    self.bucket ||= client.bucket BUCKET_NAME
  end

  def store
    object.store
  end
end