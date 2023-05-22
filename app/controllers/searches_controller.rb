class SearchesController < ApplicationController
  #ユーザーがログインしているかどうか確認し、ログインしていない場合
  #ユーザーのログインページにリダイレクトするdeviseメソッド
  before_action :authenticate_user!
  
  def search
    #検索フォームから検索モデルparams[:range]を受け取る
    @range = params[:range]
    @word = params[:word]
    
    #if文を用い、検索モデルUser or Bookで分岐条件にする
    if @range == "User"
      #検索フォームから検索方法params[:search],検索ワードparams[:word]を受け取る
      #looksメソッドを用い、検索内容を取得し、変数を代入する
      #検索方法params[:search]と検索ワードparams[:word]を参照して
      #データを検索
      #@usersにUserモデル内での検索結果を代入
      #@booksにBookモデル内での検索結果を代入
      @users = User.looks(params[:search], params[:word])
    else 
      @books = Book.looks(params[:search], params[:word])
    end 
  end 
  #searchアクションの完了
  #検索方法による切替を行うためのに各モデル(Userモデル,Bookモデル)に
  #分岐条件を記述
end
