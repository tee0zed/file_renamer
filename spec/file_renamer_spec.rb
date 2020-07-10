require 'file_renamer'
require 'byebug'

describe 'FileRenamer' do 
let(:obj) { FileRenamer.new(
    @dir = nil
    @paths = []
  )}
  
  context '#path_spec' do
    it 'return path if dir exists' do 
      expect(obj.send(:correct_dir, "./spec/fixtures/dir")).to eq "./spec/fixtures/dir"
    end 
  end 
end 