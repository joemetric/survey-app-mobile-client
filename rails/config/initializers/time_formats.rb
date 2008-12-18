new_formats = {
  :standard  => '%B %d, %Y at %I:%M %p',
  :stub      => '%B %d',
  :stub_with_short_months => '%b %d',
  :stub_with_short_months_and_year => '%b %d %y',
  :time_only => '%I:%M %p',
  :plain     => '%B %d %I:%M %p',
  :mdy       => '%B %d, %Y',
  :human_mdy => '%A, %B %d, %Y',
  :human_mdy_short => '%a %b %d, %Y',
  :md        => '%b %d',
  :mdy       => '%b %d, %Y',
  :month     => '%B',
  :my        => '%B %Y',
  :simple    => '%m/%d/%Y',
  :datepicker => '%m/%d/%Y %I:%M %p',
  :unix      => '%m%d',
  :year      => '%y'
}
ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.update new_formats
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.update new_formats
