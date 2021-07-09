class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        @@cart << item
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.any?
      @@cart.each{|item|resp.write "#{item}\n"}
      else resp.write "Your cart is empty"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/add/)
      item_key = req.params["item"]
      resp.write handle_searchadd(item_key)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_searchadd(item_key)
    if @@items.include?(item_key)
      @@cart << item_key
      return "added #{item_key}"
    else "We don't have that item"
    end
  end
end