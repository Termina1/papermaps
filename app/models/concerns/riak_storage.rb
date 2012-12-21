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
    private

    def get_ordered_by_date(count)
      map = <<-END
      function(v) {
        return [JSON.parse(v.values[0].data)];
      };
      END

      reduce = <<-END
        function (v, args) {
          v.sort( function(a,b) { return b['lastModifiedParsed'] - a['lastModifiedParsed'] });
          return v;
        };
      END

      Riak::MapReduce.new(client).
                  add(BUCKET_NAME).
                  map(map).run
    end
  end

  module InstanceMethods
  end
end