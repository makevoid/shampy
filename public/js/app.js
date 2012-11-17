(function() {
  var gal, gal_one, gal_simple, rand, resize_all_galleries, resize_galleries, resize_gallery;

  resize_gallery = function(element) {
    var height;
    height = $("." + element + " img:first").height();
    if (height !== 0) {
      return $("." + element).height(height);
    }
  };

  resize_all_galleries = function() {
    var galler, galleries, _i, _len, _results;
    galleries = ["gallery_one_left", "gallery_two", "gallery_one", "gallery_simple", "gallery"];
    _results = [];
    for (_i = 0, _len = galleries.length; _i < _len; _i++) {
      galler = galleries[_i];
      _results.push(resize_gallery(galler));
    }
    return _results;
  };

  resize_galleries = function() {
    var time, times, _i, _len;
    times = [100, 500, 1000, 1500, 3000, 5000, 10000];
    for (_i = 0, _len = times.length; _i < _len; _i++) {
      time = times[_i];
      setTimeout(function() {
        return resize_all_galleries();
      }, time);
    }
    return $(window).resize(function() {
      return resize_all_galleries();
    });
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
      return;
      elem = $(elem);
      if (elem.get(0).className) {
        return elem.removeClass();
      } else {
        return elem.addClass(classes[rand(2)]);
      }
    });
  });

  gal_one = {
    element: null,
    photos: []
  };

  window.gal_one = gal_one;

  gal_one.photos_imgs = function() {
    return $(this.element).find("img");
  };

  gal_one.assign_classes = function() {
    $(this.photos[0]).addClass("pos0");
    $(this.photos[1]).addClass("pos1");
    $(this.photos[2]).addClass("pos2");
    $(this.photos[3]).addClass("pos3");
    return $(this.photos[4]).addClass("pos4");
  };

  gal_one.frame = function() {
    var element,
      _this = this;
    this.photos_imgs().each(function(id, el) {
      return $(el).removeClass();
    });
    element = this.photos.shift();
    this.photos.push(element);
    return this.assign_classes();
  };

  gal_one.animate_frame = function() {
    var _this = this;
    return setTimeout(function() {
      _this.frame();
      return _this.animate_frame();
    }, 2000 + parseInt(Math.random() * 10) * 1000);
  };

  gal_one.animate = function() {
    return this.animate_frame();
  };

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
    var gal_ones, galleries;
    galleries = [];
    gal_ones = $(".gallery_one_left, .gallery_one, .gallery_two").each(function(idx, gal) {
      galleries[idx] = $.extend({}, gal_one);
      galleries[idx].element = gal;
      galleries[idx].photos = $.makeArray(galleries[idx].photos_imgs());
      return galleries[idx].animate();
    });
    gal_simple.photos = $.makeArray(gal_simple.photos_imgs());
    gal_simple.animate();
    gal.photos = $.makeArray(gal.photos_imgs());
    gal.animate();
    return resize_galleries();
  });

}).call(this);
