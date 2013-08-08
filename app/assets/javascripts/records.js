
$(document).ready(function() {
	$('table tbody tr').on({
		mouseover: function() {
			$(this).children('.delete').children('a').css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.delete').children('a').css('visibility', 'hidden');
		}
	});

	$('#record_date').datepicker({ dateFormat: 'M d, yy' });
});
