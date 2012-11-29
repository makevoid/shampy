resize_gallery = (element) ->
  height = $(".#{element} img:first").height()
  $(".#{element}").height height unless height == 0

resize_all_galleries = ->
  galleries = ["gallery_one_left", "gallery_two", "gallery_one", "gallery_simple", "gallery"]

  for galler in galleries
    resize_gallery galler

resize_galleries = ->
  # TODO: replace with jquery imagesloaded
  times = [100, 500, 1000, 1500, 3000, 5000, 10000]
  for time in times
    setTimeout ->
      resize_all_galleries()
    , time

  $(window).resize -> resize_all_galleries()

# home tiles

rand = (num=1) ->
  parseInt(Math.random()*num)

$(".home img").each (idx, elem) ->
  classes = ["flip", "slide"]
  # classes = ["slide", "slide"]
  $(elem).on "click", ->
    return
    elem = $(elem)
    if elem.get(0).className
      elem.removeClass()
    else
      elem.addClass classes[rand(2)]


# TODO: refactor galleries

# gallery one

gal_one = {
  element: null,
  photos: []
}
window.gal_one = gal_one

gal_one.photos_imgs = ->
  $(this.element).find("img")

gal_one.assign_classes = ->
  $(this.photos[0]).addClass "pos0"
  $(this.photos[1]).addClass "pos1"
  $(this.photos[2]).addClass "pos2"
  $(this.photos[3]).addClass "pos3"
  $(this.photos[4]).addClass "pos4"

gal_one.frame = ->
  this.photos_imgs().each (id, el) =>
    $(el).removeClass()
  element = this.photos.shift()
  this.photos.push(element)
  this.assign_classes()

gal_one.animate_frame = ->
  setTimeout =>
    this.frame()
    this.animate_frame()
  , 2000+parseInt(Math.random()*13)*1000

gal_one.animate = ->
  this.animate_frame()

# simple gallery

gal_simple = {
  photos: []
}
window.gal_simple = gal_simple

gal_simple.photos_imgs = ->
  $(".gallery_simple img")

gal_simple.assign_classes = ->
  $(this.photos[0]).addClass "pos0"
  $(this.photos[1]).addClass "pos1"
  $(this.photos[2]).addClass "pos2"
  $(this.photos[3]).addClass "pos3"
  $(this.photos[4]).addClass "pos4"

gal_simple.frame = ->
  this.photos_imgs().each (id, el) =>
    $(el).removeClass()
  element = this.photos.shift()
  this.photos.push(element)
  this.assign_classes()

gal_simple.animate_frame = ->
  setTimeout =>
    this.frame()
    this.animate_frame()
  , 7000

gal_simple.animate = ->
  this.animate_frame()



# gallery # trash/refactor this

gal = {
  photos: []
}
window.gal = gal

gal.photos_imgs = ->
  $(".gallery img")

gal.assign_classes = ->
  $(gal.photos[0]).addClass "pos0"
  $(gal.photos[1]).addClass "pos1"
  $(gal.photos[2]).addClass "pos2"
  $(gal.photos[3]).addClass "pos3"
  $(gal.photos[4]).addClass "pos4"
  $(gal.photos[5]).addClass "pos5"

gal.frame = ->
  gal.photos_imgs().each (id, el) ->
    $(el).removeClass()
  element = gal.photos.shift()
  gal.photos.push(element)
  gal.assign_classes()

gal.animate_frame = ->
  setTimeout ->
    gal.frame()
    gal.animate_frame()
  , 7000

gal.animate = ->
  gal.animate_frame()


# foto_type .photo_gallery

phogal = {}

phogal.init = (selector) ->
  this.selector = selector

phogal.elem = ->
  $(phogal.selector)

phogal.anim_time = 4000
phogal.anim_time = 2000 # testing

phogal.resize = ->
  this.elem().find("img").imagesLoaded =>
    this.resize_once()
    $(window).on "resize", =>
      this.resize_once()

phogal.resize_once = ->
  this.elem().find("img").each (idx, elem) =>
    elem = $(elem)
    max_height = this.elem().height()
    proportion = elem.width() / elem.height()
    width = proportion * max_height
    elem.width width

  # this.elem().height this.elem().find("img").height()


phogal.animate = ->
  setTimeout =>
    phogal.animate_once()
    phogal.animate()
  , phogal.anim_time

phogal.animate_once = ->
  prev = this.elem().find(".box:last")
  prev_copy = prev.clone()
  prev.remove()
  this.elem().prepend prev_copy # or prepend?

  images = this.elem().find(".box")
  size = images.length
  images.each (idx, elem) ->
    elem = $(elem)
    elem.removeClass()
    elem.addClass "pos#{size-idx-1}"


$ ->

  phogal.init ".photo_gallery"
  phogal.resize()
  phogal.animate()


  galleries = []
  gal_ones = $(".gallery_one_left, .gallery_one, .gallery_two").each (idx, gal) ->
    galleries[idx] = $.extend({}, gal_one)
    galleries[idx].element = gal
    galleries[idx].photos = $.makeArray galleries[idx].photos_imgs()
    galleries[idx].animate()

  gal_simple.photos = $.makeArray gal_simple.photos_imgs()
  gal_simple.animate()

  gal.photos = $.makeArray gal.photos_imgs()
  gal.animate()

  resize_galleries()