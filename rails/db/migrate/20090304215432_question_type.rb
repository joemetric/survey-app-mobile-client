class QuestionType < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_type, :string
  end

  def self.down
    remove_column :questions, :question_type
  end
end
