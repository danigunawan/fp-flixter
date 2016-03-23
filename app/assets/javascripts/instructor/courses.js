$(document).on("page:change", function() {
	var sortableLessons = $(".sortable-lessons");
	if (sortableLessons.length > 0) {
		// Make the lesson elements in a section sortable via dragging if the page is loaded and correct
		sortableLessons.sortable({
			update: function(event, ui) {
				// Call the instructor/lessons controller with the lesson's new sort order every time the user has finished dragging a lesson
				$.ajax({
					method: "PATCH",
					url: ui.item.data("update-url"),
					data: {sort_order_position: ui.item.index()}
				});
			}
		});
	}
});