class AddJobToUsers < ActiveRecord::Migration
  def change
    add_belongs_to :users, :job
  end
end
