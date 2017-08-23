$(document).on('turbolinks:load',function(){
	//Add new Answer
	$('.comment_answer_button').on('click', function(){
	  answer_click_id = $(this).data("id");
	  $('.you_answer_'+answer_click_id).toggleClass('hide_show');
	})

	//Rating Up
	$('.rating_up').on('click', function(){
    console.log('click')
		post_click_id = $(this).data("post-id");
		post_click_rating = $(this).data("post-rating");
		console.log('post_click_rating', post_click_rating)
		post_rating = post_click_rating + 1;
		$.ajax({
      type: "PUT", 
      url: '/posts/'+post_click_id,
      data: {
        post: { rating: post_rating}
      },
      success: function(response){
        $('.rating_integer_'+post_click_id).html(post_rating);
      }
    })
	})
	//Rating Down
	$('.rating_down').on('click', function(){
		post_click_id = $(this).data("post-id");
		post_click_rating = $(this).data("post-rating");
		post_rating = post_click_rating - 1;
		$.ajax({
      type: "PUT", 
      url: '/posts/'+post_click_id,
      data: {
        post: { rating: post_rating}
      },
      success: function(response){
        $('.rating_integer_'+post_click_id).html(post_rating);
      }
    })
	})

	//Get Domain
	$('.add_post_link').blur(function (url) {
		var url = $( ".add_post_link" ).val();
    var hostname;
    //find & remove protocol (http, ftp, etc.) and get hostname
    if (url.indexOf("://") > -1) {
        hostname = url.split('/')[2];
    }
    else {
        hostname = url.split('/')[0];
    }
    //find & remove port number
    hostname = hostname.split(':')[0];
    //find & remove "?"
    hostname = hostname.split('?')[0];
    console.log(hostname);
    $('.add_post_domain').val(hostname);
	});

  //Add news from parser
  $('.add_news_parser').on('click', function(){
    //get title and link
    title_parse = $(this).data("title");
    link_parse = $(this).data("link");
    //get domain
    var hostname;
    //find & remove protocol (http, ftp, etc.) and get hostname
    if (link_parse.indexOf("://") > -1) {
        hostname = link_parse.split('/')[2];
    }
    else {
        hostname = link_parse.split('/')[0];
    }
    //find & remove port number
    hostname = hostname.split(':')[0];
    //find & remove "?"
    hostname = hostname.split('?')[0];
    console.log(hostname);

    $.ajax({
      type: "POST", 
      url: '/posts/',
      data: {
        post: {title: title_parse, url: link_parse, domain: hostname, user_id: 1}
      },
      success: function(response){
        console.log(response)
      }
    })
  })
});