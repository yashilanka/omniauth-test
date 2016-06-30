# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class Post < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	belongs_to :user
	has_many :post_categories
	has_many :categories, through: :post_categories


	validates :title, presence: true, length: {minimum: 6, maximum: 50}
	validates :description, presence: true, length: {minimum: 10}
end
