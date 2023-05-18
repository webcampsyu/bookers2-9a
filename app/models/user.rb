class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  
  #フォローした関係のアソシエーション
  #foreign_keyは外部キー
  #has_many :relationships, class_name:"Relationship"では
  #Relationshipsテーブルのどちら(follower,followed)を参照すればいいかわからない
  #なので、fofeign_keyで参照先を指定する
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
  
  #フォローされた関係のアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #reverse_of_relationshipsはフォローした関係のアソシエーションと区別と付けるための記述
  
  #一覧画面で使う
   #has_many :架空のテーブル名, through: :中間テーブル名でテーブル同士が中間テーブルを
  #通じて繋がっていることを表現(followerテーブルとfollowedテーブルのつながり)
  #@user.架空のテーブル名と記述することでフォローorフォロワーの一覧を表示できる
  has_many :followings, through: :relationships, source: :followed
 
  
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
 
 
  #コントローラで使うメソッドを記述
  #フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end 
  
  #フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end 
  
  #フォローしているか判定
  def following?(user)
    followigns.include?(user)
  end 

end
