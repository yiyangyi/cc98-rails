# encoding: utf-8

class PhotoUploader < BaseUploader

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  process resize_to_limit: [1280, nil]

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "something.jpg" if original_filename
  end

end
