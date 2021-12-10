# frozen_string_literal: true

class ShortFormat
  COLUMNS = 3.to_f
  COLUMN_SPACE = 5

  def initialize(option, file_data_list)
    @option = option
    @file_data_list = file_data_list
  end

  def output
    name_list = @file_data_list.map {|file_data| file_data.name}

    split_name_list = name_list.each_slice((name_list.length / COLUMNS).ceil).to_a

    (split_name_list.first.length - split_name_list.last.length).times do
      split_name_list.last << ' '
    end

    transposed_split_name_list = split_name_list.transpose
    longest_name_length = name_list.map(&:length).max

    transposed_split_name_list.each do |transposed_split_names|
      transposed_split_names.each do |transposed_split_name|
        print transposed_split_name.ljust(longest_name_length + COLUMN_SPACE, ' ')
      end
      print "\n"
    end
  end
end
