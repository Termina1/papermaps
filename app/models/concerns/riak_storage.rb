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
    def get_last_saved_photo_id
      get('last_photo_id').data
    end

    def save_last_saved_photo_id(id)
      marker = get('last_photo_id')
      marker.data = { id: id, type: "system" }
      marker.store
    end

    def get(key)
      bucket.get_or_new key
    end

    private

    def get_ordered_by_date(count)
      map = 'function(v) { var ret = []; var o = Riak.mapValuesJson(v)[0]; if (o.type == "photo") { ret.push(v); } return ret; }'

      reduce = 'function (v) { v.sort( function(a,b) { return b["values"][0]["metadata"]["X-Riak-Last-Modified"] - a["values"][0]["metadata"]["X-Riak-Last-Modified"] }); return v; }'

      finder_result = Riak::MapReduce.new(client).
                  add(BUCKET_NAME).
                  map(map, keep: true).reduce(reduce).run

      objects = Riak::RObject.load_from_mapreduce client, finder_result
      photos = []

      objects.each do |o|
        data = o.data
        data.delete "type"

        photos << new(data)
      end

      photos
    end
  end

  def save
    object = self.class.get id
    object.data = instance_values.merge(type: "photo")
    object.store
  end
end