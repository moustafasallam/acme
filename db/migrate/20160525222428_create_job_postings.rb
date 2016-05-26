class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :title
      t.text :description
      t.datetime :closing_date

      t.timestamps null: false
    end
  end
end
