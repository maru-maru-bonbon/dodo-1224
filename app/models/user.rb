class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        has_many :plans
        has_many :participants
        has_many :participant_users, through: :participants, source: :plan, dependent: :destroy

        PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
        validates_format_of :password, with: PASSWORD_REGEX, message: "は半角英数字で入力して下さい"
        
        validates :email, uniqueness: { case_sensitive: false }         
        validates :nickname, presence: true
     
end
