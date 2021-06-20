library(htmltools)
library(httr)
library(magick)

##########
## Create the layout for the "Gallery" section ##
## see: https://www.etiennebacher.com/posts/2021-04-11-how-to-create-a-gallery-in-distill/##
##########

resize_image <- function(image) {
  
  imFile <- image_read(here::here(paste0("gallery/img/", image)))
  imFile_resized <- magick::image_resize(imFile, "6%")
  magick::image_write(imFile_resized, here::here(paste0("gallery/img/thumb-", image)))
  
}

make_gallery_layout <- function() {
  
  images <- list.files("gallery/img")
  images_full_size <- grep("thumb", images, 
                           value = TRUE, invert = TRUE)
  images_thumb <- grep("thumb", images, value = TRUE)
  
  images <- data.frame(images_thumb = images_thumb,
                       images_full_size = images_full_size)
  
  tagList(apply(images, 1, function(x) {
    tags$a(
      href = paste0("gallery/img/", x[["images_full_size"]]),
      tags$img(src = paste0("gallery/img/", x[["images_thumb"]]))
    )
  }))
  
}