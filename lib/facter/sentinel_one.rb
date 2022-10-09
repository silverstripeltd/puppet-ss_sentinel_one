Facter.add("sentinel_one") do
    setcode do
        if !system("which sentinelctl > /dev/null 2>&1")
            "NOT_FOUND"
        else
            # sentinelctl control status
            # Agent state      Enabled

            # Process Name     PID
            # network          21879
            # fanotify         21890
            # scanner          21880
            # orchestrator     21875
            # perf             21891
            # firewall         21889
            # agent            21881

            sentinel_status = "Disabled"
            Facter::Util::Resolution.exec('sentinelctl control status').each_line do |line|
                if line.match(/Agent state(\s+)(\S+)$/)
                    line_parts = line.split(/(.*\S)(\s+)(\S+)$/)
                    sentinel_status = line_parts[3]
                end
            end
        end
        sentinel_status
    end
end