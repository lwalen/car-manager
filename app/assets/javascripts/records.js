
$(document).ready(function() {
	$('table tbody tr').on({
		mouseover: function() {
			$(this).children('.actions').children().css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.actions').children().css('visibility', 'hidden');
		}
	});

	$('#record_mileage').autoNumeric();
	$('#record_cost').autoNumeric({aSign: '$', mDec: '2'});
});
