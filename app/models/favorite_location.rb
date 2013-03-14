class FavoriteLocation < ActiveRecord::Base
  unloadable

  self.table_name = 'favorite_link_locations'
  PROJECT_LOCATIONS = { 'wiki' => :project_wiki_index_path, 'issues' => :project_issues_path }

  belongs_to :project
  belongs_to :user

  validates :user_id, :uniqueness => { :scope => [:link_location, :project_id] }, :presence => true
  validates :project_id, :presence => true
  validates :link_location, :presence => true, :inclusion => { :in => PROJECT_LOCATIONS.keys }

  attr_accessible :link_location, :link_text


  def self.for_user(user)
    where(:user_id => user.id)
  end
end
