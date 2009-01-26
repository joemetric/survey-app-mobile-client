class MockupsController < ApplicationController
  layout :select_layout

  # To add a mockup, just create a new *.html.erb file in app/views/mockups.
  # It will then be accessible from /mockups and (directly) /mockups/my_mockup
  # You can optionally define actions for each mockup if you want to use a
  # layout or use instance variables

  # def my_mockup
  #   layout 'application'
  #   @some_obj = SomeObject.new
  # end

  def index
    files = Dir.glob "#{Rails.root}/app/views/mockups/**/[^_]*.erb"
    @pages = files.map { |f| f.scan(/mockups\/([^.]+)/).flatten.first }
  end

  private

    def select_layout
      @layout || 'application'
    end

    def layout(name)
      @layout = name
    end
end
