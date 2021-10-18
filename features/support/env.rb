#------------Automation Environment variables List -------#
#   Author     --- Vinay Yebbare                          #
#                MANDATORY                                #
#   browsertype --- browser name                          #
#---------------------------------------------------------#


require 'rubygems'
require 'selenium/webdriver'
require 'rspec/expectations'
require 'watir'
require 'rake'
require 'pry'
require_relative './list_tags'
require_relative '../support/generalFunction'


$browsertype = ENV['browsertype']
Before do |scenario|
  # get all the tags associated with the scenario
  @scenario_tags = scenario.source_tag_names
  $scenario = scenario
  # Open the browser if the browser is closed
  tries = 0
  begin
    envSelect
    p " Current Browser value is :::::: #{@browser} :::Opening Browser now"
    @browser = $browser
    @browser.cookies.clear
  rescue StandardError => e
    print_error e
    if tries < 3
      tries += 1
      puts 'failed to open the browser trying to relaunch'
      retry
    else
      raise e
    end
  end
  # setup the common timeout
  @timeout = 200
  # get all the tags associated with the scenario
  @scenario_tags = scenario.source_tag_names
end


# This will execute for every  scenarios
After do |scenario|
  begin
    @browser.close
  rescue StandardError => e
    @browser.close
    p "Error occurred due to : #{e}"
  end
  p 'Closed Browser'
end

def envSelect
  browser = Watir::Browser.new :"#{$browsertype}"
  browser.driver.manage.window.maximize
  $browser = browser
end

def print_error(e)
  puts "Error occurred due to : #{e.message}"
end

at_exit do
  $browser.close
end