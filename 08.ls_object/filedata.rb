# frozen_string_literal: true

require './option'

class Filedata
  attr_reader :filedata

  def initialize(option)
    @option = Option.new(option)
    @filedata = @option.a_option? ? Dir.glob('*', File::FNM_DOTMATCH) : Dir.glob('*')
    @filedata.reverse! if @option.r_option?
  end
end
