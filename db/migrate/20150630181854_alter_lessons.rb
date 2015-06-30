class AlterLessons < ActiveRecord::Migration
  def change
    add_column(:lessons, :number, :integer)
  end
end
