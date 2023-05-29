class Corp < ApplicationRecord
    #self.table_name = "corps"
    #self.primary_key = "id"
    
    validates :nome, presence: true

    has_many :cadastros#, foreign_key: 'corp_id'
    belongs_to :user
end
