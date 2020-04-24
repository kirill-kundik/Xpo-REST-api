class User < ApplicationRecord
  # attr_accessor :visited_expo, :organized_expo

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, {
           jwt_revocation_strategy: JwtBlacklist,
           authentication_keys: [:login]
         }

  has_many :expos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :user_expos, dependent: :destroy
  has_many :visited_expo, lambda {
    joins(:user_expos).where('user_expos.is_organizer = false')
  }, { class_name: 'Expo', through: :user_expos, source: :expo }

  validates :login, presence: true, uniqueness: true
  validates :name, presence: true


  def send_welcome_email
    SendWelcomeEmailWorker.perform_async id
  end
end
