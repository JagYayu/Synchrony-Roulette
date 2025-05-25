--- @meta

local PingComponents = {}

--- Allows this entity to be pinged with the ping tool
--- @class Component.pingable
--- @field type Ping.Type # `= ping.Type.OBJECT` 

--- If the entity is not on the same team as the pinging player, uses an alternate ping type.
--- This should be used for entities that are typically friendly (such as players).
--- @class Component.pingableTeamHostile
--- @field type Ping.Type # `= ping.Type.ENEMY` 

--- If the entity is on the same team as the pinging player, uses an alternate ping type.
--- This should be used for entities that are typically hostile (such as enemies).
--- @class Component.pingableTeamFriendly
--- @field type Ping.Type # `= ping.Type.ALLY` 

--- If the pinging player is allergic to gold, changes the type of this ping.
--- @class Component.pingableGoldHazard
--- @field type Ping.Type # `= ping.Type.GOLD_DANGER` 

--- If the entity is provoked, uses an alternate ping type.
--- @class Component.pingableProvokable
--- @field type Ping.Type # `= ping.Type.ENEMY` 

--- If the entity is not located in the main segment, uses an alternate ping type.
--- @class Component.pingableSegmentOverride
--- @field type Ping.Type # `= ping.Type.OBJECT` 

--- Allows this entity to be pinged even if it is not visible
--- @class Component.pingableIgnoreVisibility

--- Allows this entity to be pinged even if it is on a shadowed tile
--- @class Component.pingableIgnoreShadow

--- Prevents this entity from being pinged while it is on an unrevealed tile
--- @class Component.pingableCheckRevealedTile

--- Excludes this entity from being unsilhouetted when pinged
--- @class Component.pingablePreserveSilhouette

--- Excludes this entity from becoming visible when pinged
--- @class Component.pingablePreserveInvisibility

--- Displays this entity's contents when pinged, if they are visible to the pinging player
--- @class Component.pingableShowContents

--- Offsets the ping cursor by the specified number of pixels.
--- @class Component.pingableCursorOffset
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 

--- Forces pings directed at this entity to be tile-aligned, instead of scaling to its visual bounding box.
--- @class Component.pingableCursorIgnoreVisualExtent

--- Offsets the ping's HUD arrow by the specified number of pixels.
--- @class Component.pingablePointerOffset
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- Always draws this ping's HUD pointer sprite at full-bright color.
--- @class Component.pingablePointerIgnoreColor

--- @class Entity
--- @field pingable Component.pingable
--- @field pingableTeamHostile Component.pingableTeamHostile
--- @field pingableTeamFriendly Component.pingableTeamFriendly
--- @field pingableGoldHazard Component.pingableGoldHazard
--- @field pingableProvokable Component.pingableProvokable
--- @field pingableSegmentOverride Component.pingableSegmentOverride
--- @field pingableIgnoreVisibility Component.pingableIgnoreVisibility
--- @field pingableIgnoreShadow Component.pingableIgnoreShadow
--- @field pingableCheckRevealedTile Component.pingableCheckRevealedTile
--- @field pingablePreserveSilhouette Component.pingablePreserveSilhouette
--- @field pingablePreserveInvisibility Component.pingablePreserveInvisibility
--- @field pingableShowContents Component.pingableShowContents
--- @field pingableCursorOffset Component.pingableCursorOffset
--- @field pingableCursorIgnoreVisualExtent Component.pingableCursorIgnoreVisualExtent
--- @field pingablePointerOffset Component.pingablePointerOffset
--- @field pingablePointerIgnoreColor Component.pingablePointerIgnoreColor

return PingComponents
