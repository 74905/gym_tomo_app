/*global $*/
document.addEventListener("turbolinks:load",function(){
$('.home_faq-list-item').click(function(){
 var $answer = $(this).find('.home_answer');
 if($answer.hasClass('open')){
   $answer.removeClass('open');
   $answer.slideUp();
   $(this).find('span').text('+')
 }
  else{
    $answer.addClass('open');
    $answer.slideDown();
    $(this).find('span').text('-')
  }
});
});