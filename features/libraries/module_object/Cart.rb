module Cart
  def cart_items
    @browser.trs(class: /cart-item ng-scope/).count
  end

  def cart_msg
    @browser.p(class: /cart-msg/)
  end

  def cart_msg_item
    @browser.p(class: /cart-msg/).span(class: /cart-count ng-binding/)
  end

  def cart_item(ind)
    @browser.tr(class: /cart-item ng-scope/, index:ind).text
  end

  def cart_item_cost(ind)
    @browser.tr(class: /cart-item ng-scope/, index:ind).text.split("$")
  end
end