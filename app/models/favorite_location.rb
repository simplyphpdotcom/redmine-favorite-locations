class FavoriteLocation < ActiveRecord::Base
  unloadable

  self.table_name = 'favorite_link_locations'

  belongs_to :user

  validates :user_id, :uniqueness => { :scope => :link_path }, :presence => true
  validates :link_path, :presence => true

  attr_accessible :link_path, :page_title

  def self.for_user(user)
    where(:user_id => user.id)
  end

  def page_title
    read_attribute(:page_title) || link_path
  end
end
