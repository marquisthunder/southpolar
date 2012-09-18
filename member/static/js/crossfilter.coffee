d3.csv "flights-3m.json", (flights) ->
  render = (method) ->
    d3.select(this).call method
  renderAll = ->
    chart.each render
    list.each render
    d3.select("#active").text formatNumber(all.value())
  parseDate = (d) ->
    new Date(2001, d.substring(0, 2) - 1, d.substring(2, 4), d.substring(4, 6), d.substring(6, 8))
  flightList = (div) ->
    flightsByDate = nestByDate.entries(date.top(40))
    div.each ->
      date = d3.select(this).selectAll(".date").data(flightsByDate, (d) ->
        d.key
      )
      date.enter().append("div").attr("class", "date").append("div").attr("class", "day").text (d) ->
        formatDate d.values[0].date

      date.exit().remove()
      flight = date.order().selectAll(".flight").data((d) ->
        d.values
      , (d) ->
        d.index
      )
      flightEnter = flight.enter().append("div").attr("class", "flight")
      flightEnter.append("div").attr("class", "time").text (d) ->
        formatTime d.date

      flightEnter.append("div").attr("class", "origin").text (d) ->
        d.origin

      flightEnter.append("div").attr("class", "destination").text (d) ->
        d.destination

      flightEnter.append("div").attr("class", "distance").text (d) ->
        formatNumber(d.distance) + " mi."

      flightEnter.append("div").attr("class", "delay").classed("early", (d) ->
        d.delay < 0
      ).text (d) ->
        formatChange(d.delay) + " min."

      flight.exit().remove()
      flight.order()
  barChart = ->
    chart = (div) ->
      barPath = (groups) ->
        path = []
        i = -1
        n = groups.length
        d = undefined
        while ++i < n
          d = groups[i]
          path.push "M", x(d.key), ",", height, "V", y(d.value), "h9V", height
        path.join ""
      resizePath = (d) ->
        e = +(d is "e")
        x = (if e then 1 else -1)
        y = height / 3
        "M" + (.5 * x) + "," + y + "A6,6 0 0 " + e + " " + (6.5 * x) + "," + (y + 6) + "V" + (2 * y - 6) + "A6,6 0 0 " + e + " " + (.5 * x) + "," + (2 * y) + "Z" + "M" + (2.5 * x) + "," + (y + 8) + "V" + (2 * y - 8) + "M" + (4.5 * x) + "," + (y + 8) + "V" + (2 * y - 8)
      width = x.range()[1]
      height = y.range()[0]
      y.domain [ 0, group.top(1)[0].value ]
      div.each ->
        div = d3.select(this)
        g = div.select("g")
        if g.empty()
          div.select(".title").append("a").attr("href", "javascript:reset(" + id + ")").attr("class", "reset").text("reset").style "display", "none"
          g = div.append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform", "translate(" + margin.left + "," + margin.top + ")")
          g.append("clipPath").attr("id", "clip-" + id).append("rect").attr("width", width).attr "height", height
          g.selectAll(".bar").data([ "background", "foreground" ]).enter().append("path").attr("class", (d) ->
            d + " bar"
          ).datum group.all()
          g.selectAll(".foreground.bar").attr "clip-path", "url(#clip-" + id + ")"
          g.append("g").attr("class", "axis").attr("transform", "translate(0," + height + ")").call axis
          gBrush = g.append("g").attr("class", "brush").call(brush)
          gBrush.selectAll("rect").attr "height", height
          gBrush.selectAll(".resize").append("path").attr "d", resizePath
        if brushDirty
          brushDirty = false
          g.selectAll(".brush").call brush
          div.select(".title a").style "display", (if brush.empty() then "none" else null)
          if brush.empty()
            g.selectAll("#clip-" + id + " rect").attr("x", 0).attr "width", width
          else
            extent = brush.extent()
            g.selectAll("#clip-" + id + " rect").attr("x", x(extent[0])).attr "width", x(extent[1]) - x(extent[0])
        g.selectAll(".bar").attr "d", barPath
    barChart.id = 0  unless barChart.id
    margin =
      top: 10
      right: 10
      bottom: 20
      left: 10

    x = undefined
    y = d3.scale.linear().range([ 100, 0 ])
    id = barChart.id++
    axis = d3.svg.axis().orient("bottom")
    brush = d3.svg.brush()
    brushDirty = undefined
    dimension = undefined
    group = undefined
    round = undefined
    brush.on "brushstart.chart", ->
      div = d3.select(@parentNode.parentNode.parentNode)
      div.select(".title a").style "display", null

    brush.on "brush.chart", ->
      g = d3.select(@parentNode)
      extent = brush.extent()
      g.select(".brush").call(brush.extent(extent = extent.map(round))).selectAll(".resize").style "display", null  if round
      g.select("#clip-" + id + " rect").attr("x", x(extent[0])).attr "width", x(extent[1]) - x(extent[0])
      dimension.filterRange extent

    brush.on "brushend.chart", ->
      if brush.empty()
        div = d3.select(@parentNode.parentNode.parentNode)
        div.select(".title a").style "display", "none"
        div.select("#clip-" + id + " rect").attr("x", null).attr "width", "100%"
        dimension.filterAll()

    chart.margin = (_) ->
      return margin  unless arguments_.length
      margin = _
      chart

    chart.x = (_) ->
      return x  unless arguments_.length
      x = _
      axis.scale x
      brush.x x
      chart

    chart.y = (_) ->
      return y  unless arguments_.length
      y = _
      chart

    chart.dimension = (_) ->
      return dimension  unless arguments_.length
      dimension = _
      chart

    chart.filter = (_) ->
      if _
        brush.extent _
        dimension.filterRange _
      else
        brush.clear()
        dimension.filterAll()
      brushDirty = true
      chart

    chart.group = (_) ->
      return group  unless arguments_.length
      group = _
      chart

    chart.round = (_) ->
      return round  unless arguments_.length
      round = _
      chart

    d3.rebind chart, brush, "on"
  formatNumber = d3.format(",d")
  formatChange = d3.format("+,d")
  formatDate = d3.time.format("%B %d, %Y")
  formatTime = d3.time.format("%I:%M %p")
  nestByDate = d3.nest().key((d) ->
    d3.time.day d.date
  )
  flights.forEach (d, i) ->
    d.index = i
    d.date = parseDate(d.date)
    d.delay = +d.delay
    d.distance = +d.distance

  flight = crossfilter(flights)
  all = flight.groupAll()
  date = flight.dimension((d) ->
    d3.time.day d.date
  )
  dates = date.group()
  hour = flight.dimension((d) ->
    d.date.getHours() + d.date.getMinutes() / 60
  )
  hours = hour.group(Math.floor)
  delay = flight.dimension((d) ->
    Math.max -60, Math.min(149, d.delay)
  )
  delays = delay.group((d) ->
    Math.floor(d / 10) * 10
  )
  distance = flight.dimension((d) ->
    Math.min 1999, d.distance
  )
  distances = distance.group((d) ->
    Math.floor(d / 50) * 50
  )
  charts = [ barChart().dimension(hour).group(hours).x(d3.scale.linear().domain([ 0, 24 ]).rangeRound([ 0, 10 * 24 ])), barChart().dimension(delay).group(delays).x(d3.scale.linear().domain([ -60, 150 ]).rangeRound([ 0, 10 * 21 ])), barChart().dimension(distance).group(distances).x(d3.scale.linear().domain([ 0, 2000 ]).rangeRound([ 0, 10 * 40 ])), barChart().dimension(date).group(dates).round(d3.time.day.round).x(d3.time.scale().domain([ new Date(2001, 0, 1), new Date(2001, 3, 1) ]).rangeRound([ 0, 10 * 90 ])).filter([ new Date(2001, 1, 1), new Date(2001, 2, 1) ]) ]
  chart = d3.selectAll(".chart").data(charts).each((chart) ->
    chart.on("brush", renderAll).on "brushend", renderAll
  )
  list = d3.selectAll(".list").data([ flightList ])
  d3.selectAll("#total").text formatNumber(flight.size())
  renderAll()
  window.filter = (filters) ->
    filters.forEach (d, i) ->
      charts[i].filter d

    renderAll()

  window.reset = (i) ->
    charts[i].filter null
    renderAll()
