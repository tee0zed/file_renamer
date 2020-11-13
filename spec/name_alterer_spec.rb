require 'spec_helper'

describe 'NameAlterer#renamed_filename' do
  context 'when single file with one extension rename' do
    let(:params_1) {{filename: "IMG_123.jpg", number: 0, new_name: "new_name"}}
    let(:path_alterer_1) { FileRenamer::NameAlterer.new }

    it 'renames only name' do
      expect(path_alterer_1.renamed_filename(params_1)).to eq "new_name.jpg"
    end 
  end

  context 'when second file with one extension rename' do
    let(:params_2) {{filename: "IMG_123.jpg", number: 1, new_name: "new_name"}}
    let(:path_alterer_2) { FileRenamer::NameAlterer.new }

    it 'adds number to name' do
      expect(path_alterer_2.renamed_filename(params_2)).to eq "new_name_1.jpg"
    end
  end

  context 'when single file with two extensions rename' do
    let(:params_3) {{filename: "IMG_123.html.erb", number: 0, new_name: "new_name"}}
    let(:path_alterer_3) { FileRenamer::NameAlterer.new }

    it 'renames only name' do
      expect(path_alterer_3.renamed_filename(params_3)).to eq "new_name.html.erb"
    end
  end

  context 'when second file with two extensions rename' do
    let(:params_4) {{filename: "IMG_123.html.erb", number: 2, new_name: "new_name"}}
    let(:path_alterer_4) { FileRenamer::NameAlterer.new }

    it 'adds number to name' do
      expect(path_alterer_4.renamed_filename(params_4)).to eq "new_name_2.html.erb"
    end
  end
end 
