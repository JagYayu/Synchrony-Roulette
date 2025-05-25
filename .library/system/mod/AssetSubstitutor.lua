--- @meta

local AssetSubstitutor = {}

function AssetSubstitutor.registerSubstitution(assetPath, targetAssetPath, priority, modName) end

function AssetSubstitutor.unregisterSubstitution(assetPath, targetAssetPath) end

function AssetSubstitutor.unregisterModSubstitutions(modName) end

function AssetSubstitutor.lookUpAsset(assetPath) end

function AssetSubstitutor.getSubstitutionsForAsset(assetPath) end

function AssetSubstitutor.isSubstituted(assetPath) end

function AssetSubstitutor.fireReloadEvents() end

return AssetSubstitutor
