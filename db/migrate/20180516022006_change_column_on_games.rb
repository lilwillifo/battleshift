class ChangeColumnOnGames < ActiveRecord::Migration[5.1]
  def change
    rename_column :games, :player_1_board, :player_1
    rename_column :games, :player_2_board, :player_2
  end
end
