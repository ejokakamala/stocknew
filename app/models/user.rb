class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable


  has_many :batches, dependent: :destroy
  has_many :incomes, dependent: :destroy
  has_many :flocks, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :fixed_expenses, dependent: :destroy
end
