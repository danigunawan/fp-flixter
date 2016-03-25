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
	var newLessonModal = document.getElementById("newLessonModal");
	if(newSectionModal != null || newLessonModal != null) {
		// Whenever the new lesson modal is opened, uodate it to reflect the section that the user is trying to add a lesson to
		$(".newLessonModalToggle").click(function(event) {
			var formSubmitUrl = $(event.target).data("form-submit-url");
			var sectionTitle = $(event.target).data("section-title");
			$(newLessonModal).find("h5").text("Editing " + sectionTitle);
			$(newLessonModal).find("form").attr("action", formSubmitUrl);
		});

		// Clear out the new lesson modal whenever it's closed
		$(newLessonModal).on("hide.bs.modal", function() {
			$(newLessonModal).find("input.required").val("");
			$(newLessonModal).find(".help-block").remove();
			$(newLessonModal).find("*").removeClass("has-error");
		});

		// Automatically open the new section modal if it has errors
		if($(newSectionModal).find(".has-error").length > 0) {
			$("#newSectionModalToggle").click();
		}

		// If the new lesson modal has errors, automatically open it via the correct button
		if($(newLessonModal).find(".has-error").length > 0) {
			var associatedSection = $(newLessonModal).data("validation-recovery");
			$("#newLessonModalToggle-" + associatedSection).click();
		}
	}
});