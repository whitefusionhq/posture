class ShoelaceFormController < ApplicationController
  def connect()
    super

    self.element.add_event_listener(%s:sl-submit:, submit_form.bind(self))
    self.element.closest(:form).add_event_listener(
      %s;turbo:submit-end;, submit_end.bind(self)
    )
  end

  def submit_form(event)
    form = self.element.closest(:form)
    submitter = self.element.query_selector(%s:sl-button[submit]:)

    return if submitter.disabled? # form already submitted, not submitting twice

    submitter.loading = true
    submitter.disabled = true

    event.detail.form_data.each do |entry|
      k, v = entry
      el = document.create_element(:input)
      el.type = :hidden
      el.name = k
      el.value = v
      el.delete_me_later = true
      form.append(el)
    end

    el = document.create_element(:input)
    el.name = :commit
    el.type = :submit
    el.value = submitter.inner_html
    el.style.display = :none
    el.delete_me_later = true
    form.append(el)

    el.click()
  end

  def submit_end(event)
    submitter = event.target.query_selector(%s:sl-button[submit]:)
    if submitter
      submitter.loading = false
      submitter.disabled = false
      reset(event.target)
    end
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

    form.query_selector_all(:input).each do |control|
      control.remove() if control.delete_me_later?
    end
  end
end

export default ShoelaceFormController
