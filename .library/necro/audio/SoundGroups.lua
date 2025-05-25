--- @meta

local SoundGroups = {}

--- @class SoundGroup
--- @field sounds string[]
--- @field volume? number
--- @field delay? number
--- @field channel? AudioChannel.Flag

function SoundGroups.clear() end

function SoundGroups.isValid(name) end

function SoundGroups.select(name) end

--- @param name string
--- @return SoundGroup?
function SoundGroups.get(name) end

function SoundGroups.getSounds(name) end

function SoundGroups.getVolume(name) end

function SoundGroups.getDelay(name) end

function SoundGroups.setVolume(name, volume) end

function SoundGroups.setDelay(name, delay) end

--- @param groups SoundGroup[]
function SoundGroups.register(groups) end

--- @param groups SoundGroup[]
function SoundGroups.merge(groups) end

function SoundGroups.init() end

--- @deprecated
function SoundGroups.addGroup(name, sounds, volume, delay) end

--- @deprecated
function SoundGroups.addGroups(groupTable) end

return SoundGroups
