class AddUserToInstrumentoPadraos < ActiveRecord::Migration[5.2]
  def change
    add_reference :instrumento_padraos, :user, foreign_key: true
  end
end
