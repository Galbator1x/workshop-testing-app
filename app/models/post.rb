# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  has_one_attached :image
end
