--- @meta

local Countdown = {}

Countdown.Type = {
	LEGACY = 0,
	START = 1,
	PAUSE = 2,
	UNPAUSE = 3,
	PAUSE_BEATS = 4,
}

function Countdown.isBeatCountdownActive() end

function Countdown.getTargetBeat() end

function Countdown.getUpcomingTargetBeat() end

function Countdown.getUpcomingTargetTime() end

function Countdown.isVisibilityLimited() end

function Countdown.isBlockingBeatCountdownActive() end

return Countdown
