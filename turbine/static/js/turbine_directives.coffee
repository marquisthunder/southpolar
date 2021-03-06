southpolar = angular.module("turbine.directives", ["turbine.controllers"])

.directive("powerchart", [
    "$timeout"

    () ->
        restrict: 'E',
        transclude: true,
        template: '<form id="side_panel">
                        <h3>Random Data in the Future</h3>
                        <section><div id="legend"></div></section>
                        <section>
                                <div id="renderer_form" class="toggler">
                                        <input type="radio" name="renderer" id="area" value="area" checked>
                                        <label for="area">area</label>
                                        <input type="radio" name="renderer" id="bar" value="bar">
                                        <label for="bar">bar</label>
                                        <input type="radio" name="renderer" id="line" value="line">
                                        <label for="line">line</label>
                                        <input type="radio" name="renderer" id="scatter" value="scatterplot">
                                        <label for="scatter">scatter</label>
                                </div>
                        </section>
                        <section>
                                <div id="offset_form">
                                        <label for="stack">
                                                <input type="radio" name="offset" id="stack" value="zero" checked>
                                                <span>stack</span>
                                        </label>
                                        <label for="stream">
                                                <input type="radio" name="offset" id="stream" value="wiggle">
                                                <span>stream</span>
                                        </label>
                                        <label for="pct">
                                                <input type="radio" name="offset" id="pct" value="expand">
                                                <span>pct</span>
                                        </label>
                                        <label for="value">
                                                <input type="radio" name="offset" id="value" value="value">
                                                <span>value</span>
                                        </label>
                                </div>
                                <div id="interpolation_form">
                                        <label for="cardinal">
                                                <input type="radio" name="interpolation" id="cardinal" value="cardinal" checked>
                                                <span>cardinal</span>
                                        </label>
                                        <label for="linear">
                                                <input type="radio" name="interpolation" id="linear" value="linear">
                                                <span>linear</span>
                                        </label>
                                        <label for="step">
                                                <input type="radio" name="interpolation" id="step" value="step-after">
                                                <span>step</span>
                                        </label>
                                </div>
                        </section>
                        <section>
                                <h6>Smoothing</h6>
                                <div id="smoother"></div>
                        </section>
                        <section></section>
                    </form>
                    <div id="chart_container">
                       <div id="chart"></div>
                    <div id="timeline"></div>
                    <div id="slider"></div>
                    </div>'
        link: (scope, elm, attrs) =>
            palette = new Rickshaw.Color.Palette( { scheme: 'classic9' } )
            graph = new Rickshaw.Graph({
                element: angular.element('#chart'),
                renderer: 'area',
                stroke: true,
                series: [{
                            color: palette.color(),
                            data: seriesData[0],
                            name: 'x'}]
            })

            graph.render()

            slider = new RickShaw.Graph.RangeSlider({
                        graph: graph
                        element: angular.element('#slider')
                    })

            hoverDetail = new Rickshaw.Graph.HoverDetail({
                        graph: graph
                    })

            annotator = new Rickshaw.Graph.Annotate({
                        graph: graph
                        element: angular.element('#timeline')
                    })

            legend = new Rickshaw.Graph.Legend({
                        graph: graph
                        element: angular.element('#legend')
                    })

            shelving = new Rickshaw.Graph.Behavior.Series.Toggle({
                        graph: graph
                        legend: legend
                    })

            order = new Rickshaw.Graph.Behavior.Series.Order({
                        graph: graph
                        legend: legend
                    })

            highlighter = new Rickshaw.Graph.Behavior.Series.Highlight({
                        graph: graph
                        legend: legend
                    })

            smoother = new Rickshaw.Graph.Smoother({
                        graph: graph
                        element: angular.element('#smoother')
                    })

            ticksTreatment = 'glow'

            xAxis = new Rickshaw.Graph.Axis.Time({
                        graph: graph
                        ticksTreatment: ticksTreatment
                    })
            xAxis.render()

            yAxis = new Rickshaw.Graph.Axis.Y({
                        graph: graph
                        tickFormat: Rickshaw.Fixtures.Number.formantKMBT
                        ticksTreatment: ticksTreatment
                    })
            yAxis.render()
                
            controls = new RenderControls({
                        element: angular.element.find('form')
                        graph: graph
                    })

            return

            $timeout (force)->
                if messages.length > 0 and (force or Math.random() >= 0.95)
                    annotator.add(seriesData[2][seriesData[2].length-1].x, messages.shift()) 
            , 6000

            scope.$watch 'val'
            , (newVal, oldVal) ->
                if newVal is oldVal
                    return
                else
                    graph.update()
])
