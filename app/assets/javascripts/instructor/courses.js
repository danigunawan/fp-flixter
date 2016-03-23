$(document).on("page:change", function() {
	var sortableLessons = $(".sortable-lessons");
	if (sortableLessons.length > 0) {
		sortableLessons.sortable({
			update: function(event, ui) {
				$.ajax({
					method: "PATCH",
					url: ui.item.data("update-url"),
					data: {sort_order_position: ui.item.index()}
				});
				console.log(ui.item.index());
				console.log(ui.item.data("update-url"));
			}
		});
	}
});