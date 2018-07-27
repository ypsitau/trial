// jQuery entry
$(document).ready(function() {
	$('.list-group-item').on('click', function() {
		$('.fas', this)
			.toggleClass('fa-caret-right')
			.toggleClass('fa-caret-down');
	});
});
