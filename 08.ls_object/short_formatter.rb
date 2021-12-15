# frozen_string_literal: true

class ShortFormatter
  COLUMNS = 3
  COLUMN_SPACE = 5

  def initialize(option, file_data_list)
    @option = option
    @file_data_list = file_data_list
  end

  def output
    filenames = @file_data_list.map(&:name)

    split_filenames = filenames.each_slice((filenames.length / COLUMNS.to_f).ceil).to_a

    (split_filenames.first.length - split_filenames.last.length).times do
      split_filenames.last << ' '
    end

    transposed_split_filenames = split_filenames.transpose
    longest_name_length = filenames.map(&:length).max

    transposed_split_filenames.each do |transposed_split_filename|
      transposed_split_filename.each do |transposed_split_filename_element|
        print transposed_split_filename_element.ljust(longest_name_length + COLUMN_SPACE, ' ')
      end
      print "\n"
    end
  end
end
