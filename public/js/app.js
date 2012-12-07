(function() {
  var g, gal, gal_one, gal_simple, phogal, rand, resize_all_galleries, resize_galleries, resize_gallery;

  g = window;

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
    }, 2000 + parseInt(Math.random() * 13) * 1000);
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

  phogal = {};

  g.phogal = phogal;

  phogal.init = function(selector) {
    this.timer = null;
    return this.selector = selector;
  };

  phogal.elem = function() {
    return $(phogal.selector);
  };

  phogal.anim_time = 5000;

  phogal.resize = function() {
    var _this = this;
    return this.elem().find("img").imagesLoaded(function() {
      _this.resize_images();
      return $(window).on("resize", function() {
        return _this.resize_images();
      });
    });
  };

  phogal.resize_images = function() {
    var divs, win_height,
      _this = this;
    win_height = $(window).height();
    divs = this.elem().find("div");
    return divs.each(function(idx, element) {
      var elem, proportion, top, width;
      elem = $(element).find("img");
      proportion = elem.height() / elem.width();
      if (proportion >= 1) {
        width = win_height / proportion;
        return $(elem).width(width);
      } else {
        top = (win_height - elem.height()) / 2;
        return $(element).css({
          top: top
        });
      }
    });
  };

  phogal.animate = function() {
    var _this = this;
    this.timer = setTimeout(function() {
      return _this.animate_now();
    }, phogal.anim_time);
    return this.watch_transition_end();
  };

  phogal.animate_now = function() {
    this.animate_once();
    return this.animate();
  };

  phogal.watch_transition_end = function() {
    var _this = this;
    return this.elem().find("div:last").on("webkitTransitionEnd", function() {
      _this.set_opacity();
      return _this.bind_buttons();
    });
  };

  phogal.set_opacity = function() {
    var visibles;
    this.elem().find("div").css({
      opacity: 0
    });
    visibles = this.reverse ? ".pos0, .pos1" : ".pos1,.pos2";
    return this.elem().find(visibles).css({
      opacity: 1
    });
  };

  phogal.animate_once = function() {
    var images, prev, prev_copy, size;
    if (!this.reverse) {
      prev = this.elem().find("div:last");
      prev_copy = prev.clone();
      prev.remove();
      this.elem().prepend(prev_copy);
    } else {
      prev = this.elem().find("div:first");
      prev_copy = prev.clone();
      prev.remove();
      this.elem().append(prev_copy);
    }
    images = this.elem().find("div");
    size = images.length;
    return images.each(function(idx, elem) {
      var pos_num;
      elem = $(elem);
      elem.removeClass();
      pos_num = !this.reverse ? size - idx - 1 : idx;
      return elem.addClass("pos" + pos_num);
    });
  };

  phogal.next = function() {
    clearTimeout(this.timer);
    this.reverse = false;
    this.unbind_buttons();
    return this.animate_now();
  };

  phogal.prev = function() {
    clearTimeout(this.timer);
    this.reverse = true;
    this.unbind_buttons();
    return this.animate_now();
  };

  phogal.unbind_buttons = function() {
    return this.elem().find(".next, .prev").off("click");
  };

  phogal.bind_buttons = function() {
    var _this = this;
    this.unbind_buttons();
    this.elem().find(".next").on("click", function() {
      return _this.next();
    });
    return this.elem().find(".prev").on("click", function() {
      return _this.prev();
    });
  };

  phogal.start = function() {
    phogal.resize();
    phogal.animate();
    return phogal.bind_buttons();
  };

  $(function() {
    var gal_ones, galleries;
    phogal.init(".photo_gallery");
    phogal.start();
    galleries = [];
    gal_ones = $(".gallery_one_left, .gallery_one, .gallery_two").each(function(idx, gal) {
      if ($(gal).hasClass("static")) {
        return;
      }
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
