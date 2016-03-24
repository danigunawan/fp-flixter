$(document).on("page:change", function() {
	var sortableSections = $(".sortable-sections");
	var sortableLessons = $(".sortable-lessons");

	// Set up the callback that will be used to ping the server whenever a sortable element gets moved
	var sortUpdater = function(event, ui) {
		$.ajax({
			method: "PATCH",
			url: ui.item.data("update-url"),
			data: {sort_order_position: ui.item.index()}
		});
	};
	
	// Make the section elements sortable via dragging if the page is loaded and has the right content
	if (sortableSections.length > 0) {
		sortableSections.sortable({update: sortUpdater});
	}

	// Make the lesson elements sortable via dragging if the page is loaded and has the right content
	if (sortableLessons.length > 0) {
		sortableLessons.sortable({update: sortUpdater});
	}

	var newSectionModal = document.getElementById("newSectionModal");
	if(newSectionModal != null && $(newSectionModal).find(".has-error").length > 0) {
		$("#newSectionModalToggle").click();
	}
});