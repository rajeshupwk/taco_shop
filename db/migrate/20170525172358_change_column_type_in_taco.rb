class ChangeColumnTypeInTaco < ActiveRecord::Migration[5.1]
  def change
    change_column :tacos, :meat, 'integer USING CAST(meat AS integer)'
  end
end
