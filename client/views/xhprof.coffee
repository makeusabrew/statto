module.exports = (params) ->
    # single
    $("[data-xhprof='run']").attr("src", "http://xhprof/index.php?run=#{params.run_id}&source=#{params.source}")

    # chain
    if params.chain.length > 1
        $("[data-xhprof='chain']").attr("src", "http://xhprof/index.php?run=#{params.chain.join(",")}&source=#{params.source}")
        $("[data-chain]").html(params.chain.length)

        # diff
        run2 = params.chain.pop()
        run1 = params.chain.pop()
        $("[data-xhprof='diff']").attr("src", "http://xhprof/index.php?run1=#{run1}&run2=#{run2}&source=#{params.source}")
    else
        $("[data-xhprof='chain']").attr("src", "about:blank")
        $("[data-xhprof='chain']").attr("src", "about:blank")
        $("[data-chain]").html("-")
