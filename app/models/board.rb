class Board < ApplicationRecord
  has_many :teams
  has_many :accounts, through: :teams
  has_many :elements, :dependent => :destroy
  accepts_nested_attributes_for :elements
  validates :title, presence: true

  before_create :sanitize

  def sanitize
    self.title = self.title.strip
  end

  def slugify(account)
    spaced_slug = self.title.downcase.gsub(/[^-0-9a-zA-Z\ ]/, "")
    slug = spaced_slug.gsub(" ", "-")
    counter = 1
    until !account.boards.pluck(:slug).include? slug do
      slug=slug+"-"+counter.to_s
      counter+=1
    end
    self.url = "/#{account.username}/#{slug}"
    self.slug = slug
  end

end
