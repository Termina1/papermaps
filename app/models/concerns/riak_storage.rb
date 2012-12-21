module RiakStorage
  extend ActiveSupport::Concern

  BUCKET_NAME = "photos"

  included do
    attr_accessor :object
    cattr_accessor :client, :bucket

    self.client ||= Riak::Client.new
    self.bucket ||= client.bucket BUCKET_NAME
  end

  module ClassMethods
    def get(key)
      bucket.get_or_new key
    end

    private

    def get_ordered_by_date(count)
      map = " function(v) { return [v]; } "

      reduce = 'function (v) { v.sort( function(a,b) { return b["metadata"]["X-Riak-Last-Modified"] - a["metadata"]["X-Riak-Last-Modified"] }); return v; }'

      Riak::MapReduce.new(client).
                  add(BUCKET_NAME).
                  map(map, keep: true).reduce(reduce).run
    end
  end

  module InstanceMethods
  end
end