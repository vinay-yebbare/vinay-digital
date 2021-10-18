module Contact
  def mega_nav_sel(type)
    @browser.a(href: type).fire_event :click
  end

  def contact_object(object, id)
    case object
    when 'TextBox'
      @browser.text_field(id: /#{id}/)
    # when 'email'
    #   @browser.text_field(id: /#{id}/)
    when 'msg'
      @browser.textarea(id: /#{id}/)
    else
      puts 'The object is not valid'
    end
  end

  def success_msg
  @browser.div(class: /alert alert-success/)
  end
end