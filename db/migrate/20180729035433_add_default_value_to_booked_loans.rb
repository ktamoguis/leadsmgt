class AddDefaultValueToBookedLoans < ActiveRecord::Migration[5.2]
  def change
    change_column :leads, :booked_loans, :integer, default: 0
  end
end
