require 'spec_helper'

describe "PathProcessor#rename_files" do
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
      File.delete(f)
    end
  }

  context 'prefix and extension passed' do
    let(:args) {{ params: { dir: "./spec/fixtures/dir/", prefix: "file", ext: "txt", name: "new_name" }}}
    let(:path_processor) { FileRenamer::PathProcessor.new(args) }

    it 'renames only file*.txt' do
      path_processor.rename_files!
      expect(Dir["./spec/fixtures/dir/*"]).to match_array %w[
                                                            ./spec/fixtures/dir/new_name.txt
                                                            ./spec/fixtures/dir/new_name_1.txt
                                                            ./spec/fixtures/dir/new_name_2.txt
                                                            ./spec/fixtures/dir/pict1.jpg
                                                            ./spec/fixtures/dir/pict2.jpg
                                                            ./spec/fixtures/dir/pict3.jpg
                                                            ]
    end
  end

  context 'only ext passed' do
    let(:args) {{ params: { dir: "./spec/fixtures/dir/", prefix: nil, ext: "jpg", name: "new_name" }}}
    let(:path_processor) { FileRenamer::PathProcessor.new(args) }

    it 'renames only *.jpeg' do
      path_processor.rename_files!
      expect(Dir["./spec/fixtures/dir/*"]).to match_array %w[
                                                            ./spec/fixtures/dir/file1.txt
                                                            ./spec/fixtures/dir/file2.txt
                                                            ./spec/fixtures/dir/file3.txt
                                                            ./spec/fixtures/dir/new_name.jpg
                                                            ./spec/fixtures/dir/new_name_1.jpg
                                                            ./spec/fixtures/dir/new_name_2.jpg
                                                            ]
    end
  end

  context 'only prefix passed' do
    let(:args) {{ params: { dir: "./spec/fixtures/dir/", prefix: 'pict', ext: nil, name: "new_name" }}}
    let(:path_processor) { FileRenamer::PathProcessor.new(args) }

    it 'renames only pict*' do
      path_processor.rename_files!
      expect(Dir["./spec/fixtures/dir/*"]).to match_array %w[
                                                            ./spec/fixtures/dir/file1.txt
                                                            ./spec/fixtures/dir/file2.txt
                                                            ./spec/fixtures/dir/file3.txt
                                                            ./spec/fixtures/dir/new_name.jpg
                                                            ./spec/fixtures/dir/new_name_1.jpg
                                                            ./spec/fixtures/dir/new_name_2.jpg
                                                           ]
    end
  end

  context 'prefix and ext doesnt match any of files' do
    let(:args) {{ params: { dir: "./spec/fixtures/dir/", prefix: "pict", ext: "txt", name: "new_name" }}}
    let(:path_processor) { FileRenamer::PathProcessor.new(args) }

    it 'renames nothing' do
      path_processor.rename_files!
      expect(Dir["./spec/fixtures/dir/*"]).to match_array %w[
                                                            ./spec/fixtures/dir/file1.txt
                                                            ./spec/fixtures/dir/file2.txt
                                                            ./spec/fixtures/dir/file3.txt
                                                            ./spec/fixtures/dir/pict1.jpg
                                                            ./spec/fixtures/dir/pict2.jpg
                                                            ./spec/fixtures/dir/pict3.jpg
                                                            ]
    end
  end

  context 'prefix and ext doesnt match any of files' do
    let(:args) {{ params: { dir: "./spec/fixtures/dir/", prefix: "file", ext: "jpg", name: "new_name" }}}
    let(:path_processor) { FileRenamer::PathProcessor.new(args) }

    it 'renames nothing' do
      path_processor.rename_files!
      expect(Dir["./spec/fixtures/dir/*"]).to match_array %w[
                                                            ./spec/fixtures/dir/file1.txt
                                                            ./spec/fixtures/dir/file2.txt
                                                            ./spec/fixtures/dir/file3.txt
                                                            ./spec/fixtures/dir/pict1.jpg
                                                            ./spec/fixtures/dir/pict2.jpg
                                                            ./spec/fixtures/dir/pict3.jpg
                                                            ]
    end
  end
end