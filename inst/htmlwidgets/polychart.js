HTMLWidgets.widget({

  name: 'polychart',

  type: 'output',

  initialize: function(el, width, height) {
    return "We don't initialize here!";
    console.log("Test!");
  },
  renderValue: function(el, x, instance) {
   document.getElementById(el.id).innerHTML="";

    //Create JSON data.
    var searchterms = polyjs.data(x.data);
    var x_r = Math.max.apply(null, x.data[x.x_var]) - Math.min.apply(null, x.data[x.x_var]);
    var x_min = Math.min.apply(null, x.data[x.x_var]) - 0.05*x_r;
    var x_max = Math.max.apply(null, x.data[x.x_var]) + 0.05*x_r;

    var y_r = Math.max.apply(null, x.data[x.y_var]) - Math.min.apply(null, x.data[x.y_var]);
    var y_min = Math.min.apply(null, x.data[x.y_var]) - 0.05*y_r;
    var y_max = Math.max.apply(null, x.data[x.y_var]) + 0.05*y_r;
  //Assign properties.
  if (x.draw_plot)
  {
  var polychart_obj = {};
  if(x.use_facet)
  {
    polychart_obj['facet'] = {
        type: "wrap",
        var: x.facet,
        formatter: function(facetObject) {
            var title = x.facet + ": " + facetObject[x.facet];
            return title;
          }
        };
  }

  if (x.use_title){
    polychart_obj['title'] = x.title;
    }
  else
  {
    polychart_obj['title'] = '';
  }

  if (x.use_color){
    polychart_obj['layer'] = {
          data: searchterms,
	        type: "point",
	        x: x.x_var,
	        y: x.y_var,
          color: x.color,
          tooltip: function(ex) {
            var html_string = "";
            for (i = 0; i < x.data_cols.length; i++) {
              html_string = html_string + x.data_cols[i] + ": " + ex[x.data_cols[i]] + "\n"
            }
            return html_string;
          }
          };
    }
    else
    {
    polychart_obj['layer'] = {
          data: searchterms,
          type: "point",
	        x: x.x_var,
	        y: x.y_var,
          tooltip: function(ex) {
            var html_string = "";
            for (i = 0; i < x.data_cols.length; i++) {
              html_string = html_string + x.data_cols[i] + ": " + ex[x.data_cols[i]] + "\n"
            }
            return html_string;
          }
          };
    }

  polychart_obj['guides'] = {
        y: {
        min: y_min,
        max: y_max,
        },
        x: {
        min: x_min,
        max: x_max,
        },

        };

  polychart_obj['width']=600;
  polychart_obj['height'] = el.height;
  polychart_obj['dom'] = el.id;
	polyjs.chart(polychart_obj);
  }
  },

  resize: function(el, width, height, instance) {

  }

});
