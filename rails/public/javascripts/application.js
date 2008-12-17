$(document).ready(function() {

  checkAnswerCount();

  $('#create_question_answers').find('.remove').ensure('click', function() {
    if($('#create_question_answers .answer').length > 2) {
      $(this).parents('.answer:first').remove();
    }

    checkAnswerCount();

    return false;
  });

  $('#add_answer').click(function() {
    var new_answer = $('#create_question_answers .answer:first').clone();
    new_answer.find('input[type=text]').val('');
    $('#create_question_answers').append(new_answer);

    checkAnswerCount();

    return false;
  });
});

function checkAnswerCount() {
  if($('#create_question_answers .answer').length < 3) {
    $('#create_question_answers .answer .remove').fadeOut(150);
  }
  if($('#create_question_answers .answer').length > 2) {
    $('#create_question_answers .answer .remove').fadeIn(150);
  }
}
