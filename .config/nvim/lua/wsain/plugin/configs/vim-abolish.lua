local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.shortUrl = "tpope/vim-abolish"

--[[ 
example:

:Subvert/child{,ren}/adult{,s}/g

crs	coerce to snake_case
crm	coerce to MixedCase
crc	coerce to camelCase
cru	coerce to UPPER_CASE
cr.	coerce to dot.case
cr-	coerce to dash-case
cr	coerce to space case
crt	coerce to Title Case 
]]
return plugin
