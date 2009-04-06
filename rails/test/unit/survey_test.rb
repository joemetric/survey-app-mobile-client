require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def test_json_bundle_includes_questions
    s = Survey.new :name => 'foo'
    q = Question.new :text => 'bar'
    s.questions << q
    
    assert_equal({"name" => "foo", "updated_at" => nil, "questions" => [{"updated_at" => nil, "question_type" => nil, "text" => "bar", "survey_id" => nil, "created_at" => nil}], "amount" => nil, "created_at" => nil}, s.bundle)
  end
end
