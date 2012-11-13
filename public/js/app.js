(function() {
  var gal, resize_gallery;

  resize_gallery = function() {
    var height;
    height = $(".gallery img:first").height();
    return $(".gallery").height(height);
  };

  gal = {
    photos: []
  };

  window.gal = gal;

  gal.photos_imgs = function() {
    return $(".gallery img");
  };

  gal.assign_classes = function() {
    $(gal.photos[0]).addClass("pos0");
    $(gal.photos[1]).addClass("pos1");
    $(gal.photos[2]).addClass("pos2");
    $(gal.photos[3]).addClass("pos3");
    $(gal.photos[4]).addClass("pos4");
    return $(gal.photos[5]).addClass("pos5");
  };

  gal.frame = function() {
    var element;
    gal.photos_imgs().each(function(id, el) {
      return $(el).removeClass();
    });
    console.log(gal.photos_imgs());
    element = gal.photos.shift();
    gal.photos.push(element);
    return gal.assign_classes();
  };

  gal.animate_frame = function() {
    return setTimeout(function() {
      gal.frame();
      return gal.animate_frame();
    }, 7000);
  };

  gal.animate = function() {
    return gal.animate_frame();
  };

  $(function() {
    gal.photos = $.makeArray(gal.photos_imgs());
    gal.animate();
    resize_gallery();
    return $(window).resize(function() {
      return resize_gallery();
    });
  });

}).call(this);
