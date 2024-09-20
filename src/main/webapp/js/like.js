function doLike(pid, uid){
	const dl = {
		pid: pid,
		uid: uid,
		operation: 'like'
	};
	
	$.ajax({
		url: 'LikeServlet',
		data: dl,
		success: function(data, textStatus, jqXHR){
			console.log(data);
			/*if(data.trim() == 'liked'){
				let c = $('.like-counter').html();
				c++;
				$('.like-counter').html(c);
			}else{
				let c = $('.like-counter').html();
				c--;
				$('.like-counter').html(c);
			}*/
			
		},
		error: function(jqXHR, textStatus, errorThrown){
			console.log(jqXHR);
		}
	});
	location.reload();
}