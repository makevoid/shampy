g = window

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

g.phogal = phogal

phogal.init = (@selector) ->
  @timer = null

phogal.elem = ->
  $(phogal.selector)

phogal.anim_time = 5000
# phogal.anim_time = 2000 # testing

phogal.resize = ->
  @elem().find(".pos2 img").imagesLoaded =>
    @resize_images()

  @elem().find("img").imagesLoaded =>
    @resize_images()
    # todo: debounced resize
    $(window).on "resize", =>
      @resize_images()

phogal.resize_images = ->
  win_height = $(window).height()
  divs = @.elem().find("div")
  divs.each (idx, element) =>
    elem = $(element).find "img"
    proportion = elem.height() / elem.width()
    if proportion >= 1 # vertical
      width = win_height / proportion
      $(elem).width width
      # todo: use transitions
    else
      top = (win_height - elem.height())/2
      $(element).css { top: top  }
      # todo: use transitions

phogal.animate = ->
  @timer = setTimeout =>
    @animate_now()
  , phogal.anim_time

  @watch_transition_end()


phogal.animate_now = ->
  @animate_once()
  @animate()

phogal.watch_transition_end = ->
  @elem().find("div.pos1").on "webkitTransitionEnd", =>

    @set_opacity()
    @bind_buttons()
    @change_title()

phogal.change_title = ->
  $("body h1").html @elem().find(".pos2").data("author")

phogal.set_opacity = ->
  @elem().find("div").css opacity: 0
  visibles = ".pos1, .pos2, .pos3"
  @elem().find(visibles).css opacity: 1

phogal.animate_once = ->
  unless @reverse
    prev = @elem().find "div:last"
    prev_copy = prev.clone()
    prev.remove()
    @elem().prepend prev_copy
  else
    prev = @elem().find "div:first"
    prev_copy = prev.clone()
    prev.remove()
    @elem().append prev_copy

  images = @elem().find "div"
  size = images.length
  images.each (idx, elem) ->
    elem = $(elem)
    elem.removeClass()

    pos_num = unless @reverse
      size-idx-1
    else
      idx

    elem.addClass "pos#{pos_num}"

phogal.next = ->
  @unbind_buttons()
  clearTimeout @timer
  @reverse = false
  @animate_now()

phogal.prev = ->
  @unbind_buttons()
  clearTimeout @timer
  @reverse = true
  @animate_now()
  @set_opacity()

phogal.unbind_buttons = ->
  @elem().find(".next, .prev").off "click"

phogal.bind_buttons = ->
  @unbind_buttons()
  @elem().find(".next").on "click", => @next()
  @elem().find(".prev").on "click", => @prev()

phogal.main_img = ->
  @elem().find(".pos2 img")

phogal.appear = ->
  @main_img().css opacity: 0

  @main_img().imagesLoaded =>
    @main_img().animate opacity: 1


phogal.start = ->
  phogal.appear()
  phogal.resize()
  phogal.animate()
  phogal.set_opacity()
  phogal.bind_buttons()

$ ->

  phogal.init ".photo_gallery"
  phogal.start()



  galleries = []
  gal_ones = $(".gallery_one_left, .gallery_one, .gallery_two").each (idx, gal) ->
    return if $(gal).hasClass "static"
    galleries[idx] = $.extend({}, gal_one)
    galleries[idx].element = gal
    galleries[idx].photos = $.makeArray galleries[idx].photos_imgs()
    galleries[idx].animate()

  gal_simple.photos = $.makeArray gal_simple.photos_imgs()
  gal_simple.animate()

  gal.photos = $.makeArray gal.photos_imgs()
  gal.animate()

  resize_galleries()