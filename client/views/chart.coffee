module.exports = (params) ->
    run = $("<div class=bar></div>")

    nonDb = params.msec - params.db.msec

    elem = $("<div></div>").css({
        "height": nonDb,
        "background": "green"
    })

    run.append elem

    elem = $("<div></div>").css({
        "height": params.db.msec,
        "background": "red"
    })

    run.append elem

    $(".response-time").append run
