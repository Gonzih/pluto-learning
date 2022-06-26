module Lib

import Pkg
Pkg.activate("../.")
Pkg.instantiate()

using HTTP, JSON, DataFrames, Gadfly, PlutoUI, Dates, Pipe, HypertextLiteral


function get_data(
    data_url = "https://raw.githubusercontent.com/cryptoratsdev/senate-disclosures/main/reports/all.json"
)
    r = HTTP.get(data_url)
    senate_data = r.body |> String |> JSON.parse

    transactions = DataFrame()
    reports = DataFrame()

    for r in senate_data["all"]
        tx = pop!(r, "transactions")
        for t in tx
            t["id"] = r["id"]
            append!(transactions, DataFrame(t))
        end
        append!(reports, DataFrame(r))
    end

    @pipe innerjoin(reports, transactions, on = :id) |> filter(r -> length(r.ticker) < 5, _)
end

end
