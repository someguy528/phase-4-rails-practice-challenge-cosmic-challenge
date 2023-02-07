class Mission < ApplicationRecord
    belongs_to :planet
    belongs_to :scientist
    validates :name, :planet_id, :scientist_id, presence: true
    validates :scientist_id, uniqueness: {scope: :name}

    def no_repeat_scientist

    end
end
