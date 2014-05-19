
$(function() {

	if ($('.alert').hasClass('alert-success')) {
		setTimeout(function() {
			$('.alert').fadeOut(500, function() {
				$(this).remove();
			});
		}, 3000);
	}
});