--- @meta

local GameXMLDiff = {}

function GameXMLDiff.transform(xml) end

function GameXMLDiff.getDifferences(baseIR, modIR) end

function GameXMLDiff.getDifferencesToMatchingBase(modIR) end

function GameXMLDiff.merge(diffList) end

function GameXMLDiff.patch(baseXML, diffIR) end

return GameXMLDiff
