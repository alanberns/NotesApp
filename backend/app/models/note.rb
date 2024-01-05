class Note < ApplicationRecord
    before_validation :set_default_values, on: :create

    belongs_to :user
    has_many :categories, dependent: :delete_all

    validates :title, length: { in: 3..100, message: "lenght is 3-100" }
    validates :title, presence: true

    private
        def set_default_values()
            self.isActive = true
        end
end