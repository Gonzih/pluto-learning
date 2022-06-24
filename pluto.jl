import Pkg
Pkg.activate(".")
Pkg.instantiate()

import Pluto
Pluto.run(host = "0.0.0.0", require_secret_for_open_links = false, require_secret_for_access = false, dismiss_update_notification = true)
