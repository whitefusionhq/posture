# Ruby has Faraday. Ruby2JS has Daniel.
# Get it? Daniel. Faraday. 😎

class Daniel
  self.debug = false

  async def self.get(url)
    conn = self.new(url, method: :get, params: {})
    response = await conn.request()

    puts("* Daniel response:", response) if self.debug

    response
  end

  async def self.post(url, params)
    conn = self.new(url, method: :post, params: params)
    response = await conn.request()

    puts("* Daniel response:", response) if self.debug

    response
  end

  async def self.put(url, params)
    conn = self.new(url, method: :put, params: params)
    response = await conn.request()

    puts("* Daniel response:", response) if self.debug

    response
  end

  async def self.delete(url, params)
    conn = self.new(url, method: :delete, params: params)
    response = await conn.request()

    puts("* Daniel response:", response) if self.debug

    response
  end

  def initialize(url, method:, params:)
    @url = url
    @method = method.upcase()
    @params = params
  end

  async def request()
    headers = {
      "X-CSRF-Token": self.csrf_token(),
    }
    headers["Content-Type"] = "application/json" unless @params.instance_of?(FormData)

    if @method == :GET
      await fetch(@url,
                  method: @method,
                  headers: headers)
    else
      body = @params.instance_of?(FormData) ? @params : @params.inspect
      await fetch(@url,
                  method: @method,
                  headers: headers,
                  body: body)
    end
  end

  def csrf_token()
    document.head.query_selector(%(meta[name="csrf-token"])).content
  end
end

export default Daniel
