--- @meta

local SteamWorkshop = {}

SteamWorkshop.Status = {
	NONE = 0,
	SUBSCRIBED = 1,
	LEGACY = 2,
	INSTALLED = 4,
	UPDATE_REQUIRED = 8,
	DOWNLOADING = 16,
	DOWNLOAD_PENDING = 32,
}

SteamWorkshop.ResultCode = {
	NONE = 0,
	OK = 1,
	--- Generic failure
	FAIL = 2,
	--- Invalid parameter in one of the fields
	INVALID_PARAMETER = 8,
	--- Missing file in workshop submission
	FILE_NOT_FOUND = 9,
	--- Workshop item exists with same name already
	DUPLICATE_NAME = 14,
	--- Missing license for AppID
	ACCESS_DENIED = 15,
	--- Operation timed out (retry)
	TIMEOUT = 16,
	--- Workshop is down (retry)
	SERVICE_UNAVAILABLE = 20,
	--- User is banned from workshop
	INSUFFICIENT_PRIVILEGE = 24,
	--- Storage quota exceeded
	RATE_LIMIT_EXCEEDED = 25,
	--- Item already submitted
	DUPLICATE_REQUEST = 29,
	--- Possibly multi-instance related
	LOCKING_FAILED = 33,
	--- Password changed recently, will expire in between 5 to 30 days
	SERVICE_READ_ONLY = 44,
}

SteamWorkshop.ItemAttribute = {
	NONE = 0,
	CONTENT_PATH = 1,
	TITLE = 2,
	DESCRIPTION = 3,
	PREVIEW = 4,
	TAGS = 5,
	LANGUAGE = 6,
	VISIBILITY = 7,
	METADATA = 8,
	CHANGELOG = 9,
}

SteamWorkshop.Visibility = {
	PUBLIC = 0,
	FRIENDS_ONLY = 1,
	PRIVATE = 2,
	UNLISTED = 3,
}

SteamWorkshop.LegacyFileWriteStatus = {
	NONE = 0,
	PENDING = 1,
	SUCCESS = 2,
	FAILURE = 3,
}

function SteamWorkshop.isAvailable() end

function SteamWorkshop.download(id, highPriority) end

function SteamWorkshop.getStatus(id) end

function SteamWorkshop.setFallbackInstallPath(id, path) end

function SteamWorkshop.getInstallPath(id) end

function SteamWorkshop.readLegacyFileToString(id, maxBytes) end

function SteamWorkshop.mountLegacyZip(id, mountPoint, order, labelPrefix) end

function SteamWorkshop.unmountLegacyZip(id, labelPrefix) end

function SteamWorkshop.updatePublications() end

function SteamWorkshop.listPublications() end

function SteamWorkshop.isPublicationListUpToDate() end

function SteamWorkshop.listSubscriptions() end

function SteamWorkshop.pollSubscriptionUpdate() end

function SteamWorkshop.getName(id) end

function SteamWorkshop.getPreviewImages(id) end

function SteamWorkshop.getUploader(id) end

function SteamWorkshop.getMetadata(id) end

function SteamWorkshop.create() end

function SteamWorkshop.createLegacy(filename) end

function SteamWorkshop.pollCreationResult(pendingID) end

function SteamWorkshop.updateItemInit(fileID, legacy) end

function SteamWorkshop.updateItemSet(updateID, key, value) end

function SteamWorkshop.updateItemFinish(updateID) end

function SteamWorkshop.pollUpdateProgress(updateID) end

function SteamWorkshop.writeLegacyFile(name, data) end

function SteamWorkshop.getLegacyFileWriteStatus(name) end

function SteamWorkshop.addAppDependency(fileID, appID) end

function SteamWorkshop.removeAppDependency(fileID, appID) end

function SteamWorkshop.startTrackingPlaytime(fileIDs) end

function SteamWorkshop.stopTrackingPlaytime(fileIDs) end

function SteamWorkshop.updateLicenseAgreementStatus() end

function SteamWorkshop.showLicenseAgreement() end

function SteamWorkshop.isLicenseAgreementAccepted() end

return SteamWorkshop
