// jQuery entry
$(document).ready(function() {
	$('.list-group-item').on('click', function() {
		$('i', this)
			.toggleClass('fa-minus-square')
			.toggleClass('fa-plus-square');
	});
});
