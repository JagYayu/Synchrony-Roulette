--- @meta

local Feedback = {}

Feedback.Type = {
	BUG = 1,
	IDEA = 2,
	FEEDBACK = 3,
}

Feedback.Severity = {
	MINOR = 1,
	MAJOR = 2,
	CRITICAL = 3,
}

Feedback.Attachment = {
	SETTINGS_PRESET = 6,
	SCREENSHOT = 1,
	REPLAY = 2,
	SAVE_STATE = 3,
	LOG = 4,
	STACK_TRACE = 5,
}

function Feedback.getScreenshotPath(filename) end

function Feedback.generate(args) end

function Feedback.takeScreenshots() end

function Feedback.submit(report) end

function Feedback.getSubmissionStatus() end

function Feedback.isTakingScreenshot() end

return Feedback
