class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  
def index
  # まず全件取得した状態から始める
  @tweets = Tweet.all

  # 検索キーワードがあれば、その条件で絞り込む
  if params[:search].present?
    search = "%#{params[:search]}%"
    @tweets = @tweets.joins(:user).where("live_name LIKE ? OR shop_name LIKE ? OR shop_type LIKE ? OR review LIKE ?", search, search, search, search)
  end

  # タグの条件があれば、その条件でさらに絞り込む
  if params[:tag_ids]
    # 選択されたタグのIDを配列として取得
    tag_ids = params[:tag_ids].select { |key, value| value == "1" }.keys
    
    # 複数のタグIDを使って絞り込む
    if tag_ids.present?
      @tweets = @tweets.joins(:tags).where(tags: { id: tag_ids }).distinct
    end
  end
  @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to :action => "show", :id => tweet.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  private
  def tweet_params
    params.require(:tweet).permit(:live_name, :shop_name, :overall, :lat, :lng, :shop_type, :review,:image, tag_ids: [])
  end
end
