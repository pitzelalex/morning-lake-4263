class Project < ApplicationRecord
  validates_presence_of :name, :material
  belongs_to :challenge
  has_many :contestant_projects
  has_many :contestants, through: :contestant_projects

  def count_contestants
    # require 'pry'; binding.pry
    self.contestants.count
  end
end
