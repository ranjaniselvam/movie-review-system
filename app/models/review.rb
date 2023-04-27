class Review < ApplicationRecord
  acts_as_votable
  self.per_page = 10

  belongs_to :user
  belongs_to :movie, counter_cache: true

  validates :comment,length: {minimum:3}

  after_save :update_movie_average_ratings
  after_update :update_movie_average_ratings
  after_destroy :update_movie_average_ratings

  private

  def update_movie_average_ratings
    movie.update(reviews_average_rating: movie.reviews.average(:ratings) || 0)
  end

end
