class CreateHasIssuesIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :has_issues_issues do |t|
      t.integer :issueable_id
      t.string :issueable_type
      t.integer :issuer_id
      t.string :issuer_type
      t.string :title
      t.integer :closer_id
      t.string :closer_type
      t.datetime :closed_at

      t.timestamps
    end

    add_index :has_issues_issues, [:issueable_id, :issueable_type],
              name: 'index_has_issues_issues_on_i_id_and_i_type'
  end
end
