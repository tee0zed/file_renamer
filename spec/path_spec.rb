require 'path'

describe "Path" do 
  context "#correct_path?" do 
    let(:params1) {{ name: 'new_name', prefix: nil, ext: nil }}
    let(:no_opt_params) { Path.new('/Documents/DCIM_123.jpg', params1)} 
    it "return true for all paths without options" do
      expect(no_opt_params.correct_path?).to eq true 
    end 

    let(:params2) {{ name: 'new_name', prefix: 'DCIM', ext: '.jpg' }}
    let(:with_options_params_correct) { Path.new('/Documents/DCIM_123.jpg', params2) }
    it "return true if options matches path" do 
      expect(with_options_params_correct.correct_path?).to eq true 
    end 

    let(:params3) {{ name: 'new_name', prefix: 'DCIM', ext: nil }}
    let(:with_prefix_correct) { Path.new('/Documents/DCIM_123.png', params3) }
    it "return true if prefix matches path" do 
      expect(with_prefix_correct.correct_path?).to eq true 
    end 

    let(:params4) {{ name: 'new_name', prefix: nil, ext: '.jpg' }}
    let(:with_ext_correct) { Path.new('/Documents/IMG_123.jpg', params4) }
    it "return true if extension matches path" do 
      expect(with_ext_correct.correct_path?).to eq true 
    end 

    let(:params5) {{ name: 'new_name', prefix: 'IMG', ext: '.png' }}
    let(:with_options_params_incorrect) { Path.new('/Documents/IMG_123.jpg', params5) }
    it "return false if prefix not matches path" do 
      expect(with_options_params_incorrect.correct_path?).to eq false 
    end 

    let(:params6) {{ name: 'new_name', prefix: 'IMG', ext: '.jpg' }}
    let(:with_options_params_incorrect) { Path.new('/Documents/DCIM_123.jpg', params6) }
    it "return false if extension not matches path" do 
      expect(with_options_params_incorrect.correct_path?).to eq false 
    end 
  end 

  context '#renamed_path' do
    let(:params7) {{ name: 'new_name', prefix: nil, ext: '.jpg' }} 
    let(:with_ext_params) { Path.new('/Documents/IMG_123.jpg', params7) }
    it 'renames file correctly if extension param passed' do 
      expect(with_ext_params.send(:renamed_path, 1)).to eq "/Documents/1_new_name.jpg"
    end 

    let(:params8) {{ name: 'new_name', prefix: nil, ext: nil }}
    let(:without_ext_params) { Path.new('/Documents/IMG_123.jpg', params8) }
    it 'renames file correctly if extension param not passed' do 
      expect(without_ext_params.send(:renamed_path, 1)).to eq "/Documents/1_new_name.jpg"
    end 

    let(:params9) {{ name: 'new_name', prefix: nil, ext: nil }}
    let(:filename_w_two_dots_with_ext_params) { Path.new('/Documents/IMG_123.html.erb', params9) }
    it 'renames file with two extensions correctly if extension param passed' do 
      expect(filename_w_two_dots_with_ext_params.send(:renamed_path, 1)).to eq "/Documents/1_new_name.html.erb"
    end 

    let(:params10) {{ name: 'new_name', prefix: 'DCIM', ext: '.jpg' }}
    let(:filename_w_two_dots_without_ext_params) { Path.new('/Documents/IMG_123.html.erb', params10) }
    it 'renames file with two extensions correctly if extension param not passed' do 
      expect(filename_w_two_dots_without_ext_params.send(:renamed_path, 1)).to eq "/Documents/1_new_name.html.erb"
    end 
  end 
end 