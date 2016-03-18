$(document).on("page:change", function() {
	// Download the Video.js stylesheet and script when the page has a video
	var videoElement = document.getElementById("video");
	console.log(videoElement);
	if (videoElement != null) {
		$("head").prepend('<link href="https://vjs.zencdn.net/5.8.0/video-js.min.css" rel="stylesheet">');
		$.ajaxSetup({cache: true}); // Make sure the script can be cached
		$.getScript("https://vjs.zencdn.net/5.8.0/video.min.js", function() {
			// Kick off the script and reveal the video elements once it has run (hidden initially to mask the redraw)
			videojs(videoElement, {}, function() {
				$("#video").removeClass("hidden");
			});
		});
	};
});