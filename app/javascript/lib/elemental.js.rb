class Elemental
  def self.create(name, &block)
    document.create_element(name).tap do |el|
      block.(el)
    end
  end

  def self.query(selector)
    document.query_selector(selector)
  end

  def self.query_all(selector)
    document.query_selector_all(selector)
  end
end

export default Elemental
