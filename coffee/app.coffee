resize_gallery = ->
  height = $(".gallery img:first").height()
  $(".gallery").height height


$ ->
  resize_gallery()

  $(window).resize ->
    resize_gallery()