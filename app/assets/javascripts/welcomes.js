$(function() {
  return $('#masonry-container').imagesLoaded(function() {
    return $('#masonry-container').masonry({
      itemSelector: '.box',
      isFitWidth: true
    });
  });
});

$(function() {
  $(".carousel").carousel({
    interval: 1000 * 5,
    keyboard: true,
    pause: false,
    wrap: true
  });
});
