# encoding: utf-8

class AvatarUploader < BaseUploader

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [16, 16]
  end

  version :normal do
    process resize_to_fit: [49, 49]
  end

  version :middle do
    process resize_to_fit: [81, 81]
  end

  version :large do
    process resize_to_fit: [121, 121]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "something.jpg" if original_filename
  end

end
