class Toaster
  SECONDS_VISIBLE = 4

  def self.toast_all() = Elemental.query_all("sl-alert[type]").each { |el| el.toast() }

  def self.raise(icon, message, type: :success)
    contents = html <<~HTML
      <sl-icon name="#{icon}" slot="icon"></sl-icon>
      #{message}
    HTML

    Elemental.create(%s:sl-alert:) do |a|
      a.type = type
      a.duration = SECONDS_VISIBLE * 1000
      %i:click touchmove:.each do |event_type|
        a.add_event_listener(event_type) { a.hide() }
      end
    end => sl_alert

    render contents, sl_alert # lit-html FTW!
    document.body.append sl_alert
    sl_alert.toast()
  end
end

export default Toaster
