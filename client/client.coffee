_socket    = null
_connected = false

PageController = require "./controllers/page"

Client =
    connect: ->
        return false if not io?
        
        _socket = io.connect()

        _socket.on "connect", ->
            _connected = true

        _socket.on "message", (data) ->
            PageController.updateXhprof data

    bindHandlers: ->

module.exports = Client
