View = require "../view"

ChartController =
    addRun: (data) ->
        View.render "chart", data

module.exports = ChartController
