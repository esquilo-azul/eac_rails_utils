# frozen_string_literal: true

class CreateJobs  < (
    Rails.version < '5' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  def change
    create_table :jobs do |t|
      t.string :name
    end
  end
end
