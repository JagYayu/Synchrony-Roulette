--- @meta

local ReliableHandler = {}

ReliableHandler.PublicFunctionNames = {
	[4] = "cancelTransfer",
	[6] = "getIncomingTransfers",
	[7] = "getOutgoingTransfers",
	[2] = "sendReliable",
	[3] = "sendTransfer",
	[1] = "sendUnreliable",
	[5] = "synchronize",
}

ReliableHandler.Channel = {
	--- Special channel that does not enforce any ordering on its messages
	UNORDERED = 0,
}

function ReliableHandler.new(sendFunc) end

return ReliableHandler
