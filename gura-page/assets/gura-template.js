// jQuery entry
$(document).ready(function() {
	$('.list-group-item').on('click', function() {
		//$(this).text("checked");
		$('span', this).text("checked");
		//$('.glyphicon', this)
		//	.toggleClass('glyphicon-chevron-right')
		//	.toggleClass('glyphicon-chevron-down');
	});
});
