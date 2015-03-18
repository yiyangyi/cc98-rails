class TopicsController < ApplicationController

	def index
	end

	def feed
	end

	def new
    @topic = Topic.new
	end

	def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    @topic.node_id = params[:node] || topic_params[:node_id]
    if @topic.save
      redirect_to(topic_path(@topic.id), notice: "Topic created successfully.")
    else
      render action: :new
    end
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
