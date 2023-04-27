class Movie < ApplicationRecord
  self.per_page = 8

  belongs_to :user
  has_many :reviews,dependent:  :destroy
  has_one_attached :poster,dependent: :destroy

  scope :search_by_name, -> (name) { where("name LIKE ?", "%#{name}%") }

  scope :filter_by_year, ->(from_year, to_year) {
    if from_year.present? && to_year.present?
      where("release_date >= ? AND release_date <= ?", "#{from_year}-01-01", "#{to_year}-12-31")
    elsif from_year.present?
      where("release_date >= ?", "#{from_year}-01-01")
    elsif to_year.present?
      where("release_date <= ?", "#{to_year}-12-31")
    else
      all
    end
  }

  validates :name ,presence: true,length: {minimum:2},uniqueness: true
  validates :poster ,presence: true
  validates :release_date,presence: true

end
