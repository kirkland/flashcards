function mark_for_destroy(element) {
  $(element).next('.should_destroy').value = 1;
  $(element).up('.card').hide();
}

function adjust_font(amount) {
  start_size = parseInt($("card_front_value").getStyle('font-size'));
  $("card_front_value").setStyle({fontSize: "" + (start_size + amount) + "px"});
  $("card_back_value").setStyle({fontSize: "" + (start_size + amount) + "px"});
}

function gaLoad() {
  var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
  ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
}

