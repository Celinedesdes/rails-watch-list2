class ChangeReviewsRemoveAuthorAddRating < ActiveRecord::Migration[8.1]
  def change
    remove_column :reviews, :author, :string
    add_column :reviews, :rating, :integer, null: false, default: 0
  end
end
