(function() {
  var resize_gallery;

  resize_gallery = function() {
    var height;
    height = $(".gallery img:first").height();
    return $(".gallery").height(height);
  };

  $(function() {
    resize_gallery();
    return $(window).resize(function() {
      return resize_gallery();
    });
  });

}).call(this);
