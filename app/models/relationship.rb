class Relationship < ApplicationRecord
  #belongs_to :followerではfollowersテーブルを参照してしまう
  #そのためクラス名（モデル名）を指定する
  #belongs_to :userとしない理由はuserだとフォローされたのかフォローしたのかどちらのユーザーかわからないから 
  #relationshipsテーブルでforeign_keyとしてfollower_idとfollowed_idを設定
  #しているため、モデル名もFollowerとFollowedとします。
  #しかし、FollowerモデルもFollowedモデルどちらも作成していないため
  #実在しない。なので、実在するUserモデルを指定する
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end 
