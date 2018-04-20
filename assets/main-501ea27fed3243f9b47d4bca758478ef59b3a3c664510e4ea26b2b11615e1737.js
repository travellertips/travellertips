/* Destinations map inizialization */
if (document.getElementById('visualization')) {
    google.load('visualization', '1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawVisualization);

    function drawVisualization() {

        var data = new google.visualization.DataTable();

        data.addColumn('string', 'Country');
        data.addColumn('number', 'Value'); 
        data.addColumn({type:'string', role:'tooltip'});

        data.addRows([[{v:'DE',f:'Germany'},0, _de + ' posts']]);
        data.addRows([[{v:'UA',f:'Ukraine'},0, _ua + ' posts']]);
        // v - value; f: formattedValue

        var options = {
            backgroundColor: {fill:'#FFFFFF', stroke:'#FFFFFF', strokeWidth:0 },
            colorAxis:  
                {minValue: 0, maxValue: 5,  colors: ['#159957', '#159957']},
            legend: 'none',	
            backgroundColor: {fill:'#FFFFFF', stroke:'#FFFFFF', strokeWidth:0 },	
            datalessRegionColor: '#F5F0E7',
            displayMode: 'regions', 
            enableRegionInteractivity: 'true', 
            resolution: 'countries',
            //sizeAxis: {minValue: 1, maxValue:1, minSize:10,  maxSize: 10},
            region:'150',
            keepAspectRatio: true,
            width:'100%',
            //height:500,
            tooltip: {textStyle: {color: '#444444'}, trigger:'focus'}	
        };

        var chart = new google.visualization.GeoChart(document.getElementById('visualization')); 
        chart.draw(data, options);

        // Add our selection handler.
        google.visualization.events.addListener(chart, 'select', selectHandler);

        // The selection handler.
        function selectHandler() {
          var selection = chart.getSelection(),
              category = '';
            if (selection[0].row != null) {
              category = data.getValue(selection[0].row, 0);
                //alert(category);
                window.location.href = "/category/" + category;
            } 
          }

    }
   
}

;
//# sourceMappingURL=/assets/source-maps/main.js.map
//# sourceURL=_assets/js/main.js
