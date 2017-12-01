setCommandPanelTaskMode #modify
currentMod = modPanel.getCurrentObject()
if (querybox ("replace "+(currentMod as string)+" with "+(stanModifier as string)+"?\n(rotation must 0!)")) do replaceinstances  currentMod stanModifier