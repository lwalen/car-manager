
$(document).ready(function() {

	$('table tbody tr').on({
		mouseover: function() {
			$(this).children('.actions').children().css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.actions').children().css('visibility', 'hidden');
		}
	});
	
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	var d = new Date();
	var year  = d.getFullYear();
	var month = months[d.getMonth()];
	var date  = d.getDate();
	var today = month + ' '
		+ date.toString() + ', '
		+ year.toString();

	$('#today').click(function() {
		$('#record_date').val(today);
	});
});
