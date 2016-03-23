$(document).on("page:change", function() {
	var stripeEnrollBtn = document.getElementById("stripe-enroll");
	if (stripeEnrollBtn != null) {
		// Attach a listener to the enroll button if a Stripe payment will be needed 
		$(stripeEnrollBtn).click(function() {
			$.ajaxSetup({cache: true}); // Make sure the script can be cached
			$.getScript("https://checkout.stripe.com/checkout.js", function() {
				// Configure a Stripe handler 
				var stripeHandler = StripeCheckout.configure({
    				key: stripeEnrollBtn.dataset.key,
				    locale: "auto",
				    token: function(token) {
				    	// When a token is returned, add its ID to a hidden form and trigger submission
				    	var hiddenStripeForm = $("#hidden-stripe-form");
				    	hiddenStripeForm.children("#stripe_token").val(token.id);
				    	hiddenStripeForm.submit();
			    	}
			    });

				// Open Stripe form using the handler
				stripeHandler.open({
					name: "Learnster",
					description: stripeEnrollBtn.dataset.description,
					amount: stripeEnrollBtn.dataset.amount,
					email: stripeEnrollBtn.dataset.email
				});
			});
		});
	}
});