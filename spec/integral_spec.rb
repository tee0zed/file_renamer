require 'spec_helper'

describe "FileRenamer" do 
  context "integral test" do 
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
          File.delete(f) if File.exists?(f)
        end 
      }

  let(:params1) {{ dir: "./spec/fixtures/dir/", prefix: "file", ext: "txt", name: "new_name" }}
    it 'renames files correctly' do
      FileRenamer::Path.reset_counter
      FileRenamer::Renamer.rename!(params1)
      expect(Dir["./spec/fixtures/dir/*"]).to match_array ["./spec/fixtures/dir/new_name.txt", 
                                                           "./spec/fixtures/dir/new_name_1.txt", 
                                                           "./spec/fixtures/dir/new_name_2.txt",
                                                           "./spec/fixtures/dir/pict1.jpg", 
                                                           "./spec/fixtures/dir/pict2.jpg", 
                                                           "./spec/fixtures/dir/pict3.jpg"]
    end

    let(:params2) {{ dir: "./spec/fixtures/dir/", prefix: "pict", ext: "txt", name: "new_name" }}
    it 'doesnt renames if prefix and ext doesnt match any of files' do
      FileRenamer::Path.reset_counter
      FileRenamer::Renamer.rename!(params2)
      expect(Dir["./spec/fixtures/dir/*"]).to match_array ["./spec/fixtures/dir/file1.txt", 
                                                           "./spec/fixtures/dir/file2.txt", 
                                                           "./spec/fixtures/dir/file3.txt",
                                                           "./spec/fixtures/dir/pict1.jpg", 
                                                           "./spec/fixtures/dir/pict2.jpg", 
                                                           "./spec/fixtures/dir/pict3.jpg"]
    end

    let(:params3) {{ dir: "./spec/fixtures/dir/", prefix: nil, ext: "jpg", name: "new_name" }}
    it 'renames files correctly if only ext passed' do
      FileRenamer::Path.reset_counter
      FileRenamer::Renamer.rename!(params3)
      expect(Dir["./spec/fixtures/dir/*"]).to match_array ["./spec/fixtures/dir/file1.txt", 
                                                           "./spec/fixtures/dir/file2.txt", 
                                                           "./spec/fixtures/dir/file3.txt",
                                                           "./spec/fixtures/dir/new_name.jpg", 
                                                           "./spec/fixtures/dir/new_name_1.jpg", 
                                                           "./spec/fixtures/dir/new_name_2.jpg"]
    end

    let(:params4) {{ dir: "./spec/fixtures/dir/", prefix: "file", ext: "jpg", name: "new_name" }}
    it 'doesnt renames if prefix and ext doesnt match any of files' do
      FileRenamer::Path.reset_counter
      FileRenamer::Renamer.rename!(params4)
      expect(Dir["./spec/fixtures/dir/*"]).to match_array ["./spec/fixtures/dir/file1.txt", 
                                                           "./spec/fixtures/dir/file2.txt", 
                                                           "./spec/fixtures/dir/file3.txt",
                                                           "./spec/fixtures/dir/pict1.jpg", 
                                                           "./spec/fixtures/dir/pict2.jpg", 
                                                           "./spec/fixtures/dir/pict3.jpg"]
    end

    let(:params5) {{ dir: "./spec/fixtures/dir/", prefix: 'pict', ext: nil, name: "new_name" }}
    it 'renames files correctly if only prefix passed' do
      FileRenamer::Path.reset_counter
      FileRenamer::Renamer.rename!(params5)
      expect(Dir["./spec/fixtures/dir/*"]).to match_array ["./spec/fixtures/dir/file1.txt", 
                                                           "./spec/fixtures/dir/file2.txt", 
                                                           "./spec/fixtures/dir/file3.txt",
                                                           "./spec/fixtures/dir/new_name.jpg", 
                                                           "./spec/fixtures/dir/new_name_1.jpg", 
                                                           "./spec/fixtures/dir/new_name_2.jpg"]
    end
  end 
end 