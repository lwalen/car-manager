
$(function() {

	var width = $(window).width();

	$('table.records tbody tr').on({
		mouseover: function() {
			$(this).children('.actions').children('a').css('visibility', 'visible');
		},
		mouseout: function() {
			$(this).children('.actions').children('a').css('visibility', 'hidden');
		},
		click: function() {

			if (width < 768) {

				var actions = $(this).children('.actions');
				if (actions.hasClass('hidden-xs')) {
					$(this).children('.mileage, .gallons, .cost').hide();
					$(actions).children('a').css('visibility', 'visible');
					$(actions).attr('colspan', 3);
					$(actions).removeClass('hidden-xs');
				} else {
					$(actions).addClass('hidden-xs');
					$(actions).attr('colspan', 1);
					$(actions).children('a').css('visibility', 'hidden');
					$(this).children('.mileage, .gallons, .cost').show();
				}
			}
		}
	});
});
