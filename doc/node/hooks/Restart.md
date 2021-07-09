# Handle restarts {#node-hook-type-restart}

The `restart` hook tries to detect starts/restarts of simulation cases by looking for wrap-arounds in sequence numbers.

# Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/restart.cpp

# Configuration {#node-config-hook-restart}

The `restart` hook is a built-in hook. It is active by default and does not require any further options.

