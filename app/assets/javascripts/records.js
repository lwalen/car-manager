
$(document).ready(function() {
	$('table tbody tr').on({
		mouseover: function() {
			$(this).children('.actions').children().css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.actions').children().css('visibility', 'hidden');
		}
	});

	$('#today').click(function() {
		var d = new Date();
		var year  = d.getFullYear();
		var month = d.getMonth() + 1;
		var date  = d.getDate();
		var today = date.toString() + '.'
			+ month.toString() + '.'
			+ year.toString();
		$('#record_date').val(today);
	});
});
