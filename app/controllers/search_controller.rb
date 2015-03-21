class SearchController < ApplicationController
  def index
  	@search = Topic.search do 
  	  fulltext params[:q]
  	  with(:created_at).less_than(Time.zone.now)
  	end

  	@articles = topics.results.paginate(page[:params], per_page: 20)
  end

  def google
  	keywords = params[:q] || ''
  	keyword.gsub('#', '%23')
  	redirect_to "https://www.google.com/#hl=zh-CN&q=site:cc98.org+#{keywords}"
  end
end
