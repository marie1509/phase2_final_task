class TweetsController < ApplicationController
    before_action :get_tweet, only: [:edit, :update]
    
    def index
        #一覧画面なのでデータを全て取得し、ビューに渡す
        @tweets=Tweet.all
    end
    
    
    def new
        #モデルのインスタンスをビューに渡す
        @tweet=Tweet.new
        
        if params[:back]
         @tweet = Tweet.new(tweet_params)
        else
         @tweet = Tweet.new
        end
    end
    
    def create
        @tweet=Tweet.new(tweet_params)
        
        if @tweet.save
            redirect_to tweets_path
        else 
            render 'new'
        end
    end
    
    def edit
        #編集するためにはまず編集したいツイートを取得する必要がある
        #idを利用して値を取得する際はfindメソッドが使用でき、idはパラメーターとして送られてくる
        get_tweet
    end
    
    def update
        #更新するツイートを取得
        get_tweet
        
        if @tweet.update(tweet_params) 
            redirect_to tweets_path
        else
            render 'edit'
        end
    end
    
    def destroy
        (get_tweet).destroy
        redirect_to tweets_path
    end
    
    def confirm
        @tweet=Tweet.new(tweet_params)
        if @tweet.invalid?
            render :new
        end
    end
    
    private
    def tweet_params
        #newで入力された値をparamsで取得
        params.require(:tweet).permit(:content)
    end
    
    def get_tweet
        @tweet=Tweet.find(params[:id])
    end
end
