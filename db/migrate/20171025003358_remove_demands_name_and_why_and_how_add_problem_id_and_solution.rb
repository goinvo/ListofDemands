class RemoveDemandsNameAndWhyAndHowAddProblemIdAndSolution < ActiveRecord::Migration[5.1]
  def change
    remove_column(:demands, :name, :string)
    remove_column(:demands, :why, :string)
    remove_column(:demands, :how, :string)
    add_column(:demands, :solution, :text)
    add_column(:demands, :problem_id, :integer, null: false)
  end
end
