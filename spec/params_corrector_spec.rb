# frozen_string_literal: false

require 'spec_helper'

describe 'ParamsCorrector#corrected_params' do
  before :each do
    @corrector = FileRenamer::ParamsCorrector.new
  end

  context 'when extension parameter correction' do
    let(:params) { { ext: 'jpg', dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    it 'return ext string with dot if ext not nil' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:ext]).to eq '.jpg'
    end

    let(:params1) { { ext: '.jpg', dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    it 'return ext string with dot if ext not nil' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:ext]).to eq '.jpg'
    end

    let(:params2) { { ext: 'jpganyany', dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    it 'return nil if ext not matches regexp' do
      corrected_params = @corrector.corrected_params(params2)
      expect(corrected_params[:ext]).to eq nil
    end

    let(:params3) { { ext: nil, dir: './spec/fixtures/dir/', prefix: nil, name: 'new_name' } }
    it 'return nil if ext nil' do
      corrected_params = @corrector.corrected_params(params3)
      expect(corrected_params[:ext]).to eq nil
    end
  end

  context 'when dir parameter correction' do
    let(:params) { { dir: './spec/fixtures/dir/', ext: nil, name: 'new_name' } }
    it 'return path string if dir exists' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:dir]).to eq './spec/fixtures/dir/'
    end

    let(:params1) { { dir: './spec/fixtures/dir2/', ext: nil, name: 'new_name' } }
    it 'raise error if dir does not exists' do
      expect{ @corrector.corrected_params(params1) }.to raise_error(StandardError, "Directory must exist!")
    end

    let(:params2) { { dir: './spec/fixtures/dir', ext: nil, name: 'new_name' } }
    it 'adds slash to the end of path' do
      corrected_params = @corrector.corrected_params(params2)
      expect(corrected_params[:dir]).to eq './spec/fixtures/dir/'
    end
  end

  context 'when prefix parameter correction' do
    let(:params) { { prefix: " DCIM\n", ext: nil, dir: './spec/fixtures/dir/', name: 'new_name' } }
    it 'strips prefix string if prefix exists' do
      corrected_params = @corrector.corrected_params(params)
      expect(corrected_params[:prefix]).to eq 'DCIM'
    end

    let(:params1) { { dir: './spec/fixtures/dir/', prefix: nil, ext: nil, name: 'new_name' } }
    it 'return empty string if prefix does not exists' do
      corrected_params = @corrector.corrected_params(params1)
      expect(corrected_params[:prefix]).to eq ''
    end
  end

  context 'when name parameter correction' do
    let(:params1) { { dir: './spec/fixtures/dir/', name: nil, ext: nil } }
    it 'raise error if name does not exists' do
      expect{ @corrector.corrected_params(params1) }.to raise_error(StandardError, "Incorrect name!")
    end

    let(:params2) { { dir: './spec/fixtures/dir/', name: 'name any any ///&&&', ext: nil } }
    it 'raise error if name does not matches regexp' do
      expect{ @corrector.corrected_params(params2) }.to raise_error(StandardError, "Incorrect name!")
    end
  end
end
