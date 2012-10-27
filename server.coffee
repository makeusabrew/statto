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
        data = JSON.parse data

        handleRun data

###
# handle all runs we get sent, parse them into separate objects
# arranged by namespace, and handle any aggregates and diffs
###
results = {}
handleRun = (current) ->
    namespace = current.namespace
    results[namespace] = [] if not results[namespace]?

    segment = results[namespace]

    if segment.length
        previous = segment[segment.length-1]

        if previous.hash is current.hash
            current.chain = previous.chain.concat current.run_id
        else
            current.chain = [current.run_id]
    else
        current.chain = [current.run_id]

    segment.push current

    io.sockets.emit "message", current
