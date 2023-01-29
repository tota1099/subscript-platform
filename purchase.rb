require './errors.rb'

class Purchase

  def add(item)
    validate_format(item)
    return true
  end

  private

  def validate_format(string)
    raise WrongFormat unless string.match(/\d .+ at [+-]?([0-9]*[.])?[0-9]+/)
  end
end