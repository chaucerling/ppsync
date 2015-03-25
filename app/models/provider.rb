class Provider < ActiveRecord::Base
  has_many :user_providers, inverse_of: :provider
  validates :name, presence: true

  def self.get_id str
    Provider.find_by(name: str).id
  end
end
