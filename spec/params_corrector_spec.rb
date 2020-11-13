require 'spec_helper'

describe 'ParamsCorrector#corrected_params' do
  before :each do
    @corrector = FileRenamer::ParamsCorrector.new
  end

  context 'extension parameter correction' do
    let(:params) {{ ext: 'jpg' }}
    it 'return ext string with dot if ext not nil' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:ext]).to eq '.jpg'
    end

    let(:params1) {{ ext: '.jpg' }}
    it 'return ext string with dot if ext not nil' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:ext]).to eq '.jpg'
    end

    let(:params2) {{ ext: 'jpganyany' }}
    it 'return nil if ext not matches regexp' do
      corrected_params = @corrector.corrected_params(params2)
      expect(corrected_params[:ext]).to eq nil
    end

    let(:params3) {{ ext: nil }}
    it 'return nil if ext nil' do
      corrected_params = @corrector.corrected_params(params3)
      expect(corrected_params[:ext]).to eq nil
    end
  end

  context 'dir parameter correction' do
    let(:params) {{ dir: './spec/fixtures/dir/' }}
    it 'return path string if dir exists' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:dir]).to eq './spec/fixtures/dir/'
    end

    let(:params1) {{ dir: './spec/fixtures/dir2/' }}
    it 'return nil if dir does not exists' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:dir]).to eq nil
    end

    let(:params2) {{ dir: './spec/fixtures/dir' }}
    it 'adds slash to the end of path' do
      corrected_params = @corrector.corrected_params(params2)
      expect(corrected_params[:dir]).to eq './spec/fixtures/dir/'
    end
  end

  context 'prefix parameter correction' do
    let(:params) {{ prefix: " DCIM\n" }}
    it 'strips prefix string if prefix exists' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:prefix]).to eq 'DCIM'
    end

    let(:params1) {{ prefix: nil }}
    it 'return empty string if prefix does not exists' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:prefix]).to eq ""
    end
  end

  context 'name parameter correction' do
    let(:params) {{ name: "new name  " }}
    it 'deletes spaces from filename and strips' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:name]).to eq 'new_name'
    end

    let(:params1) {{ name: nil }}
    it 'return nil if name does not exists' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:name]).to eq nil
    end

    let(:params2) {{ name: 'name any any ////&&$^' }}
    it 'return nil if name does not matches regexp' do
      corrected_params = @corrector.corrected_params(params2)
      expect(corrected_params[:name]).to eq nil
    end
  end
end