class CreateHasIssuesComments < ActiveRecord::Migration[5.0]
  def change
    create_table :has_issues_comments do |t|
      t.references :issue, foreign_key: true
      t.integer :creator_id
      t.string :creator_type
      t.integer :editor_id
      t.string :editor_type
      t.text :body

      t.timestamps
    end

    add_index :has_issues_comments, [:creator_id, :creator_type, :issue_id],
              name: 'index_has_issues_comments_on_c_id_and_c_type_and_i_id'
  end
end
