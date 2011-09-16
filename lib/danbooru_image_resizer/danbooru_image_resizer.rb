module Danbooru
  def resize(read_path, write_path, width, height, resize_quality = 90)
    image = Magick::Image.read(read_path).first
    
    if width == Danbooru.config.small_image_width
      image.change_geometry("#{width}x#{height}>") do |small_width, small_height, img|
        img.thumbnail!(small_width, small_height)
        width = small_width
        height = small_height
      end
    else
      image.change_geometry("#{width}x>") do |new_width, new_height, img|
        img.resize!(new_width, new_height)
        width = new_width
        height = new_height
      end
    end
    
    image = flatten(image, width, height)
    
    image.write(write_path) do
      self.quality = resize_quality
    end
    
    image.destroy!
  end
  
  def flatten(image, width, height)
    if image.alpha?
      # since jpeg can't represent transparency, we need to create an image list,
      # put a white image on the bottom, then flatten it.
      
      list = Magick::ImageList.new
      list.new_image(width, height) do
        self.background_color = "#FFFFFF"
      end
      list << image
      flattened_image = list.flatten_images
      list.each do |image|
        image.destroy!
      end
      return flattened_image
    else
      return image
    end
  end

  module_function :resize, :flatten
end
