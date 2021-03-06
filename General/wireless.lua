-- https://raw.githubusercontent.com/WindFreaker/computercraft-tests/master/General/wireless.lua

local function openChannel(channel, type)
	MODEM.open(channel)
	-- this function is still WIP
end

local function formatMessage (type, message)
	local formatted = {
		["type"] = type,
		["computerId"] = os.getComputerID(),
		["computerName"] = os.getComputerLabel(),
		["message"] = message
	}
	return formatted
end

local function broadcastAlert (message)
	if MODEM_CHECK then
		local formattedMsg = formatMessage("alert", message)
		MODEM.transmit(1, 1, formattedMsg)
	end
end

-- this variable is needed for properly run on computers without modems
MODEM_CHECK = false

-- this block of code is not a function
-- it is needed for proper setup of the modem
-- it will run when require("wireless") is called
local pList = peripheral.getNames()
for index, value in ipairs(pList) do
	if peripheral.getType(value) == "modem" then
		MODEM = peripheral.wrap(value)
		MODEM_CHECK = true
	end
end

return {
	sendAlert = broadcastAlert,
	open = openChannel
}
