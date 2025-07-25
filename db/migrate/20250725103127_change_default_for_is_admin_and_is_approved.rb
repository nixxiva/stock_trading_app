class ChangeDefaultForIsAdminAndIsApproved < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :is_admin, from: nil, to: false
    change_column_default :users, :is_approved, from: nil, to: false
  end
end
