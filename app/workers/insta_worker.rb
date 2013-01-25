class InstaWorker
  @queue = :normal

  def self.perform(hashtag, count = 50, perform_in = 10.minutes)
    PhotosRepository.populate_from_instagram hashtag, count
    Resque.enqueue_in(perform_in, self, hashtag, count, perform_in)
  end

end