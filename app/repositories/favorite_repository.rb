class FavoriteRepository < BaseRepository
  self.table_name = :favorites
  self.model_class = 'Favorite'

  def find_by_user_and_job_offer(user, job_offer)
    row = dataset.first(user: user.id, job_offer: job_offer.id)
    load_object(row) unless row.nil?
  end

  protected

  def load_object(a_record)
    favorite = super
    favorite.user = UserRepository.new.find(favorite.user)
    favorite.job_offer = JobOfferRepository.new.find(favorite.job_offer)
    favorite
  end

  def changeset(favorite)
    {
      user: favorite.user.id,
      job_offer: favorite.job_offer.id
    }
  end
end
