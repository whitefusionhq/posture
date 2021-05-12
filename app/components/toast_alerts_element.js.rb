class ToastAlertsElement < ApplicationElement
  define %s:toast-alerts:

  def connected_callback()
    super

    this.parent_node.query_selector_all("sl-alert[type]").each do |el|
      el.toast()
    end

    # any disabled forms hanging out there? re-enable them
    Elemental.query_all("input[data-disable-with]").each do |el|
      el.disabled = false
    end
  end
end
