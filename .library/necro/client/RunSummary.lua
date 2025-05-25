--- @meta

local RunSummary = {}

--- @class RunSummary
--- @field playerID number Player ID associated with this run summary (or nil for whole-game summaries, such as victory)
--- @field level number Sequential level number at which the death/victory occurred
--- @field turnID number Turn at which the death/victory occurred
--- @field instantReplayTurnID number Turn at which the instant replay should loop
--- @field instantReplayPerspective number Entity ID to follow during the instant replay
--- @field victory boolean If true, indicates that the run was completed successfully
--- @field autoDismiss boolean If true, the run summary prompt is dismissed immediately and the result menu is shown
--- @field duration number Speedrun timer (in seconds) at the time of the death/victory
--- @field score number Score to display on the end screen
--- @field killerName? string Name of the entity that killed the player (if applicable)
--- @field killerID? integer Numeric ID of the killer name string, for the "Killed by" leaderboard column
--- @field killerType? string Name of the entity that killed the player

--- @param summary RunSummary
function RunSummary.addSummary(summary) end

--- @param playerID number
function RunSummary.removeSummary(playerID) end

--- @param playerID number
--- @return RunSummary
function RunSummary.getPlayerSummary(playerID) end

--- @return RunSummary
function RunSummary.getGlobalSummary() end

--- @return RunSummary
function RunSummary.getPendingSummary() end

--- @return RunSummary
function RunSummary.getDecisiveSummary() end

--- @return RunSummary
function RunSummary.getFinalSummary() end

function RunSummary.isDismissed(summary) end

function RunSummary.checkFinalization(notifyHost) end

function RunSummary.dismiss(summary) end

function RunSummary.showPostGameScreen(summary) end

return RunSummary
