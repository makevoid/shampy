resize_gallery = (element) ->
  height = $(".#{element} img:first").height()
  $(".#{element}").height height

# home tiles

rand = (num=1) ->
  parseInt(Math.random()*num)

$(".home img").each (idx, elem) ->
  classes = ["flip", "slide"]
  # classes = ["slide", "slide"]
  $(elem).on "click", ->
    elem = $(elem)
    if elem.get(0).className
      elem.removeClass()
    else
      elem.addClass classes[rand(2)]


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

$ ->
  gal_simple.photos = $.makeArray gal_simple.photos_imgs()
  gal_simple.animate()

  resize_gallery "gallery_simple"

  $(window).resize ->
    resize_gallery "gallery_simple"


# gallery

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

$ ->
  gal.photos = $.makeArray gal.photos_imgs()
  gal.animate()

  resize_gallery "gallery"

  $(window).resize ->
    resize_gallery "gallery"