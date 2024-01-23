class Note < ApplicationRecord
    before_validation :set_default_values, on: :create

    has_and_belongs_to_many :categories
    belongs_to :user

    validates :title, format: { with: /\A[a-zA-Z0-9.,*?¿¡!#$]+\z/, message: "permited characters: a-zA-Z0-9.,*?$¿¡!#" },
                    length: { in: 3..100, message: "lenght is 3-100" },
                    presence: true
    
    validates :content, format: { with: /\A[a-zA-Z0-9.,*?¿¡!#$]+\z/, message: "permited characters: a-zA-Z0-9.,*?$¿¡!#" },
                        allow_nil: true

    private
        def set_default_values()
            self.isActive = true
        end
end