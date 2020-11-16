# frozen_string_literal: false

require 'spec_helper'

describe 'ParamsCorrector#corrected_params' do
  before :each do
    @corrector = FileRenamer::ParamsCorrector.new
  end

  context 'when extension without dot' do
    let(:params) { { ext: 'jpg', dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    let(:ext) { @corrector.corrected_params(params)[:ext] }

    it 'return ext string with dot' do
      expect(ext).to eq '.jpg'
    end
  end

  context 'when extension not matches regexp' do
    let(:params) { { ext: 'jpganyany', dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    let(:ext) { @corrector.corrected_params(params)[:ext] }

    it 'return nil' do
      expect(ext).to be nil
    end
  end

  context 'when extension empty' do
    let(:params) { { ext: nil, dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    let(:ext) { @corrector.corrected_params(params)[:ext] }

    it 'return nil' do
      expect(ext).to be nil
    end
  end

  context 'when dir exists' do
    let(:params) { { dir: './spec/fixtures/dir', ext: nil, name: 'new_name' } }
    let(:dir) { @corrector.corrected_params(params)[:dir] }

    it 'return path string' do
      expect( File.directory?(dir) ).to be true
    end

    it 'adds slash to the end of path' do
      expect(dir[-1]).to eq '/'
    end
  end

  context 'when dir does not exists' do
    let(:params) { { dir: './spec/fixtures/dir2/', ext: nil, name: 'new_name' } }

    it 'raise error' do
      expect{ @corrector.corrected_params(params) }.to raise_error(StandardError, "Directory must exist!")
    end
  end

  context 'when prefix mathces regexp' do
    let(:params) { { prefix: " DCIM\n", ext: nil, dir: './spec/fixtures/dir/', name: 'new_name' } }
    let(:prefix) { @corrector.corrected_params(params)[:prefix] }

    it 'strips prefix' do
      expect(prefix).to eq 'DCIM'
    end
  end

  context 'when prefix does not exists' do
    let(:params) { { dir: './spec/fixtures/dir/', prefix: nil, ext: nil, name: 'new_name' } }
    let(:prefix) { @corrector.corrected_params(params)[:prefix] }

    it 'return empty string if prefix does not exists' do
      expect(prefix).to eq ''
    end
  end

  context 'when name exists' do
    let(:params) { { dir: './spec/fixtures/dir/', name: "new_name", ext: nil } }
    let(:name) { @corrector.corrected_params(params)[:name] }

    it 'raise error' do
      expect(name).to eq "new_name"
    end
  end

  context 'when name does not exists' do
    let(:params) { { dir: './spec/fixtures/dir/', name: nil, ext: nil } }

    it 'raise error' do
      expect{ @corrector.corrected_params(params) }.to raise_error(StandardError, "Incorrect name!")
    end
  end

  context 'when name does not matches regexp' do
    let(:params) { { dir: './spec/fixtures/dir/', name: 'name any any ///&&&', ext: nil } }

    it 'raise error' do
      expect{ @corrector.corrected_params(params) }.to raise_error(StandardError, "Incorrect name!")
    end
  end
end
