LIBRARY_FOLDERS = ['/lib/',
                   '/model/']

LIBRARY_FOLDERS.each do |lib_folder|
  Dir[File.dirname(__FILE__) + lib_folder + '*.rb'].each {|file| require file }
end
