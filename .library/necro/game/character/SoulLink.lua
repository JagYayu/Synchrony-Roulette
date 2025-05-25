--- @meta

local SoulLink = {}

--- @class SoulLink.Group
--- @field link Entity
--- @field targets Entity[]

--- Creates a new soul link without any included entities
--- @param linkType string
--- @param attributes? table
--- @return Entity
function SoulLink.create(linkType, attributes) end

--- Breaks a soul link between all included entities
--- @param link Entity
function SoulLink.destroy(link) end

--- Breaks all soul links matching the specified component involving an entity
--- @param entity? Entity
--- @param component? string
function SoulLink.destroyAll(entity, component) end

--- Adds an entity to a soul link
--- @param link? Entity
--- @param entity? Entity
function SoulLink.attach(link, entity) end

--- Removes a soul link from its associated entity
--- @param link? Entity
function SoulLink.detach(link) end

--- @param link? Entity
function SoulLink.update(link) end

--- Lists all soul links with other entities involving a specific component
--- @param entity Entity
--- @param component? string
--- @return SoulLink.Group[]
function SoulLink.list(entity, component) end

function SoulLink.allFocusedEntitiesLinked(component, focusFlags) end

function SoulLink.setItemLinkGroup(itemID, linkGroupID) end

function SoulLink.getItemLinkGroup(itemID) end

function SoulLink.isItemCopy(itemID) end

--- Transfers ownership of all linked items to the holder with the lowest entity ID.
--- After calling this function, breaking a soul link will cause all items to stay with one of the players.
--- (If this function is not called, the player who picked up the original item retains ownership.)
function SoulLink.normalizeItems() end

return SoulLink
