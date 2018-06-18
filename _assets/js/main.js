
/* Destinations map inizialization */
if (document.getElementById('visualization')) {
    google.load('visualization', '1', {'packages': ['geochart']});
    google.setOnLoadCallback(drawVisualization);

    function drawVisualization() {

        var data = new google.visualization.DataTable(),
            numOfCountries;

        data.addColumn('string', 'Country');
        data.addColumn('number', 'Value'); 
        data.addColumn({type:'string', role:'tooltip'});

        data.addRows([[{v:'DE',f:'Germany'},0, _de + ' posts']]);
        data.addRows([[{v:'UA',f:'Ukraine'},1, _ua + ' posts']]);
        data.addRows([[{v:'RO',f:'Romania'},2, _ro + ' posts']]);
        // v - value; f: formattedValue
        
        numOfCountries = data.getNumberOfRows();

        var options = {
            backgroundColor: {fill:'#FFFFFF', stroke:'#FFFFFF', strokeWidth:0 },
            colorAxis:  
                {minValue: 0, maxValue: (numOfCountries - 1),  colors: ['#3C8C3F', '#9ee5a0']},
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


