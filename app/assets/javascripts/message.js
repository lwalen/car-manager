
$(function() {

	// Remove alerts with .fading after 3 seconds
	setTimeout(function() {
		$('.fading').slideUp(500, function() {
			$(this).remove();
		});
	}, 3000);
});