--- @meta

local ModIO = {}

ModIO.Endpoint = {
	AUTHENTICATED_USER = "%{base}/me?api_key=%{key}",
	AUTHENTICATE_EMAIL_REQUEST = "%{base}/oauth/emailrequest?api_key=%{key}",
	AUTHENTICATE_EMAIL_EXCHANGE = "%{base}/oauth/emailexchange?api_key=%{key}",
	AUTHENTICATE_STEAM = "%{base}/external/steamauth?api_key=%{key}",
	AUTHENTICATE_GALAXY = "%{base}/external/galaxyauth?api_key=%{key}",
	MOD_LIST = "%{base}/games/%{gid}/mods?api_key=%{key}&_offset=%{offset}&_limit=%{limit}%{query}",
	MOD_FILE_LIST = "%{base}/games/%{gid}/mods/%{id}/files?api_key=%{key}%{query}",
	MOD_INFO = "%{base}/games/%{gid}/mods/%{id}?api_key=%{key}",
	MOD_SUBSCRIBE = "%{base}/games/%{gid}/mods/%{id}/subscribe",
	USER_SUBSCRIPTIONS = "%{base}/me/subscribed?game_id=%{gid}",
	USER_EVENTS = "%{base}/me/events?date_added-min=%{timestamp}",
	MOD_CREATE = "%{base}/games/%{gid}/mods",
	MOD_EDIT = "%{base}/games/%{gid}/mods/%{id}",
	MOD_UPLOAD = "%{base}/games/%{gid}/mods/%{id}/files",
	MOD_MEDIA = "%{base}/games/%{gid}/mods/%{id}/media",
}

ModIO.Auth = {
	EMAIL = 1,
	STEAM = 2,
	GALAXY = 3,
}

function ModIO.sendRequest(request, callback) end

function ModIO.url(endpoint, args) end

function ModIO.isFirstTimeLoginPromptVisible() end

function ModIO.getLogIn() end

function ModIO.getLoggedInUserID() end

function ModIO.getAuthType() end

function ModIO.isTermsAgreed() end

function ModIO.logIn(authMethod, param) end

function ModIO.logOut() end

function ModIO.isLoginPending() end

function ModIO.resolve(name) end

function ModIO.generateName(modName, id) end

function ModIO.generateMetadata(mod) end

function ModIO.openHomepage(modName) end

function ModIO.isSubscriptionReady() end

function ModIO.setSubscription(modName, subscribed) end

function ModIO.getSubscription(modName) end

function ModIO.updateSubscriptions(force) end

function ModIO.query(args, callback) end

function ModIO.listVersions(modName) end

function ModIO.processDownload(download) end

return ModIO
