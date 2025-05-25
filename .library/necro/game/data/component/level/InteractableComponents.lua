--- @meta

local InteractableComponents = {}

--- Allows an entity to touch interactable objects, activating them
--- @class Component.interactor

--- Marks an entity as interactable, allowing it to be touched to activate its effects
--- @class Component.interactable
--- @field active boolean # `= true` 

--- Does nothing on interaction, but counts as a success
--- @class Component.interactableNoOp

--- Interactor deals damage to this entity upon interaction
--- @class Component.interactableTakeDamage
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.PHYSICAL` 

--- Destroys this entity upon interaction
--- @class Component.interactableSelfDestruct

--- Cancels the bounce animation on the interactor upon successful interaction
--- @class Component.interactableCancelBounceTween

--- Reset interactor's damage countdown on successful interaction
--- @class Component.interactableResetDamageCountdown
--- @field requireSuccess boolean # `= true` 

--- Consumes a key from the interactor’s inventory
--- @class Component.interactableConsumeKey
--- @field type integer # `= 0` 

--- Creates a flyaway on failed interaction
--- @class Component.interactableFailFlyaway
--- @field text localizedString # `= 0` 
--- @field duration number # `= 1.5` 
--- @field distance integer # `= 18` 

--- Creates a swipe on failed interaction
--- @class Component.interactableFailSwipe
--- @field type string # `= ""` 

--- Negates the low% flag when interacting with this object
--- @class Component.interactableNegateLowPercent

--- Represents a character selector with an attached preview player entity
--- @class Component.interactableSelectCharacter
--- @field characterType string # `= ""` 

--- Displays a preview of the character represented by this character selector
--- @class Component.interactableSelectCharacterPreview
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 
--- @field offsetH number # `= 0` 
--- @field outlineColor integer # `= color.TRANSPARENT` 
--- @field shadowCopyZ boolean # `= false` 

--- Shows a confirmation menu before selecting the character
--- @class Component.interactableSelectCharacterConfirm

--- Randomly chooses a character for this character selector
--- @class Component.interactableSelectCharacterRandom

--- Changes the interactor's chosen character when interacting with this object
--- @class Component.interactableSelectCharacterLobby
--- @field characterType string # `= ""` 
--- @field resetPosition boolean # `= false` 

--- Chooses the next Ensemble Mode character when interacting with this obejct
--- @class Component.interactableSelectEnsemble
--- @field index integer # `= 0` 
--- @field labelID Entity.ID # 
--- @field originX integer # `= 0` 
--- @field originY integer # `= 0` 

--- Randomizes Ensemble choice order
--- @class Component.interactableSelectEnsembleRandom

--- @class Entity
--- @field interactor Component.interactor
--- @field interactable Component.interactable
--- @field interactableNoOp Component.interactableNoOp
--- @field interactableTakeDamage Component.interactableTakeDamage
--- @field interactableSelfDestruct Component.interactableSelfDestruct
--- @field interactableCancelBounceTween Component.interactableCancelBounceTween
--- @field interactableResetDamageCountdown Component.interactableResetDamageCountdown
--- @field interactableConsumeKey Component.interactableConsumeKey
--- @field interactableFailFlyaway Component.interactableFailFlyaway
--- @field interactableFailSwipe Component.interactableFailSwipe
--- @field interactableNegateLowPercent Component.interactableNegateLowPercent
--- @field interactableSelectCharacter Component.interactableSelectCharacter
--- @field interactableSelectCharacterPreview Component.interactableSelectCharacterPreview
--- @field interactableSelectCharacterConfirm Component.interactableSelectCharacterConfirm
--- @field interactableSelectCharacterRandom Component.interactableSelectCharacterRandom
--- @field interactableSelectCharacterLobby Component.interactableSelectCharacterLobby
--- @field interactableSelectEnsemble Component.interactableSelectEnsemble
--- @field interactableSelectEnsembleRandom Component.interactableSelectEnsembleRandom

return InteractableComponents
