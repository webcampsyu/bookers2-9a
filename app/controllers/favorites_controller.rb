class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    @book = favorite.book
    #非同期通信のため、いいね保存後のリダイレクト先を削除
    #redirect_to books_path
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #非同期通信のため、いいね削除後のリダイレクト先を削除
    #redirect_to books_path
  end
  #リダイレクト先を削除したことで、「リダイレクト先がない」かつ
  #JavaScriptリクエストという状況になり
  #createアクション実行後は,create.js.erbファイルを
  #destroyアクション実行後は,destroy.js.erbファイルを探すようになる
end
