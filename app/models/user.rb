#encoding: UTF-8

class User < ActiveRecord::Base
  validates_presence_of :username
  validates :username, uniqueness: {message: 'já existe'}

  has_many :user_faqs, dependent: :destroy
  has_many :faqs, through: :user_faqs
end