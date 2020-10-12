# frozen_string_literal: true

class AddJobToUsers < (
    Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  def change
    add_belongs_to :users, :job
  end
end
