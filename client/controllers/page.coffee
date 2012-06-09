View        = require "../view"

PageController =
    updateXhprof: (data) ->
        params = data

        View.render "xhprof", params

module.exports = PageController
