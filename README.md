  ![](https://ruby-gem-downloads-badge.herokuapp.com/file_renamer?&style=plastic)
  ![](http://badges.github.io/stability-badges/dist/experimental.svg)
  
# FileRenamer

Simple bulk file renaming tool.

https://rubygems.org/gems/file_renamer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'file_renamer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install file_renamer

## Usage

### From terminal

    filerenamer [options]
    -d --dir (optional)
    -p --prefix (optional)
    -e --extension (optional)
    -n --name (required)

- Use `--dir` key to specify directory where you want script to be ran (not required in terminal version)

*IMPORTANT!   
  If no `--dir` passed to parameters, directory where script where executed will be proceed.*

- Use `--name` key to specify `new_name` for the files that should be renamed 

  First will be named `new_name`, second - `new_name_1`, third - `new_name_2` etc.

- Use `--prefix` key to specify prefix for the filenames that should be renamed

  If `file` passed to `--prefix`
  and directory contains 3 files: `file1`, `file2`, `picture3` 
  Only `file1` and `file2` will be renamed, `picture3` will stay untouched.

- Use `--ext` key to specify file extension for the filenames that should be renamed

  If `jpg`(dot is not required) passed to `--ext` 
  and directory contains 3 files: `file1.txt`, `file2.jpg`, `picture3.jpg` 
  Only `file2.jpg` and `picture3.jpg` will be renamed, `file1.txt` will stay untouched.

*IMPORTANT!*
*- If no prefix neither extension passed to the script EVERY file in directory will be renamed, except directories.*

*HINT:*
*- You can mix --ext and --prefix to concretize conditions*

### In your project 

    FileRenamer::Renamer.rename!(params) 
where 
 - params[:dir] - for execution directory (required)
 - params[:prefix] - for filename's prefixes 
 - params[:ext] - for filename's extensions
 - params[:name] - for filename's new names (required)

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

TODO: extension change

## Contributing

1. Fork it ( https://github.com/[my-github-username]/file_renamer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Spec 

```
rake spec_all 
```
in project folder to run all specs 

## License 

MIT License. 

2020 Tee Zed