module Shop
  def item_counter
    @browser.lis(class: /product ng-scope/)
  end

  def product_selected(ind)
    @browser.li(class: /product ng-scope/, index:ind)
  end
end