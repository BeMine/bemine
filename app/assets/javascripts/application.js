// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.turbolinks
//= require turbolinks
//= require bootstrap-sprockets
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require masonry/jquery.loremimages.min
//= require_tree .

$(function() {
    return $('#masonry-container').imagesLoaded(function() {
        return $('#masonry-container').masonry({
            itemSelector: '.box',
            isFitWidth: true
        });
    });
});

$(function(){
  $('.btn.btn-signup').on('mouseover', function(){
	  $('.btn.btn-signup').css({'color': 'black','border-color': '#fec503', 'background-color': '#fec503', });
	})
  .on('mouseout', function(){
	  $('.btn.btn-signup').css({'color': '#fec503', 'background-color': 'transparent'});
	})
});

$(function(){
  $('.btn.btn-match').on('mouseover', function(){
    $('.btn.btn-match').css({'color': 'black','border-color': '#fec503', 'background-color': '#fec503', });
  })
  .on('mouseout', function(){
    $('.btn.btn-match').css({'color': '#fec503', 'background-color': 'transparent'});
  })
});


