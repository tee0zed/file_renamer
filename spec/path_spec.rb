require 'path'

describe "Path" do 
  context "#correct_path?" do 
    let(:no_opt_params_correct) { Path.new('/Documents/DCIM_123.jpg', 'new_name', nil, nil) } 
    it "return true for all paths without options" do
      expect(no_opt_params_correct.correct_path?).to eq true 
    end 

    let(:with_options_params_correct) { Path.new('/Documents/DCIM_123.jpg', 'new_name', 'DCIM', '.jpg') }
    it "return true if options matches path" do 
      expect(with_options_params_correct.correct_path?).to eq true 
    end 

    let(:with_prefix_correct) { Path.new('/Documents/DCIM_123.png', 'new_name', 'DCIM', nil) }
    it "return true if prefix matches path" do 
      expect(with_prefix_correct.correct_path?).to eq true 
    end 

    let(:with_ext_correct) { Path.new('/Documents/IMG_123.jpg', 'new_name', nil, '.jpg') }
    it "return true if extension matches path" do 
      expect(with_ext_correct.correct_path?).to eq true 
    end 

    let(:with_options_params_incorrect) { Path.new('/Documents/IMG_123.jpg', 'new_name', 'DCIM', '.jpg') }
    it "return false if prefix not matches path" do 
      expect(with_options_params_incorrect.correct_path?).to eq false 
    end 

    let(:with_options_params_incorrect) { Path.new('/Documents/DCIM_123.jpg', 'new_name', 'DCIM', '.txt') }
    it "return false if extension not matches path" do 
      expect(with_options_params_incorrect.correct_path?).to eq false 
    end 
  end 

  context '.renamed_path' do 
    let(:with_ext_params) { Path.new('/Documents/IMG_123.png', 'new_name', nil, '.png') }
    it 'renames file correctly if extension param passed' do 
      expect(with_ext_params.send(:renamed_path)).to eq "/Documents/new_name.png"
    end 

    let(:without_ext_params) { Path.new('/Documents/IMG_123.jpg', 'new_name', nil, nil) }
    it 'renames file correctly if extension param not passed' do 
      expect(without_ext_params.send(:renamed_path)).to eq "/Documents/new_name.jpg"
    end 

    let(:filename_w_two_dots_with_ext_params) { Path.new('/Documents/IMG_123.html.erb', 'new_name', nil, '.erb') }
    it 'renames file with two extensions correctly if extension param passed' do 
      expect(filename_w_two_dots_with_ext_params.send(:renamed_path)).to eq "/Documents/new_name.html.erb"
    end 

    let(:filename_w_two_dots_without_ext_params) { Path.new('/Documents/IMG_123.html.erb', 'new_name', nil, nil) }
    it 'renames file with two extensions correctly if extension param not passed' do 
      expect(filename_w_two_dots_without_ext_params.send(:renamed_path)).to eq "/Documents/new_name.html.erb"
    end 
  end 
end 