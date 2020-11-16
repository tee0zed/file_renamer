# frozen_string_literal: false

require_relative 'spec_helper'

describe 'PathProcessor#rename_files' do
  before(:each) do
    i = 1
    3.times do
      File.write("./spec/fixtures/dir/file#{i}.txt", '')
      i += 1
    end

    i = 1
    3.times do
      File.write("./spec/fixtures/dir/pict#{i}.jpg", '')
      i += 1
    end
  end

  after(:each) do
    Dir['./spec/fixtures/dir/*'].each do |f|
      File.delete(f)
    end
  end

  context 'when prefix and extension passed' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: 'file', ext: 'txt', name: 'new_name' } } }

    it 'renames only file*.txt' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/new_name.txt
        ./spec/fixtures/dir/new_name_1.txt
        ./spec/fixtures/dir/new_name_2.txt
        ./spec/fixtures/dir/pict1.jpg
        ./spec/fixtures/dir/pict2.jpg
        ./spec/fixtures/dir/pict3.jpg
      ]
    end
  end

  context 'when only ext passed' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: nil, ext: 'jpg', name: 'new_name' } } }

    it 'renames only *.jpeg' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/file1.txt
        ./spec/fixtures/dir/file2.txt
        ./spec/fixtures/dir/file3.txt
        ./spec/fixtures/dir/new_name.jpg
        ./spec/fixtures/dir/new_name_1.jpg
        ./spec/fixtures/dir/new_name_2.jpg
      ]
    end
  end

  context 'when only prefix passed' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: 'pict', ext: nil, name: 'new_name' } } }

    it 'renames only pict*' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/file1.txt
        ./spec/fixtures/dir/file2.txt
        ./spec/fixtures/dir/file3.txt
        ./spec/fixtures/dir/new_name.jpg
        ./spec/fixtures/dir/new_name_1.jpg
        ./spec/fixtures/dir/new_name_2.jpg
      ]
    end
  end

  context 'when prefix and ext doesnt matches any of files' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: 'pict', ext: 'txt', name: 'new_name' } } }

    it 'renames nothing' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/file1.txt
        ./spec/fixtures/dir/file2.txt
        ./spec/fixtures/dir/file3.txt
        ./spec/fixtures/dir/pict1.jpg
        ./spec/fixtures/dir/pict2.jpg
        ./spec/fixtures/dir/pict3.jpg
      ]
    end
  end

  context 'when prefix and ext doesnt match any of files' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: 'file', ext: 'jpg', name: 'new_name' } } }

    it 'renames nothing' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/file1.txt
        ./spec/fixtures/dir/file2.txt
        ./spec/fixtures/dir/file3.txt
        ./spec/fixtures/dir/pict1.jpg
        ./spec/fixtures/dir/pict2.jpg
        ./spec/fixtures/dir/pict3.jpg
      ]
    end
  end

  context 'when nor prefix neither ext passed' do
    let(:args) { { params: { dir: './spec/fixtures/dir/', prefix: nil, ext: nil, name: 'new_name' } } }

    it 'renames everything' do
      FileRenamer::PathProcessor.run!(args)
      expect(Dir['./spec/fixtures/dir/*']).to match_array %w[
        ./spec/fixtures/dir/new_name.txt
        ./spec/fixtures/dir/new_name_1.txt
        ./spec/fixtures/dir/new_name_2.txt
        ./spec/fixtures/dir/new_name_3.jpg
        ./spec/fixtures/dir/new_name_4.jpg
        ./spec/fixtures/dir/new_name_5.jpg
      ]
    end
  end
end
