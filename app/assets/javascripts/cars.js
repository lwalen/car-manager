
// Returns today's date formatted like Oct 6, 2014
function today() {	
	var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	var d = new Date();
	var year  = d.getFullYear();
	var month = months[d.getMonth()];
	var date  = d.getDate();
	return month + ' ' + date.toString() + ', ' + year.toString();
}

$(function() {

	// Today button for adding new records
	$('.today').click(function() {
		$(this).parent().parent().children('.date').val(today());
	});

	// Enable link to tab
	var hash = document.location.hash;
	var prefix = "tab_";
	if (hash) {
		$('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
	}

	// Change hash for page-reload
	$('.nav-tabs a').on('shown.bs.tab', function (e) {
		window.location.hash = e.target.hash.replace("#", "#" + prefix);
	});

	// Show all records
	$('.show-all-records').click(function(event) {
		$('.gas-tbody').load('/cars/mazda-b2300/more_records');
		$('.show-all-records').hide();
		event.preventDefault();
	});

	$('.edit-car').click(function(event) {
		var car_options = $(this).parent();
		var car_name_and_info = car_options.siblings('.car-name-and-info');
		car_name_and_info.children('.car-name, .car-info').hide();
		car_name_and_info.children('#car_name').show();

		$(this).hide();
		car_options.children('.save-car, .delete-car').show();
	});

	$('.save-car');
});
