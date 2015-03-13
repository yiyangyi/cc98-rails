class TopicsController < ApplicationController
  
	def index
	end

	def feed
	end

	def new
	end

	def create
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def preview
	end

	def recent
	end

	def excellent
	end

	%W(no_reply popular).each do |name|
		define_method(name) do
		end
	end 

	def node
	end

	def follow
	end

	def unfollow
	end

	def favorite
	end

	def unfavorite
	end

	def suggest
	end

	def unsuggest
	end

  private

  def topic_params
  	params.require(:topic).permit(:title, :body, :node_id)
  end
end
