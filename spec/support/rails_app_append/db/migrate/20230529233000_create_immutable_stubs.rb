# frozen_string_literal: true

class CreateImmutableStubs < ::ActiveRecord::Migration[5.2]
  def change
    create_table :immutable_stubs do |t|
      t.string :immutable_attr
    end
  end
end
