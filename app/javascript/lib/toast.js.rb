def raise_toast(message, type = :success)
  contents = html <<~HTML
    <sl-icon name="bookmark-star" slot="icon"></sl-icon>
    #{message}
  HTML

  alert = document.create_element("sl-alert").tap do |a|
            a.type = type
            a.duration = 5000
            a.add_event_listener :click do
              a.hide()
            end
          end
  render contents, alert

  document.body.append(alert)
  alert.toast()
end

export default raise_toast