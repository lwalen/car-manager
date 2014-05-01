
$(document).ready(function() {
	$('table tbody tr').on({
		mouseover: function() {
			$(this).children('.actions').children().css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.actions').children().css('visibility', 'hidden');
		}
	});
});
