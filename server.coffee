#!/usr/local/bin/coffee
express = require "express"
sio     = require "socket.io"
zmq     = require "zmq"

app = express()
server = app.listen 8765

io = sio.listen server

# config
app.configure ->
    app.use express.static("#{__dirname}/public")

io.configure ->
    io.set "transports", ["websocket"]

# load routes
# require("./server/routes/url").load app

# wire up sockets
io.sockets.on "connection", (socket) ->
    ###
    ## client boot stuff
    ###
    socket.emit "hello"


# listen out for inbound queue messages from client apps
pull = zmq.socket "pull"
pull.bind "tcp://127.0.0.1:3456", ->

    pull.on "message", (data) ->
        # we simply proxy messages through to the client
        data = JSON.parse data
        io.sockets.emit "message", data
