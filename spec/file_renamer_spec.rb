require 'file_renamer'

describe 'FileRenamer' do 
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
    let(:params) {{ path: './spec/fixtures/dir/' }}
    let(:obj) { FileRenamer.new(params) } 
    it 'return dir string if dir exists' do 
      obj.send(:correct_dir)
      expect(obj.params[:path]).to eq './spec/fixtures/dir/'
    end 

    let(:params1) {{ path: './spec/fixtures/dir2/' }}
    let(:obj1) { FileRenamer.new(params1) } 
    it 'return nil if dir does not exists' do 
      obj1.send(:correct_dir)
      expect(obj1.params[:path]).to eq nil
    end 

    let(:params2) {{ path: './spec/fixtures/dir' }}
    let(:obj2) { FileRenamer.new(params2) } 
    it 'add slash to the end of path' do 
      obj2.send(:correct_dir)
      expect(obj2.params[:path]).to eq './spec/fixtures/dir/'
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