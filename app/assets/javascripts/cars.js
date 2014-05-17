	
$(function() {
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	var d = new Date();
	var year  = d.getFullYear();
	var month = months[d.getMonth()];
	var date  = d.getDate();
	var today = month + ' '
		+ date.toString() + ', '
		+ year.toString();

	$('.today').click(function() {
		$(this).parent().parent().children('.date').val(today);
	});
});
