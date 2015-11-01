require 'erb'
require 'chartkick'
require 'lazy_high_charts'
include Chartkick::Helper
include LazyHighCharts::LayoutHelper

def template( graph , details)
  %{

  <!DOCTYPE html>
  <html>
  <head>

    <script src="jsapi.js"></script>
    <script src="jquery-2.1.4.min.js"></script>
    <script src="chartkick.js"></script>
    <script src="highcharts.js"></script>
    <script src="highcharts-more.js"></script>
    <script src="highstock.js"></script>

    <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="syntax.css">

  </head>
  <body style="padding-top: 50px">

    <div class="container" style="padding-left: 0px ; padding-right: 0px ; padding-right: 5px ; padding-left: 5px ;">

        <div class="panel panel-info">
          <div class="panel-heading">
            <h1 class="panel-title text-center">Quantum Random Walk Simulation</h1>
          </div>
          <div class="panel-body" id="some_id">

          </div>
          <div class="panel-footer text-center">
            #{details}
          </div>
        </div>

    </div>
      #{graph}
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








