require 'lazy_high_charts'
require 'awesome_print'
include LazyHighCharts::LayoutHelper




		graph = LazyHighCharts::HighChart.new('graph') do |f|
			  f.chart(:type => 'heatmap' , :inverted => true)
			  f.title(:text => "Sample Heat Map")
			  f.subtitle(:text => "" , :align => "left")

			  f.xAxis(
			  	:tickPixelInterval => 50 ,
			  	:min => 1430438400000 ,
			  	:max => 1432944000000
			   ) 
			  
			  f.yAxis(
			  	:title => { :text => nil },
			  	:labels => {:format => '{value}:00'},
			  	:minPadding => 0,
			  	:maxPadding => 0,
			  	:startOnTick => false,
			  	:endOnTcik => false,
			  	:tickPositions => [0, 6, 12, 18, 24],
			  	:tickWidth => 1,
			  	:min => 0,
			  	:max => 23

			  )
			  f.colorAxis(
			  	:stops => [ [0, '#3060cf'] , [0.5, '#fffbbc'] , [0.9, '#c4463a'] ],
			  	:min => -5
			  )

			  f.series( 
			  	:borderWidth => 0 , 
			  	:colorSize => 24*365 , 
			  	:tooltip => {:headerFormat => 'Temperature<br/>' , :pointFormat => '{point.x:%e %b, %Y} {point.y}:00: <b>{point.value} ℃</b>'} 
			  	)

			  f.data(
			  	:csv => %{Date, Time, Temperature
2015-05-01,0,2.0
2015-05-01,1,1.7
2015-05-01,2,1.5
2015-05-01,3,1.5
2015-05-01,4,1.1
2015-05-01,5,1.1
2015-05-01,6,1.1
2015-05-01,7,0.8
2015-05-01,8,0.3
2015-05-01,9,-0.7
2015-05-01,10,1.0
2015-05-01,11,3.4
2015-05-01,12,4.5
2015-05-01,13,5.5
2015-05-01,14,5.7
2015-05-01,15,6.7
2015-05-01,16,6.0
2015-05-01,17,5.7
2015-05-01,18,5.1
2015-05-01,19,5.0
2015-05-01,20,4.5
2015-05-01,21,3.3
2015-05-01,22,2.9
2015-05-01,23,3.6
2015-05-01,0,2.3
2015-05-01,1,2.2
2015-05-01,2,1.8
2015-05-01,3,1.9
2015-05-01,4,2.5
2015-05-01,5,3.2
2015-05-01,6,1.9
2015-05-01,8,1.1
2015-05-01,9,0.7
2015-05-01,7,1.0
2015-05-01,10,1.4
2015-05-01,11,0.6
2015-05-01,12,1.7
2015-05-01,13,2.3
2015-05-01,14,2.5
2015-05-01,15,2.5
2015-05-01,16,4.2
2015-05-01,18,3.2
2015-05-01,17,3.9
2015-05-01,19,3.6
2015-05-01,20,2.0
2015-05-01,21,1.6
2015-05-01,22,1.5
2015-05-01,23,1.5
2015-05-02,0,1.1
2015-05-02,1,0.8
2015-05-02,2,0.9
2015-05-02,3,0.9
2015-05-02,4,1.0
2015-05-02,5,0.9
2015-05-02,6,0.2
2015-05-02,8,-1.5
2015-05-02,7,-0.9
2015-05-02,9,-0.4
2015-05-02,10,1.3
2015-05-02,11,3.5
2015-05-02,12,3.6
2015-05-02,13,3.8
2015-05-02,14,4.3
2015-05-02,15,6.0
2015-05-02,16,5.7
2015-05-02,17,6.2
2015-05-02,18,5.4
2015-05-02,19,4.2
2015-05-02,20,4.8
2015-05-02,21,4.4
2015-05-02,22,4.3
2015-05-02,23,4.2
2015-05-03,0,3.9
2015-05-03,1,3.8
2015-05-03,2,3.7
2015-05-03,3,3.7
2015-05-03,4,3.3
2015-05-03,5,3.1
2015-05-03,7,3.3
2015-05-03,6,3.2
2015-05-03,8,3.2
2015-05-03,9,3.1
2015-05-03,10,3.4
2015-05-03,11,4.0
2015-05-03,12,4.4
2015-05-03,13,5.0
2015-05-03,14,5.7
2015-05-03,15,5.9
2015-05-03,16,7.1
2015-05-03,17,5.7
2015-05-03,18,6.0
2015-05-03,19,5.6
2015-05-03,20,4.4
2015-05-03,21,2.8
2015-05-03,22,0.4
2015-05-03,23,-0.6
2015-05-04,0,-1.1
2015-05-04,1,-1.8
2015-05-04,2,-1.8
2015-05-04,3,-1.9
2015-05-04,4,-2.2
2015-05-04,5,-2.5
2015-05-04,7,-2.9
2015-05-04,6,-2.5
2015-05-04,8,-2.8
2015-05-04,9,-2.3
2015-05-04,10,-0.2
2015-05-04,11,2.5
2015-05-04,12,3.6
2015-05-04,13,5.2
2015-05-04,14,6.1
2015-05-04,15,6.2
2015-05-04,16,6.5
2015-05-04,17,6.7
2015-05-04,18,5.8
2015-05-04,19,5.4
2015-05-04,20,3.5
2015-05-04,21,1.0
2015-05-04,22,0.0
2015-05-04,23,-0.3
2015-05-05,0,-0.9
2015-05-05,1,-0.7
2015-05-05,2,-0.4
2015-05-05,3,-0.5
2015-05-05,4,0.2
2015-05-05,5,0.7
2015-05-05,6,1.0
2015-05-05,7,0.9
2015-05-05,8,0.5
2015-05-05,9,0.4
2015-05-05,10,0.4
2015-05-05,11,0.7
2015-05-05,12,1.1
2015-05-05,13,1.8
2015-05-05,14,2.1
2015-05-05,15,2.3
2015-05-05,16,2.3
2015-05-05,17,2.3
2015-05-05,18,2.8
2015-05-05,19,2.3
2015-05-05,20,2.1
2015-05-05,21,1.9
2015-05-05,22,1.9
2015-05-05,23,1.8
2015-05-06,0,1.7
2015-05-06,1,1.9
2015-05-06,2,2.1
2015-05-06,3,2.2
2015-05-06,4,2.3
2015-05-06,5,2.0
2015-05-06,6,1.9
2015-05-06,7,2.0
2015-05-06,8,2.0
2015-05-06,9,3.2
2015-05-06,10,4.0
2015-05-06,11,5.2
2015-05-06,12,5.4
2015-05-06,13,6.7
2015-05-06,14,7.2
2015-05-06,15,7.1
2015-05-06,16,6.5
2015-05-06,17,6.3
2015-05-06,18,8.4
2015-05-06,19,6.0
2015-05-06,20,5.7
2015-05-06,21,5.2
2015-05-06,22,8.6
2015-05-06,23,8.9
2015-05-07,0,7.5
2015-05-07,1,6.2
2015-05-07,2,6.7
2015-05-07,3,7.1
2015-05-07,4,6.0
2015-05-07,5,6.1
2015-05-07,6,6.4
2015-05-07,7,5.6
2015-05-07,8,5.3
2015-05-07,9,5.9
2015-05-07,10,6.8
2015-05-07,11,7.5
2015-05-07,12,7.6
2015-05-07,13,8.3
2015-05-07,14,8.7
2015-05-07,15,9.1
2015-05-07,16,9.9
2015-05-07,17,9.4
2015-05-07,18,9.5
2015-05-07,19,8.9
2015-05-07,20,8.0
2015-05-07,21,7.7
2015-05-07,22,7.7
2015-05-07,23,7.5
2015-05-08,0,7.4
2015-05-08,1,6.6
2015-05-08,2,6.9
2015-05-08,3,6.9
2015-05-08,4,6.4
2015-05-08,5,6.0
2015-05-08,6,5.6
2015-05-08,7,4.9
2015-05-08,8,5.2
2015-05-08,9,4.4
2015-05-08,10,5.7
2015-05-08,11,6.7
2015-05-08,12,7.5
2015-05-08,13,8.9
2015-05-08,14,9.9
2015-05-08,15,10.6
2015-05-08,16,9.7
2015-05-08,17,9.9
2015-05-08,18,9.8
2015-05-08,19,8.6
2015-05-08,20,7.6
2015-05-08,22,5.8
2015-05-08,21,6.0
2015-05-08,23,5.2
2015-05-09,0,7.7
2015-05-09,1,8.1
2015-05-09,2,8.3
2015-05-09,3,8.3
2015-05-09,4,7.3
2015-05-09,5,7.3
2015-05-09,6,7.0
2015-05-09,7,7.4
2015-05-09,8,7.4
2015-05-09,9,7.5
2015-05-09,10,8.3
2015-05-09,11,8.5
2015-05-09,12,9.2
2015-05-09,13,10.2
2015-05-09,14,10.8
2015-05-09,15,10.7
2015-05-09,16,10.4
2015-05-09,17,11.0
2015-05-09,18,10.6
2015-05-09,19,9.5
2015-05-09,20,9.5
2015-05-09,21,8.9
2015-05-09,22,8.7
2015-05-09,23,9.1
2015-05-10,0,9.6
2015-05-10,1,9.4
2015-05-10,2,8.5
2015-05-10,3,7.7
2015-05-10,4,8.0
2015-05-10,5,7.7
2015-05-10,6,7.6
2015-05-10,7,9.1
2015-05-10,8,7.8
2015-05-10,9,7.7
2015-05-10,10,7.7
2015-05-10,11,8.7
2015-05-10,12,10.4
2015-05-10,13,11.1
2015-05-10,14,12.1
2015-05-10,15,12.8
2015-05-10,16,12.8
2015-05-10,17,12.9
2015-05-10,18,12.6
2015-05-10,19,11.9
2015-05-10,20,10.2
2015-05-10,21,8.0
2015-05-10,22,5.7
2015-05-10,23,4.4
2015-05-11,0,3.6
2015-05-11,1,4.4
2015-05-11,2,5.2
2015-05-11,3,4.9
2015-05-11,4,4.0
2015-05-11,5,3.7
2015-05-11,6,3.7
2015-05-11,7,3.0
2015-05-11,8,3.6
2015-05-11,9,5.5
2015-05-11,10,6.9
2015-05-11,11,7.5
2015-05-11,12,8.7
2015-05-11,13,8.8
2015-05-11,14,9.1
2015-05-11,15,9.2
2015-05-11,16,11.4
2015-05-11,17,10.5
2015-05-11,18,10.1
2015-05-11,19,8.8
2015-05-11,20,7.5
2015-05-11,21,6.2
2015-05-11,22,4.5
2015-05-11,23,4.2
2015-05-12,0,3.7
2015-05-12,1,3.3
2015-05-12,2,3.1
2015-05-12,3,3.0
2015-05-12,4,3.1
2015-05-12,5,3.0
2015-05-12,6,3.0
2015-05-12,7,2.8
2015-05-12,8,2.8
2015-05-12,9,3.2
2015-05-12,10,4.6
2015-05-12,11,4.6
2015-05-12,12,5.7
2015-05-12,13,6.4
2015-05-12,14,5.0
2015-05-12,15,5.6
2015-05-12,16,3.8
2015-05-12,17,5.2
2015-05-12,18,3.7
2015-05-12,19,3.7
2015-05-12,20,4.2
2015-05-12,21,2.9
2015-05-12,22,3.0
2015-05-12,23,3.0
2015-05-13,0,2.5
2015-05-13,1,2.2
2015-05-13,2,1.6
2015-05-13,3,1.5
2015-05-13,4,1.3
2015-05-13,5,1.6
2015-05-13,6,2.0
2015-05-13,7,2.8
2015-05-13,8,3.0
2015-05-13,9,2.9
2015-05-13,10,3.2
2015-05-13,11,3.2
2015-05-13,12,3.4
2015-05-13,13,4.0
2015-05-13,14,3.8
2015-05-13,15,4.9
2015-05-13,17,4.1
2015-05-13,16,3.8
2015-05-13,18,5.0
2015-05-13,19,5.4
2015-05-13,20,3.8
2015-05-13,21,2.3
2015-05-13,22,1.6
2015-05-13,23,1.7
2015-05-14,0,1.9
2015-05-14,1,1.6
2015-05-14,2,1.6
2015-05-14,3,1.7
2015-05-14,4,1.7
2015-05-14,5,1.4
2015-05-14,6,0.4
2015-05-14,7,0.4
2015-05-14,8,0.3
2015-05-14,9,0.3
2015-05-14,10,0.3
2015-05-14,11,0.5
2015-05-14,12,0.9
2015-05-14,13,1.2
2015-05-14,14,1.6
2015-05-14,15,2.6
2015-05-14,16,3.3
2015-05-14,17,6.2
2015-05-14,18,5.4
2015-05-14,19,5.9
2015-05-14,20,6.6
2015-05-14,21,6.7
2015-05-14,22,7.1
2015-05-14,23,4.8
2015-05-15,0,5.3
2015-05-15,1,4.8
2015-05-15,2,4.6
2015-05-15,3,4.9
2015-05-15,4,4.9
2015-05-15,5,6.4
2015-05-15,6,4.2
2015-05-15,7,3.3
2015-05-15,8,3.8
2015-05-15,10,4.5
2015-05-15,9,4.1
2015-05-15,11,4.9
2015-05-15,12,4.6
2015-05-15,13,6.6
2015-05-15,14,6.0
2015-05-15,15,6.0
2015-05-15,16,4.9
2015-05-15,17,6.6
2015-05-15,18,7.0
2015-05-15,19,5.9
2015-05-15,20,5.1
2015-05-15,21,4.4
2015-05-15,22,3.7
2015-05-15,23,3.4
2015-05-16,0,4.0
2015-05-16,1,5.1
2015-05-16,2,5.1
2015-05-16,3,4.9
2015-05-16,4,4.7
2015-05-16,5,4.6
2015-05-16,6,4.6
2015-05-16,7,4.3
2015-05-16,8,4.3
2015-05-16,9,4.3
2015-05-16,11,4.6
2015-05-16,10,4.7
2015-05-16,12,5.4
2015-05-16,13,5.9
2015-05-16,14,6.1
2015-05-16,15,7.0
2015-05-16,16,7.9
2015-05-16,17,6.6
2015-05-16,18,6.6
2015-05-16,19,6.4
2015-05-16,20,6.1
2015-05-16,21,5.9
2015-05-16,22,5.6
2015-05-16,23,5.1
2015-05-17,0,4.4
2015-05-17,1,3.0
2015-05-17,2,1.6
2015-05-17,3,0.7
2015-05-17,4,0.6
2015-05-17,5,-0.1
2015-05-17,6,-0.4
2015-05-17,7,0.1
2015-05-17,8,0.2
2015-05-17,9,2.0
2015-05-17,10,4.9
2015-05-17,11,6.1
2015-05-17,12,7.3
2015-05-17,13,8.7
2015-05-17,14,9.8
2015-05-17,15,10.1
2015-05-17,16,10.2
2015-05-17,17,11.1
2015-05-17,18,11.1
2015-05-17,19,10.9
2015-05-17,20,7.5
2015-05-17,21,5.0
2015-05-17,22,2.9
2015-05-17,23,2.8
2015-05-18,0,2.3
2015-05-18,1,1.6
2015-05-18,2,1.0
2015-05-18,4,0.7
2015-05-18,5,0.7
2015-05-18,6,-0.2
2015-05-18,7,0.2
2015-05-18,3,0.2
2015-05-18,8,1.0
2015-05-18,9,2.7
2015-05-18,10,5.3
2015-05-18,11,7.1
2015-05-18,12,7.7
2015-05-18,13,8.9
2015-05-18,14,9.8
2015-05-18,15,10.7
2015-05-18,16,11.3
2015-05-18,17,10.9
2015-05-18,18,9.4
2015-05-18,19,9.3
2015-05-18,20,8.8
2015-05-18,21,8.3
2015-05-18,22,6.9
2015-05-18,23,5.2
2015-05-19,0,3.8
2015-05-19,1,3.3
2015-05-19,2,2.6
2015-05-19,3,2.0
2015-05-19,4,2.0
2015-05-19,5,2.0
2015-05-19,6,2.5
2015-05-19,7,2.3
2015-05-19,8,3.1
2015-05-19,9,5.1
2015-05-19,10,6.8
2015-05-19,11,7.9
2015-05-19,12,9.0
2015-05-19,13,10.3
2015-05-19,14,11.1
2015-05-19,15,12.2
2015-05-19,16,12.5
2015-05-19,17,13.7
2015-05-19,18,14.4
2015-05-19,19,14.0
2015-05-19,20,11.3
2015-05-19,21,7.0
2015-05-19,22,5.7
2015-05-19,23,5.3
2015-05-20,0,4.9
2015-05-20,1,4.1
2015-05-20,2,3.6
2015-05-20,3,3.3
2015-05-20,4,2.8
2015-05-20,5,3.0
2015-05-20,6,2.7
2015-05-20,7,1.9
2015-05-20,8,2.5
2015-05-20,9,5.4
2015-05-20,10,8.0
2015-05-20,11,9.4
2015-05-20,12,10.5
2015-05-20,13,12.2
2015-05-20,14,13.2
2015-05-20,15,14.5
2015-05-20,16,15.5
2015-05-20,17,15.5
2015-05-20,18,15.4
2015-05-20,19,16.1
2015-05-20,20,12.9
2015-05-20,21,9.2
2015-05-20,22,7.9
2015-05-20,23,7.3
2015-05-21,0,5.7
2015-05-21,1,4.6
2015-05-21,2,5.0
2015-05-21,3,4.4
2015-05-21,4,3.7
2015-05-21,5,2.9
2015-05-21,6,2.8
2015-05-21,7,2.8
2015-05-21,8,2.7
2015-05-21,9,5.7
2015-05-21,10,8.5
2015-05-21,11,9.9
2015-05-21,12,9.0
2015-05-21,13,8.0
2015-05-21,14,7.2
2015-05-21,15,7.7
2015-05-21,16,8.4
2015-05-21,17,8.1
2015-05-21,18,8.2
2015-05-21,19,9.5
2015-05-21,20,8.4
2015-05-21,21,7.6
2015-05-21,22,6.5
2015-05-21,23,5.4
2015-05-22,0,5.1
2015-05-22,1,3.8
2015-05-22,2,3.0
2015-05-22,3,2.8
2015-05-22,4,4.0
2015-05-22,5,4.3
2015-05-22,6,5.2
2015-05-22,7,5.3
2015-05-22,8,6.0
2015-05-22,9,6.5
2015-05-22,10,7.4
2015-05-22,11,8.4
2015-05-22,12,8.7
2015-05-22,13,9.3
2015-05-22,14,10.5
2015-05-22,15,10.9
2015-05-22,16,11.1
2015-05-22,17,10.0
2015-05-22,18,8.2
2015-05-22,19,7.3
2015-05-22,20,7.7
2015-05-22,21,7.7
2015-05-22,22,8.1
2015-05-22,23,9.0
2015-05-23,0,8.9
2015-05-23,1,8.4
2015-05-23,2,8.3
2015-05-23,3,8.0
2015-05-23,4,7.6
2015-05-23,5,7.3
2015-05-23,6,6.9
2015-05-23,7,6.7
2015-05-23,8,6.5
2015-05-23,9,6.6
2015-05-23,10,6.9
2015-05-23,11,7.6
2015-05-23,12,8.3
2015-05-23,13,7.5
2015-05-23,14,6.1
2015-05-23,15,7.1
2015-05-23,16,6.7
2015-05-23,17,5.3
2015-05-23,18,5.9
2015-05-23,19,6.2
2015-05-23,20,5.9
2015-05-23,21,5.3
2015-05-23,22,4.6
2015-05-23,23,3.6
2015-05-24,0,3.0
2015-05-24,1,3.0
2015-05-24,2,2.2
2015-05-24,3,1.7
2015-05-24,4,1.4
2015-05-24,5,1.9
2015-05-24,6,1.6
2015-05-24,7,1.4
2015-05-24,8,2.1
2015-05-24,9,3.1
2015-05-24,10,3.4
2015-05-24,11,3.9
2015-05-24,12,5.4
2015-05-24,13,5.2
2015-05-24,14,5.6
2015-05-24,15,5.8
2015-05-24,16,5.8
2015-05-24,17,5.3
2015-05-24,18,4.0
2015-05-24,19,3.0
2015-05-24,20,2.1
2015-05-24,21,1.7
2015-05-24,22,1.4
2015-05-24,23,1.2
2015-05-25,0,0.8
2015-05-25,1,0.6
2015-05-25,2,0.4
2015-05-25,3,0.5
2015-05-25,4,0.5
2015-05-25,5,0.5
2015-05-25,6,0.8
2015-05-25,7,0.7
2015-05-25,8,0.7
2015-05-25,9,0.7
2015-05-25,10,1.0
2015-05-25,12,2.6
2015-05-25,13,2.9
2015-05-25,11,2.0
2015-05-25,14,2.9
2015-05-25,15,3.3
2015-05-25,16,3.9
2015-05-25,17,4.2
2015-05-25,18,4.3
2015-05-25,19,4.7
2015-05-25,20,4.8
2015-05-25,21,5.2
2015-05-25,22,4.3
2015-05-25,23,4.0
2015-05-26,0,4.0
2015-05-26,1,4.7
2015-05-26,2,5.1
2015-05-26,3,4.6
2015-05-26,4,4.8
2015-05-26,5,4.7
2015-05-26,6,4.5
2015-05-26,7,3.8
2015-05-26,8,3.0
2015-05-26,9,3.4
2015-05-26,10,4.8
2015-05-26,11,6.3
2015-05-26,12,7.2
2015-05-26,13,6.3
2015-05-26,14,5.1
2015-05-26,15,7.2
2015-05-26,16,6.5
2015-05-26,17,5.6
2015-05-26,18,7.0
2015-05-26,19,7.4
2015-05-26,20,6.3
2015-05-26,21,5.9
2015-05-26,22,5.3
2015-05-26,23,4.5
2015-05-27,0,4.1
2015-05-27,1,4.1
2015-05-27,2,4.5
2015-05-27,3,4.7
2015-05-27,4,3.9
2015-05-27,5,2.6
2015-05-27,6,1.5
2015-05-27,7,0.8
2015-05-27,8,1.9
2015-05-27,9,4.5
2015-05-27,10,6.5
2015-05-27,11,7.6
2015-05-27,12,8.0
2015-05-27,13,9.1
2015-05-27,14,9.3
2015-05-27,15,9.3
2015-05-27,16,9.0
2015-05-27,17,9.8
2015-05-27,18,10.0
2015-05-27,19,9.5
2015-05-27,20,7.5
2015-05-27,21,4.2
2015-05-27,22,2.6
2015-05-27,23,2.7
2015-05-28,0,1.4
2015-05-28,1,0.7
2015-05-28,2,0.6
2015-05-28,3,-0.1
2015-05-28,4,-0.1
2015-05-28,5,-0.7
2015-05-28,6,-0.2
2015-05-28,7,0.4
2015-05-28,8,1.5
2015-05-28,9,4.3
2015-05-28,10,6.0
2015-05-28,11,7.2
2015-05-28,12,8.2
2015-05-28,13,8.6
2015-05-28,14,8.3
2015-05-28,15,10.0
2015-05-28,16,10.5
2015-05-28,17,10.8
2015-05-28,18,10.8
2015-05-28,19,10.7
2015-05-28,20,7.9
2015-05-28,21,4.4
2015-05-28,22,1.9
2015-05-28,23,1.4
2015-05-29,0,1.4
2015-05-29,1,0.8
2015-05-29,2,1.1
2015-05-29,3,2.0
2015-05-29,4,2.2
2015-05-29,5,1.5
2015-05-29,6,1.7
2015-05-29,7,2.1
2015-05-29,8,4.3
2015-05-29,9,4.6
2015-05-29,10,4.2
2015-05-29,11,5.2
2015-05-29,12,5.2
2015-05-29,13,6.0
2015-05-29,14,6.7
2015-05-29,15,8.5
2015-05-29,16,8.1
2015-05-29,17,8.8
2015-05-29,18,10.3
2015-05-29,19,9.2
2015-05-29,20,7.2
2015-05-29,21,5.7
2015-05-29,22,2.4
2015-05-29,23,0.9
2015-05-30,0,0.4
2015-05-30,1,0.3
2015-05-30,2,0.1
2015-05-30,3,0.2
2015-05-30,4,0.7
2015-05-30,5,1.9
2015-05-30,6,2.6
2015-05-30,7,3.2
2015-05-30,8,2.7
2015-05-30,9,2.6
2015-05-30,10,2.9
2015-05-30,11,4.0
2015-05-30,12,5.1
2015-05-30,13,5.8
2015-05-30,14,6.3
2015-05-30,15,6.8
2015-05-30,16,8.7
2015-05-30,17,9.1
2015-05-30,18,7.4
2015-05-30,19,7.3
2015-05-30,20,7.0
2015-05-30,21,6.1
2015-05-30,22,5.6
2015-05-30,23,4.5}
			  )
		end



ap high_chart("some_id", graph )