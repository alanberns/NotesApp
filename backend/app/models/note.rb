class Note < ApplicationRecord
    before_validation :set_default_values, on: :create

    has_and_belongs_to_many :categories
    belongs_to :user

    validates :title, length: { in: 3..100, message: "lenght is 3-100" }
    validates :title, presence: true

    private
        def set_default_values()
            self.isActive = true
        end
end