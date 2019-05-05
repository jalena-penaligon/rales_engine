class ChangeStatustoString < ActiveRecord::Migration[5.1]
  def change
    change_column :invoices, :status, :string
  end
end
