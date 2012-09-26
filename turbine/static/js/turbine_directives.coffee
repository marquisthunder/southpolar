southpolar = angular.module("turbine.directives", ["turbine.controllers"])

.directive("powerChart", [
    "$timeout"

    () =>
        width = 400
        height = 200
        restrict: 'E',
        scope: {
            val: '='
        },
        link: (scope, elm, attrs) =>
            console.warn 'e'
            var graph = new Rickshar.Graph({
                element: elm
                width: @width
                height: @height
                renderer: 'area'
                stroke: true
                series: [{
                            color: palette.color()
                            data: seriesData[0]
                            name: 'x'
                         },

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

            messages = 

            $timeout ->
                graph.update()
            , 5000

            $timeout (force)->
                if messages.length > 0 and (force or Math.random() >= 0.95)
                    annotator.add(seriesData[2][seriesData[2].length-1].x, messages.shift()) 
            , 6000

            
    )
