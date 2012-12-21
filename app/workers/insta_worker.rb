class InstaWorker
  @queue = :normal

  def self.perform(maps, hashtag, perform_in = 10.minutes)
    # code for update photos
    Resque.enqueue_in(perform_in, self, maps, hashtag, perform_in)
  end
  
end