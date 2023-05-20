class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    #一覧ページでフォロー数・フォロワー数を表示するための記述
    #@followings = user.followings
    #@followers = user.followers
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else

      render :edit
    end
    
    #フォロー一覧ページ用のコントローラ
    def followed
      user = User.find(params[:id])
      @user = user.followed_user.page(params[:page]).per(3).reverse_order
      #reverse_orderは「取得した値を逆順に並び替える」
    end 
    
    #フォロワー一覧ページ用のコントローラ
    def follower
      user = User.find(params[:id])
       @user = user.follower_user.page(params[:page]).per(3).reverse_order
    end 
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
