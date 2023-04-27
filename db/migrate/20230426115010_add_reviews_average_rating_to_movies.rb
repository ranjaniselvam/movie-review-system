class AddReviewsAverageRatingToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :reviews_average_rating, :float,default: 0.0
  end
end
