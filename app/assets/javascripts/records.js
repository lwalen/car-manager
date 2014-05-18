
$(function() {

	$('table tbody tr').on({
		mouseover: function() {
			$(this).children().children('.actions').children().css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children().children('.actions').children().css('visibility', 'hidden');
		}
	});
});
