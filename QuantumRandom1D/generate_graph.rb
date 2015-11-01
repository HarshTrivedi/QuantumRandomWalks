require 'erb'
require 'chartkick'
include Chartkick::Helper

def template( graph , details)
  %{

  <!DOCTYPE html>
  <html>
  <head>

    <script src="jsapi.js"></script>
    <script src="chartkick.js"></script>
    <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="syntax.css">

  </head>
  <body style="padding-top: 50px">

    <div class="container" style="padding-left: 0px ; padding-right: 0px ; padding-right: 5px ; padding-left: 5px ;">

        <div class="panel panel-info">
          <div class="panel-heading">
            <h1 class="panel-title text-center">Quantum Random Walk Simulation</h1>
          </div>
          <div class="panel-body">
            #{graph}
          </div>
          <div class="panel-footer text-center">
            #{details}
          </div>
        </div>

    </div>          
  </body>
  </html>

  }
end






class ErbWrapper
  include ERB::Util
  attr_accessor :template 

  def initialize( template )
    @template = template
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end








