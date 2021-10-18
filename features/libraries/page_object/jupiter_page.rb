class Jupiter
  include Shop
  include Contact
  include Cart

  def initialize(browser)
    @browser = browser
  end

  def mega_nav_sel(type)
    @browser.a(href: type).fire_event :click
  end
end