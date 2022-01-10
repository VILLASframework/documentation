---
hide_table_of_contents: true
---

# Lua scripting

The `lua` hook allows for the evaluation arbitrary Lua expressions.

Take a look at some example Lua scripts used by this hook here:
https://git.rwth-aachen.de/acs/public/villas/node/-/tree/master/lua/hooks

## Prerequisites

This hook requires [Lua](https://www.lua.org/) (>= 5.1).

## Implementation

The source code of the hook is available here:
https://git.rwth-aachen.de/acs/public/villas/node/blob/master/lib/hooks/lua.cpp

## Configuration

import ApiSchema from '@theme/ApiSchema';

<ApiSchema example pointer="#/components/schemas/lua" />

## Example

@include node/etc/examples/hooks/lua.conf

## Example Lua script

@include node/lua/hooks/test.lua
