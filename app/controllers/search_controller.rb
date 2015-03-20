class SearchController < ApplicationController
  def index
  end

  def google
  	keywords = params[:q] || ''
  	keyword.gsub('#', '%23')
  	redirect_to "https://www.google.com/#hl=zh-CN&q=site:cc98.org+#{keywords}"
  end
end
