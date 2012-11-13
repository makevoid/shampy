resize_gallery = ->
  height = $(".gallery img:first").height()
  $(".gallery").height height


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
  console.log gal.photos_imgs()
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

  resize_gallery()

  $(window).resize ->
    resize_gallery()