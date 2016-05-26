class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.text :cover_letter
      t.integer :job_posting_id

      t.timestamps null: false
    end
  end
end
