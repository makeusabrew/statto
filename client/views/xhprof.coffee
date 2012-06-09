module.exports = (params) ->
    single = $("[data-xhprof='run']")
    chain  = $("[data-xhprof='chain']")
    diff   = $("[data-xhprof='diff']")
    len    = params.chain.length

    if single.parent().hasClass("active")
        single.attr("src", "http://xhprof/index.php?run=#{params.run_id}&source=#{params.source}")

    if len > 1
        if chain.parent().hasClass("active")
            chain.attr("src", "http://xhprof/index.php?run=#{params.chain.join(",")}&source=#{params.source}")

        run2 = params.chain[len-1]
        run1 = params.chain[len-2]

        if (diff.parent().hasClass("active"))
            diff.attr("src", "http://xhprof/index.php?run1=#{run1}&run2=#{run2}&source=#{params.source}")

        $("[data-chain]").html(params.chain.length)
        $("[data-diff]").html("✔")

    else
        $("[data-xhprof='chain']").attr("src", "about:blank")
        $("[data-xhprof='diff']").attr("src", "about:blank")
        $("[data-chain]").html("-")
        $("[data-diff]").html("✘")
