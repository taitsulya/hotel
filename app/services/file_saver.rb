# frozen_string_literal: true

class FileSaver
  def self.save(directory, file_name, content)
    directory.mkdir unless Dir.exist?(directory)
    path = "#{directory}/#{file_name}"
    File.open(path, 'wb') do |file|
      file << content
    end
  end
end
