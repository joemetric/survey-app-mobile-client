require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def test_json_bundle_includes_questions
    s = Survey.new :name => 'foo'
    q = Question.new :text => 'bar'
    s.questions << q
    
    assert_equal({"name"=>"foo", "updated_at"=>0, "questions"=> [{"name"=>nil,
        "updated_at"=>nil,"question_type"=>nil,"text"=>"bar","survey_id"=>nil,
        "created_at"=>nil}], "amount"=>nil, "complete"=>false, "created_at"=>0}, s.bundle)
  end
end
