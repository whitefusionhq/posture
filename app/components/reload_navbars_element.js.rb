class ReloadNavbars < ApplicationElement
  define %s:reload-navbars:

  def connected_callback()
    super

    Daniel.get("/navbars").then async do |response|
      navbars = await response.text()
      Elemental.create :template do |tmpl|
        tmpl.inner_html = navbars

        Elemental.query("#topbar").inner_html = tmpl.content.query_selector("#topbar").inner_html
      end
      set_timeout 100 do
        self.remove()
      end
    end
  end
end
