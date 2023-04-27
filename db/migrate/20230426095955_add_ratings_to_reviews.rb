class AddRatingsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :ratings, :integer
  end
end
