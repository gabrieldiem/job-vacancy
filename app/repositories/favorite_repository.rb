class FavoriteRepository < BaseRepository
  self.table_name = :favorites
  self.model_class = 'Favorite'

  def find_by_user_and_job_offer(user, job_offer)
    row = dataset.first(user_id: user.id, job_offer_id: job_offer.id)
    load_object(row) unless row.nil?
  end

  def find_all_by_offer(job_offer)
    load_collection dataset.where(job_offer_id: job_offer.id)
  end

  def delete_all_by_user(user)
    favorites = load_collection dataset.where(user_id: user.id)
    favorites.each do |favorite|
      destroy(favorite)
    end
  end

  protected

  def load_object(a_record)
    favorite = super
    favorite.user = UserRepository.new.find(favorite.user_id)
    favorite.job_offer = JobOfferRepository.new.find(favorite.job_offer_id)
    favorite
  end

  def changeset(favorite)
    {
      user_id: favorite.user.id,
      job_offer_id: favorite.job_offer.id
    }
  end
end
