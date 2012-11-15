(function() {
  var gal, gal_simple, rand, resize_gallery;

  resize_gallery = function(element) {
    var height;
    height = $("." + element + " img:first").height();
    return $("." + element).height(height);
  };

  rand = function(num) {
    if (num == null) {
      num = 1;
    }
    return parseInt(Math.random() * num);
  };

  $(".home img").each(function(idx, elem) {
    var classes;
    classes = ["flip", "slide"];
    return $(elem).on("click", function() {
      elem = $(elem);
      if (elem.get(0).className) {
        return elem.removeClass();
      } else {
        return elem.addClass(classes[rand(2)]);
      }
    });
  });

  gal_simple = {
    photos: []
  };

  window.gal_simple = gal_simple;

  gal_simple.photos_imgs = function() {
    return $(".gallery_simple img");
  };

  gal_simple.assign_classes = function() {
    $(this.photos[0]).addClass("pos0");
    $(this.photos[1]).addClass("pos1");
    $(this.photos[2]).addClass("pos2");
    $(this.photos[3]).addClass("pos3");
    return $(this.photos[4]).addClass("pos4");
  };

  gal_simple.frame = function() {
    var element,
      _this = this;
    this.photos_imgs().each(function(id, el) {
      return $(el).removeClass();
    });
    element = this.photos.shift();
    this.photos.push(element);
    return this.assign_classes();
  };

  gal_simple.animate_frame = function() {
    var _this = this;
    return setTimeout(function() {
      _this.frame();
      return _this.animate_frame();
    }, 7000);
  };

  gal_simple.animate = function() {
    return this.animate_frame();
  };

  $(function() {
    gal_simple.photos = $.makeArray(gal_simple.photos_imgs());
    gal_simple.animate();
    resize_gallery("gallery_simple");
    return $(window).resize(function() {
      return resize_gallery("gallery_simple");
    });
  });

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
    resize_gallery("gallery");
    return $(window).resize(function() {
      return resize_gallery("gallery");
    });
  });

}).call(this);
