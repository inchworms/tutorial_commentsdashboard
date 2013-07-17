RSpec::Matchers.define :match_date do |expected_string|
  match do |actual|
    format_date(actual) == expected_string # '2013-06-16'
  end

  # failure_message_for_should do |actual|
  #   "expected that #{actual} would be a precise multiple of #{expected}"
  # end

  # failure_message_for_should_not do |actual|
  #   "expected that #{actual} would not be a precise multiple of #{expected}"
  # end

  # description do
  #   "be a precise multiple of #{expected}"
  # end

  def format_date date
    "%d-%02d-%02d" % [date.year, date.month, date.day]
  end
end 