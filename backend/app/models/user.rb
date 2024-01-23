class User < ApplicationRecord
    has_many :notes, dependent: :delete_all
    
    validates :username, presence: true,
                        format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" },
                        length: { in: 4..25, message: "length is 4-25" },
                        uniqueness: { message: "Already in use" }

    validates :password, presence: true,
                        length: { in: 5..25, message: "length is 5-25" },
                        format: { with: /\A[a-zA-Z0-9.,*?¿¡!#$]+\z/, message: "permited characters: a-zA-Z0-9.,*?¿$¡!#" }
    has_secure_password
end
