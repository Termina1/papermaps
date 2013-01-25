class PhotosController < ApplicationController
  def index
    respond_to do |wants|

      wants.json do
        render json: PhotosRepository.get_last(5).each { |p| PhotoPresenter.to_map_json(p) }
      end

      wants.html do
        render "index"
      end
    end
  end
end