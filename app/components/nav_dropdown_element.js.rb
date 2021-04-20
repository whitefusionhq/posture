class NavDropdown < ApplicationElement
  define %s:nav-dropdown:

  def item_click(event)
    event.target.query_selector_all("a, input[type=submit]").each do |el|
      el.click()
    end
  end
end
