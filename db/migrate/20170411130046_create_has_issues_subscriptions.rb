class CreateHasIssuesSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :has_issues_subscriptions do |t|
      t.references :issue, foreign_key: true
      t.integer :subscriber_id
      t.string :subscriber_type

      t.timestamps
    end

    add_index :has_issues_subscriptions, [:subscriber_id, :subscriber_type, :issue_id],
              unique: true,
              name: 'index_has_issues_subscriptions_on_s_id_and_s_type_and_i_id'
  end
end
