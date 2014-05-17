	
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

	// Javascript to enable link to tab
	var hash = document.location.hash;
	var prefix = "tab_";
	if (hash) {
		$('.nav-tabs a[href='+hash.replace(prefix,"")+']').tab('show');
	}

	// Change hash for page-reload
	$('.nav-tabs a').on('shown.bs.tab', function (e) {
		window.location.hash = e.target.hash.replace("#", "#" + prefix);
	});
});
