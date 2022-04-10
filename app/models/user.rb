class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
   devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :vaccines
  has_one :vaccination
  validates :name, presence: true
  validates :apellido, presence: true
  validates :DNI, uniqueness: true, presence: true
  validates :nacimiento, presence: true

end


