class Category < ApplicationRecord    
    belongs_to :notes

    validates :name, presence: true

end

