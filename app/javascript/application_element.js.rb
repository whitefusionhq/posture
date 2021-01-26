import [ CrystallineElement ], from: "crystalline-element"

class ApplicationElement < CrystallineElement
  async def context_element(element_name)
    await custom_elements.when_defined element_name
    self.closest(element_name) || document.query_selector("body > #{element_name}")
  end
end

export [ ApplicationElement ]
