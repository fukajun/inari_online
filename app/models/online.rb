class Online < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subjects, dependent: :destroy
  has_many :studies, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :notification_histories, dependent: :destroy

  validates :first_name, presence: {message: "を入力してください"}
  validates :last_name, presence: {message: "を入力してください"}
  validates :kana_name, presence: {message: "を入力してください"}, format: { with: /\A[\p{katakana}\u{30fc}]+[　+][\p{katakana}\u{30fc}]+\z/ }
  validates :parent_name, presence: {message: "を入力してください"}
  validates :gender, presence: {message: "を選択してください"}
  validates :birthday, presence: {message: "を入力してください"}
  validates :high_school, presence: {message: "を入力してください"}, if: :high_school_select?
  validates :junior_high_school, presence: {message: "を入力してください"}, if: :junior_high_school_select?
  validates :elementary_school, presence: {message: "を入力してください"}, if: :elementary_school_select?
  validates :grade, presence: {message: "を選択してください"}
  validates :postal_code, presence: {message: "を入力してください"}, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
  validates :prefecture, presence: {message: "を入力してください"}
  validates :address, presence: {message: "を入力してください"}
  validates :phone, presence: {message: "を入力してください"}, format: { with: /\A0(\d{1}[-(]?\d{4}|\d{2}[-(]?\d{3}|\d{3}[-(]?\d{2}|\d{4}[-(]?\d{1})[-)]?\d{4}\z|\A0[5789]0[-]?\d{4}[-]?\d{4}\z/ }
  validates :parent_email, presence: {message: "を入力してください"}
  validates :course, presence: {message: "を選択してください"}

  def high_school_select?
    grade == nil || grade.include?("高")
  end

  def junior_high_school_select?
    grade == nil || grade.include?("中")
  end

  def elementary_school_select?
    grade == nil || grade.include?("小")
  end

  enum gender: {男性: 1, 女性: 2}
  enum grade: {小学生: 1, 中1: 2, 中2: 3, 中3: 4, 高1: 5, 高2: 6, 高3: 7, 高卒: 8},_suffix: true
  enum prefecture: {北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7, 
              茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14, 
              新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20, 
              岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24, 
              滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
              鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35, 
              徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39, 
              福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46, 沖縄県: 47
    				},_suffix: true
  enum course: {"数IA 1回目": 1, "数IA 2回目": 2, "数IIB 1回目": 3, "数IIB 2回目": 4, "数IIIC 1回目": 5, "数IIIC 2回目": 6, "数IA トライアル": 7, "数IIB トライアル": 8, "数IIIC トライアル": 9}
  enum status: {有効: true, 失効: false}
end
