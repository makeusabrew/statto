/**
 * this has been very hastily butchered from http://mbostock.github.com/d3/tutorial/bar-2.html
 * obviously just prototype code for now!
 */
var Chart = (function() {
    var that = {}
    var maxPoints = 45;
    var w = 20,
        h = 200;

    var x = d3.scale.linear()
        .domain([0, 1])
        .range([0, w]);

    var y = d3.scale.linear()
        .domain([0, 500])
        .rangeRound([0, h]);

    var data = [];

    var gTime = 0;

    var chart = d3.select(".response-time").append("svg")
        .attr("class", "chart")
        .attr("width", w * maxPoints - 1)
        .attr("height", h);

    chart.append("line")
        .attr("x1", 0)
        .attr("x2", w * maxPoints)
        .attr("y1", h - .5)
        .attr("y2", h - .5)
        .style("stroke", "#000");

    redraw();

    function redraw() {

      var rect = chart.selectAll("rect")
          .data(data, function(d) { return d.time; });

      rect.enter().insert("rect", "line")
          .attr("x", function(d, i) { return x(i + 1) - .5; })
          .attr("y", function(d) { return h - y(d.value) - .5; })
          .attr("width", w)
          .attr("height", function(d) { return y(d.value); })
        .transition()
          .duration(100)
          .attr("x", function(d, i) { return x(i) - .5; });

      rect.transition()
          .duration(100)
          .attr("x", function(d, i) { return x(i) - .5; });

      rect.exit().transition()
          .duration(100)
          .attr("x", function(d, i) { return x(i - 1) - .5; })
          .remove();

    };

    that.updateResponseTime = function(_data) {
        _data.time = gTime ++;

        if (data.length == maxPoints) {
            data.shift();
        }

        data.push(_data);

        redraw();
        d3.timer.flush(); // avoid memory leak when in background tab
    };

    return that;
})();
