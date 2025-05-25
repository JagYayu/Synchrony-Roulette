--- @meta

local HTTP = {}

HTTP.Status = {
	CANCELED = -1,
	PENDING = 0,
	DOWNLOADING_HEADERS = 1,
	DOWNLOADING_BODY = 2,
	COMPLETE = 3,
	FAILURE = 4,
	TIMEOUT = 5,
}

HTTP.Method = {
	NONE = 0,
	GET = 1,
	HEAD = 2,
	POST = 3,
	PUT = 4,
	DELETE = 5,
	CONNECT = 6,
	OPTIONS = 7,
	TRACE = 8,
	PATCH = 9,
}

function HTTP.isAvailable() end

function HTTP.sendRequest(request, callback) end

function HTTP.sendStreamingRequest(request, dataCallback, statusCallback) end

function HTTP.download(url, filename, statusCallback) end

function HTTP.cancel(requestID) end

function HTTP.getStatus(requestID) end

function HTTP.getTotalBytes(requestID) end

function HTTP.getReceivedBytes(requestID) end

function HTTP.getUploadableBytes(requestID) end

function HTTP.getUploadedBytes(requestID) end

function HTTP.isSuccessfulStatus(status) end

function HTTP.isFinalStatus(status) end

function HTTP.isSuccessResponseCode(responseCode) end

function HTTP.openInBrowser(url) end

return HTTP
