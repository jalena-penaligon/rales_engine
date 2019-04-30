class ChangeIntegerLimitInTransactions < ActiveRecord::Migration[5.1]
  def change
    def change
     change_column :transactions, :credit_card_number, :integer, limit: 8
   end
  end
end
