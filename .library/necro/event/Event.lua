--- @meta

local Event = {}

--- @class Event
--- @field add fun(name:string|nil,key:EventHandlerKey|string|number|nil,func:fun(ev:table))
--- @field override fun(name:string,key:EventOverrideKey|number,func:fun(func:fun(ev:table), ev:table))
--- @field getName fun():string
--- @field fire fun(arg:any,select:any)

return Event
