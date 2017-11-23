/*global $*/

$(function(){
  $('form.input_message_form input.post').click(function(e){
    var form = $('form.input_message_form');
    form.removeAttr('data-remote');
    form.removeData('remote');
    form.attr('action', form.attr('action').replace('.json', ''));
  });
  
  $('form.input_message_form').on('ajax:complete', function(event, data, status){
    if ( status == 'success') {
        var json = JSON.parse(data.responseText);
        if (json.reply_id) {
          var selecter = 'div.data-id' + json.reply_id;
          $(selecter).append(json.timeline);
        } else if (json.timeline) {
          $('div.timeline').prepend(json.timeline);
        } else if (json.error_message) {
          $('div.alert').prepend(json.error_message);
        } else {
          $('div.alert').prepend("SYSTEM ERRORD");
        }
    }
  });
  
  $('form.like_form').on('ajax:complete', function(event, data, status){
    if ( status == 'success') {
      var json = JSON.parse(data.responseText);
      if (json.new_count) {
        $(this).prev('span').find('span').text(json.new_count);
        $(this).find('.js-like').addClass('invisible');
      } else if (json.error_message) {
        $('div.alert').prepend(json.error_message);
      } else {
        $('div.alert').prepend("SYSTEM ERROR");
      }
    }
  });
});
