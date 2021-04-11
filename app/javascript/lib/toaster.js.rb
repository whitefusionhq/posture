class Toaster
  SECONDS_VISIBLE = 4

  def self.toast_all() = document.query_selector_all("sl-alert[type]").each { |el| el.toast() }

  def self.raise(icon, message, type: :success)
    contents = html <<~HTML
      <sl-icon name="#{icon}" slot="icon"></sl-icon>
      #{message}
    HTML

    sl_alert = document.create_element(%s:sl-alert:).tap do |a|
      a.type = type
      a.duration = SECONDS_VISIBLE * 1000
      %i:click touchmove:.each do |event_type|
        a.add_event_listener(event_type) { a.hide() }
      end
    end
    render contents, sl_alert

    document.body.append(alert)
    alert.toast()
  end
end

export default Toaster
