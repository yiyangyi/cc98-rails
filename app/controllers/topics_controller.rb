class TopicsController < ApplicationController
  load_and_authorize_resource only: [:new, :edit, :create, :update, :destroy, :favorite, :unfavorite, :follow, :unfollow, :suggest, :unsuggest]

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
    @body = params[:body]
    
    respond_to do |format|
      format.json
    end
  end

  def recent
    @topic = Topic.recent.includes(:user)
    @topic = @topic.paginate(page: params[:page], per_page: 20)
    render action: :index
  end

  def excellent
    @topics = Topic.excellent.recent.includes(:user)
    @topics = @topics.paginate(page: params[:page], per_page: 20)
    render action: :index
  end

  %W(no_reply popular).each do |name|
	  define_method(name) do
	  end
  end

  def node
    @node = Node.find(params[:id])
    @topics = @node.topics.last_activated.includes(:user).paginate(page: params[:page], per_page: 20)
    render action: :index
  end

  def follow
    @topic = Topic.find(params[:id])
    @topic.push_follower(current_user.id)
    render text: '1'
  end

  def unfollow
    @topic = Topic.find(params[:id])
    @topic.pull_follower(current_user.id)
    render text: '1'
  end

  def favorite
	  current_user.favorite_topic(params[:id])
	  render text: '1'
  end

  def unfavorite
	  current_user.unfavorite_topic(params[:id])
	  render text: '1'
  end

  def suggest
	  @topic = Topic.find(params[:id])
	  @topic.update_attributes(excellent: 1)
	  redirect_to @topic, success: 'Suggest successfully.'
  end

  def unsuggest
	  @topic = Topic.find(params[:id])
	  @topic.update_attributes(excellent: 0)
	  redirect_to @topic, success: 'Unsuggest successfully.'
  end

  private

  def topic_params
  	params.require(:topic).permit(:title, :body, :node_id)
  end
end
