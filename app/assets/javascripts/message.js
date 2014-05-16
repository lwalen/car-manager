
$(function() {

	// Remove alerts with .fading after 3 seconds
	setTimeout(function() {
		$('.alert').fadeOut(500, function() {
			$(this).remove();
		});
	}, 3000);
});