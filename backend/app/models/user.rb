class User < ApplicationRecord
    has_many :notes, dependent: :delete_all
    
    validates :username, presence: true
    validates :username, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :username, length: { in: 4..25, message: "lenght is 4-25" }
    validates :username, uniqueness: { message: "Already in use" }
    has_secure_password
end
