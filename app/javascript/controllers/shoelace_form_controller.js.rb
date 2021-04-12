class ShoelaceFormController < ApplicationController
  def connect()
    super

    self.element.add_event_listener(%s:sl-submit:, submit_form.bind(self))
    self.element.closest(:form).add_event_listener(
      %s;turbo:submit-end;, submit_end.bind(self)
    )
  end

  def submit_form(event) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    form = self.element.closest(:form)
    submitter = self.element.query_selector(%s:sl-button[submit]:)

    return if submitter.disabled? # form already submitted, not submitting twice

    submitter.loading = true
    submitter.disabled = true

    event.detail.form_data.each do |entry|
      k, v = entry
      Elemental.create :input do |el|
        el.type = :hidden
        el.name = k
        el.value = v
        el.delete_me_later = true
        form.append(el)
      end
    end

    Elemental.create :input do |el|
      el.name = :commit
      el.type = :submit
      el.value = submitter.inner_html
      el.style.display = :none
      el.delete_me_later = true
      form.append(el)
      el.click()
    end
  end

  def submit_end(event)
    submitter = event.target.query_selector(%s:sl-button[submit]:)
    return unless submitter

    set_timeout 100 do
      Toaster.toast_all()
    end

    submitter.loading = false
    submitter.disabled = false
    reset(event.target)
  end

  def reset(form)
    form.query_selector(%s:sl-form:).get_form_controls().then do |controls|
      controls.each do |control|
        case control.tag_name.downcase()
        when %s:sl-checkbox:, %s:sl-radio:
          control.checked = false
        else
          control.value = ""
        end
      end
    end

    form.query_selector(%s:sl-form:).get_form_controls().then do |controls|
      controls.first.set_focus()
    end

    form.query_selector_all(:input).each do |control|
      control.remove() if control.delete_me_later?
    end
  end
end

export default ShoelaceFormController
