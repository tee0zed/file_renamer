
require 'file_renamer'

describe 'FileRenamer' do 
  context '#get_paths' do 
    before(:each) { 
      i = 1 
      3.times do 
        File.write("./spec/fixtures/dir/file#{i}.txt", "")
        i += 1
      end 

      i = 1 
      3.times do 
        File.write("./spec/fixtures/dir/pict#{i}.jpg", "")
        i += 1
      end 
    }

    after(:each) {
      Dir["./spec/fixtures/dir/*"].each do |f|
        File.delete(f) if File.exists? f
      end 
    }

    let(:params1) {{ dir: "./spec/fixtures/dir/", ext: nil, prefix: nil, name: 'new_name' }}
    let(:obj1) { FileRenamer.new(params1) }
    it 'returns all Path objects' do 
      obj1.get_paths

      expect(obj1.paths.count).to eq 6
      expect(obj1.paths.all?{|o| o.is_a? Path}).to eq true 
      expect(obj1.paths.map(&:path)).to match_array ["./spec/fixtures/dir/pict3.jpg", 
                                                     "./spec/fixtures/dir/pict2.jpg", 
                                                     "./spec/fixtures/dir/pict1.jpg", 
                                                     "./spec/fixtures/dir/file1.txt",
                                                     "./spec/fixtures/dir/file2.txt", 
                                                     "./spec/fixtures/dir/file3.txt" ]

    end 
  end 

  context '#correct_ext' do
    let(:params) {{ ext: 'jpg' }}
    let(:obj) { FileRenamer.new(params) } 
    it 'return ext string with dot if ext not nil' do 
      obj.send(:correct_ext)
      expect(obj.params[:ext]).to eq '.jpg'
    end 

    let(:params1) {{ ext: 'jpganyany' }}
    let(:obj1) { FileRenamer.new(params1) } 
    it 'return nil if ext not matches regexp' do 
      obj1.send(:correct_ext)
      expect(obj1.params[:ext]).to eq nil
    end 

    let(:params2) {{ ext: nil }}
    let(:obj2) { FileRenamer.new(params2) } 
    it 'return nil if ext nil' do 
      obj2.send(:correct_ext)
      expect(obj2.params[:ext]).to eq nil
    end 
  end 

  context '#correct_dir' do
    let(:params) {{ dir: './spec/fixtures/dir/' }}
    let(:obj) { FileRenamer.new(params) } 
    it 'return dir string if dir exists' do 
      obj.send(:correct_dir)
      expect(obj.params[:dir]).to eq './spec/fixtures/dir/'
    end 

    let(:params1) {{ dir: './spec/fixtures/dir2/' }}
    let(:obj1) { FileRenamer.new(params1) } 
    it 'return nil if dir does not exists' do 
      obj1.send(:correct_dir)
      expect(obj1.params[:dir]).to eq nil
    end 

    let(:params2) {{ dir: './spec/fixtures/dir' }}
    let(:obj2) { FileRenamer.new(params2) } 
    it 'add slash to the end of path' do 
      obj2.send(:correct_dir)
      expect(obj2.params[:dir]).to eq './spec/fixtures/dir/'
    end 
  end 

  context '#correct_prefix' do
    let(:params) {{ prefix: " DCIM\n" }}
    let(:obj) { FileRenamer.new(params) } 
    it 'strips prefix string if prefix exists' do 
      obj.send(:correct_prefix)
      expect(obj.params[:prefix]).to eq 'DCIM'
    end 

    let(:params1) {{ prefix: nil }}
    let(:obj1) { FileRenamer.new(params1) } 
    it 'return nil if prefix does not exists' do 
      obj1.send(:correct_prefix)
      expect(obj1.params[:prefix]).to eq nil
    end 
  end 

  context '#correct_name' do
    let(:params) {{ name: "new name  " }}
    let(:obj) { FileRenamer.new(params) } 
    it 'deletes spaces from filename and strips' do 
      obj.send(:correct_name)
      expect(obj.params[:name]).to eq 'new_name'
    end 

    let(:params1) {{ name: nil }}
    let(:obj1) { FileRenamer.new(params1) } 
    it 'return nil if name does not exists' do 
      obj1.send(:correct_name)
      expect(obj1.params[:name]).to eq nil
    end 

    let(:params2) {{ name: 'name any any ////&&$^' }}
    let(:obj2) { FileRenamer.new(params1) } 
    it 'return nil if name does not matches regexp' do 
      obj1.send(:correct_name)
      expect(obj1.params[:name]).to eq nil
    end 
  end 
end 
