
require 'json'

data_for_x = ["x"]
data_for_y = ["temperatur"]

File.open("data", "r") do |f|
  f.each_line do |line|
    if match = line.match(/(?<date>\S*-\S*)(?:\s)(?<temp>.*)/)
      data_for_x.push(match["date"])
      data_for_y.push(match["temp"])
    end
  end
end


graph_data = {
  bindto: '#this_is_my_awesom_graph',
  data: {
    x: 'x',
    columns: [
#      ['x', "asdf", "p", "kjh", "wer", "ew", "ewr"],
#      ['temperatur', 3030, 200, 100, 400, 150, 250]
       data_for_x,
       data_for_y
    ],
    axes: {
      temperatur: 'y',
    }
  },
  axis: {
    x: {
      type: 'category',
      tick: {
        rotate: 60,
        multiline: false,
	culling: {
	  max: 20
	}
      }
    },
    y: {
      label: {
        text: 'Temperatur',
        position: 'outer-middle'
      },
      tick: {
        values: 
	[0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0,8.5,9.0,9.5,10.0,10.5,11.0,11.5,12.0,12.5,13.0,13.5,14.0,14.5,15.0,15.5,16.0,16.5,17.0,17.5,18.0,18.5,19.0,19.5,20.0,20.5,21.0,21.5,22.0,22.5,23.0,23.5,24.0,24.5,25.0,25.5,26.0,26.5,27.0,27.5,28.0,28.5,29.0,29.5,30.0,30.5,31.0,31.5,32.0,32.5,33.0,33.5,34.0,34.5,35.0,35.5,36.0,36.5,37.0,37.5,38.0,38.5,39.0,39.5,40.0]
      }
    },
  },
  tooltip: {
#   enabled: false
  },
  zoom: {
    enabled: true
  },
  subchart: {
    show: true,
  },
  legend: {
    hide: true
  }
}

# https://c3js.org/samples/grid_y_lines.html

output = "var chart = c3.generate("
#output = JSON.pretty_generate("#{JSON(graph_data)}")
output += "#{JSON(graph_data)}"
output += ");"

puts output

File.write('/var/www/html/mydata.js', output)
