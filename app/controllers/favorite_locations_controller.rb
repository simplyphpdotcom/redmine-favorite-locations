class FavoriteLocationsController < ApplicationController
  unloadable

  before_filter :check_user, :only => [:edit, :update, :destroy]
  before_filter :check_project, :only => :create

  def index
    @locations = FavoriteLocation.for_user(User.current)
  end

  def new
    @location = FavoriteLocation.new
    @location.user = User.current
    @visible_projects = Project.visible
  end

  def edit
    @visible_projects = Project.visible
  end

  def create
    location = FavoriteLocation.create(params[:favorite_location].except(:project_id)) do |loc|
      loc.project_id = @project.id
      loc.user_id = User.current.id
    end
    if location.persisted?
      flash[:success] = 'successfully created your favorite location'
      redirect_to :action => :index
    else
      flash.now[:error] = 'there was an error creating your favorite location'
      render :index
    end
  end

  def destroy
    if @location.destroy
      flash[:success] = "Location successfully deleted"
    else
      flash[:error] = "Location couldn't be deleted"
    end
    redirect_to :back
  end

  def update
    if @location.update_attributes(params[:favorite_location])
      flash[:success] = 'successfully updated your favorite location'
      redirect_to :action => :index
    else
      flash.now[:error] = "there was an error updating your favorite location"
      render :index
    end
  end

  protected

  def check_user
    @location = FavoriteLocation.find_by_id(params[:id])
    if @location.blank? || @location.user != User.current
      flash[:error] = "can't update another user's favorite location"
      redirect_to(:action => :index) and return
    end
  end

  def check_project
    proj_id = params[:favorite_location].delete(:project_id)
    @project = Project.find_by_id(proj_id)
    if @project.blank? || Project.visible.to_a.exclude?(@project)
      redirect_to :back
    end
  end

end
