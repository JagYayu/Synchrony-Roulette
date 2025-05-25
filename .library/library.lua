-- Since I use a WIP necrodancer lua library, here are my additions to it.

--- @class Array<T> : { [integer]: T, size: integer, type: integer, id: integer }

--- @alias Array.Type integer

--- @class Event.AIAct
--- @field action? Action.Result
--- @field entity Entity
--- @field target Entity

--- @class Bitmap
--- @field getPixel fun(x: integer, y: integer): Color
--- @field setPixel fun(x: integer, y: integer, pixelColor: Color)
--- @field getWidth fun(): integer
--- @field getHeight fun(): integer
--- @field getSize fun(): integer, integer
--- @field copyRect fun(source, sourceRect, targetPos)
--- @field getArray Array

--- @class Event.HolderDirection: Event.ObjectDirection
--- @field holder Entity

--- @class Event.HolderUpdateEquipmentSprite: Event.ObjectUpdateEquipmentSprite
--- @field holder Entity

--- @class Event.ObjectDirection
--- @field Overcook_suppressTakingTableItem boolean?

--- @class Event.ObjectGrooveChain
--- @field suppressed boolean?

--- @class Event.ObjectInteract: ObjectEvent
--- @field suppressed boolean?

--- @class Entity
--- @field hasComponent fun(self: self, name: string): boolean

--- @class EntitySelector
--- @field fire fun(ev: any, arg: Entity.Type)

--- @class ObjectSelector
--- @field fire fun(ev: any, arg: Entity)

--- @alias VertexBuffer.ID integer

--- @class VertexBuffer
--- @field clear function
--- @field draw function
--- @field drawQuad fun(args: VertexBuffer.DrawQuadArgs)
--- @field drawText function
--- @field hook function
--- @field setClippingRect function
--- @field setTransform function
--- @field write function
--- @field read function
--- @field getQuadCount function

--- @class VertexBuffer.DrawQuadArgs
--- @field vertices VertexBuffer.Vertex[]
--- @field z? number
--- @field texture? string

--- @class VertexBuffer.Vertex
--- @field x number
--- @field y number
--- @field tx? number
--- @field ty? number
--- @field color? integer
--- @field anim? VertexAnimation.ID

--- @alias VertexAnimation.ID integer

_G.utf8 = {
	len = string.len,
}
