class ReleaseNote < ActiveRecord::Base
  validates :version, presence: true, uniqueness: true
end
