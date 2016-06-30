# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :post_categories
  has_many :posts, through: :post_categories


  validates :name, presence: true, length: {minimum: 3}
end
