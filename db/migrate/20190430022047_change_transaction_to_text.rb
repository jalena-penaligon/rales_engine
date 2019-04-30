class ChangeTransactionToText < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :credit_card_number, :text
  end
end
