class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :keyword_users, dependent: :destroy
  has_many :keywords, through: :keyword_users

  def keyword_results
    keywords
      .left_outer_joins(:links)
      .select('keywords.id, keywords.total_results, keywords.term, links.type, COUNT(links.id) as count')
      .group('keywords.id', 'links.type')
  end
end
