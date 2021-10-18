def scroll_to_bottom
  x = 0
  y = 100000
  @browser.execute_script("window.scrollBy(#{x},#{y})")
end

def scroll_to_top
  x = 0
  y = -100000
  @browser.execute_script("window.scrollBy(#{x},#{y})")
end


def page_load
  sleep 2
  case $browsertype
  when /#{'safari'}/i
    scroll_to_bottom
    sleep 2
    scroll_to_top
    sleep 2
  else
    for i in 0..6
      @browser.send_keys :page_down
    end
    for i in 0..6
      @browser.send_keys :page_up
    end
  end
end

def load_url(url,tries = 1)
  begin
    @browser.goto(url)
    page_load
  rescue Net::ReadTimeout => e
    if tries > 0
      tries -= 1
      puts "Page did not load at the first attempt ::: Attempting again \n::: Retries left - #{tries}"
      retry
    else
      abort "--> Error: Page did not load due to slowness [#{url}] : #{e}"
    end
  end
end