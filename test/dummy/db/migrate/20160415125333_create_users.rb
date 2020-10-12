# frozen_string_literal: true

class CreateUsers < (
    Rails.version < '5.2' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  )
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
