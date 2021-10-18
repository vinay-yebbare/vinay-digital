class Jupiter
  include Shop
  include Contact
  include Cart

  def initialize(browser)
    @browser = browser
  end
end