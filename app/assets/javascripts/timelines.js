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
        if (json.timeline) {
          $('div.timeline').prepend(json.timeline);
        } else if (json.error_message) {
          $('div.alert').prepend(json.error_message);
        } else {
          $('div.alert').prepend("ERROR HAPPENED");
        }
    }
  });
});