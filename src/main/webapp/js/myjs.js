
//Add post js
$(document).ready(function () {
	$('#post-frm').on('submit', function (e) {
		//This code will be executed when the form is submitted
		e.preventDefault();

		let form = new FormData(this);

		//Request to server
		$.ajax({
			url: "PostServlet",
			type: "POST",
			data: form,
			success: function (data, textStatus, jqXHR) {
				//success
				if (data === "done") {
					swal({
						title: "Success!",
						text: data,
						icon: "success",
						button: "OK!",
					}).then((value) => {
						window.location = "profile.jsp"
					});
				} else {
					swal({
						title: "Warning!",
						text: data,
						icon: "warning",
						button: "OK!",
					});
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//error
				swal({
					title: "Error!",
					text: jqXHR,
					icon: "warning",
					button: "OK!",
				});
			},
			processData: false,
			contentType: false
		});

	});
});
