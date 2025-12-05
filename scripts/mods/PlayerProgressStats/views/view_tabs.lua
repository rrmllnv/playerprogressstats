local mod = get_mod("PlayerProgressStats")
local constants = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/view_constants")

local TabGeneral = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_general")
local TabEnemies = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_enemies")
local TabMissions = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_missions")
local TabRecords = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_records")
local TabDefense = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_defense")

local tab_modules = {
	TabGeneral,
	TabEnemies,
	TabMissions,
	TabRecords,
	TabDefense,
}

if constants.DEBUG then
	local TabLocalizationDebug = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_localization_debug")
	local TabLocalizationCheck = mod:io_dofile("PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_localization_check")
	if TabLocalizationDebug then
		table.insert(tab_modules, TabLocalizationDebug)
	end
	if TabLocalizationCheck then
		table.insert(tab_modules, TabLocalizationCheck)
	end
end

return tab_modules

