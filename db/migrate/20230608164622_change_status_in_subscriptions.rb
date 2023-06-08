class ChangeStatusInSubscriptions < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE subscriptions
      ALTER COLUMN status TYPE integer
      USING (CASE status
             WHEN 'active' THEN 0
             ELSE 1
             END)
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE subscriptions
      ALTER COLUMN status TYPE text
      USING (CASE status
             WHEN 0 THEN 'active'
             ELSE 'cancelled'
             END)
    SQL
  end
end
