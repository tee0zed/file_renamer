
require 'optparse'
require_relative 'lib/file_renamer'
require_relative 'lib/path'

params = {}
OptionParser.new do |opts|
  opts.on('-n --name STRING', String)
  opts.on('-p --prefix STRING', String)
  opts.on('-e --extension STRING', String)
  opts.on('-d --dir STRING', String)
end.parse!(into: params)

FileRenamer.rename!(params)

puts "#{Path.get_count} paths renamed!"