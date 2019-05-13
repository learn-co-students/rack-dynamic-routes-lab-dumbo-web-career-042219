require 'pry'
class Application
  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    unless req.path.match(/items/)
      resp.write "Route not found"
      resp.status = 404
    else
      item = req.path.split("/items/").last
      target = @@items.find {|ele| ele.name == item}
      # binding.pry
      if target
        resp.write target.price
      else 
        resp.write "Item not found"
        resp.status = 400
      end
    end

    resp.finish
  end
end