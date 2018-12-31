class Article < ApplicationRecord
 
  belongs_to :user
  
  #las dos siguientes lineas es la asociacion de many_to_many de articulos y categorias
  has_many :article_categories
  has_many :categories, through: :article_categories
  
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
  validates :description, presence: true, length: { minimum: 10, maximum: 200}
  validates :user_id, presence: true
  
end
