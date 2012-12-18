class OrderAudit < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_id , :integer
  end

  def self.down
    remove_column :orders, :admin_id
  end
end
