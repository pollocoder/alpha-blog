class Category < ApplicationRecord
  
  #las dos siguientes lineas es la asociacion de many_to_many de articulos y categorias
  has_many :article_categories
  has_many :articles, through: :article_categories
  
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end