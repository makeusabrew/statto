_socket    = null
_connected = false

PageController = require "./controllers/page"

lastPacket = null

Client =
    connect: ->
        return false if not io?
        
        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "message", (data) ->
            Chart.updateResponseTime({"time": data.timestamp, "value": data.msec})
            PageController.updateXhprof data

            # this is just a POC - store the last packet for the handler below
            lastPacket = data

    bindHandlers: ->
        $(".tabbable a").on "click", (e) ->
            e.preventDefault()
            $(this).tab('show')

            # this is a bit dirty, just for the POC it'll do - we re-call the draw method
            # to make sure our iframes are all up to date
            PageController.updateXhprof lastPacket

module.exports = Client
