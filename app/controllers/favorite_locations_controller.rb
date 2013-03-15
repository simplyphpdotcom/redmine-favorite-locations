require 'open-uri'
require 'nokogiri'

class FavoriteLocationsController < ApplicationController
  unloadable

  before_filter :check_user, :only => [:edit, :update, :destroy]

  def index
    @locations = FavoriteLocation.for_user(User.current)
    render :json => {
      :action => :index,
      :html => render_to_string(:partial => 'index')
    }
  end

  def new
    @location = FavoriteLocation.new
    @location.user_id = User.current.id
    render :json => {
      :action => :new,
      :html => render_to_string(:partial => 'form')
    }
  end

  def edit
    render :json => {
      :action => :edit,
      :html => render_to_string(:partial => 'form')
    }
  end

  def create
    @location = FavoriteLocation.new(params[:favorite_location]) do |loc|
      loc.user_id = User.current.id
    end
    Thread.new do
      sleep 5
      Mutex.new.synchronize { scrape_url }
    end
    if @location.save
      render :json => {
        :action => :create,
        :html => render_to_string(:partial => 'show')
      }
    else
      render :json => {}, :status => 500
    end
  end

  def destroy
    if @location.destroy
      render :json => { :action => :destroy, :html => '' }
    else
      render :json => {}, :status => 500
    end
  end

  def update
    if @location.update_attributes(params[:favorite_location])
      render :json => {
        :action => :update,
        :html => render_to_string(:partial => 'show')
      }
    else
      render :json => {}, :status => 500
    end
  end

  protected

  def check_user
    @location = FavoriteLocation.find_by_id(params[:id])
    if @location.blank? || @location.user != User.current
      flash[:error] = "can't update another user's favorite location"
      redirect_to(:action => :index)
    end
  end

  def scrape_url
    return unless @location.persisted?
    begin
      url = File.join("#{request.scheme}://#{request.host}:#{request.port}/", @location.link_path)
      logger.info "URL: #{url}"
      html = open(url).read
    rescue OpenURI::HTTPError => e
      logger.error "#{e.class}: #{e}"
      html = nil
    end
    if html.present?
      title = Nokogiri.HTML(html).css('title').children[0].text
      @location.page_title = title if title
      @location.save
    end
  end

end
