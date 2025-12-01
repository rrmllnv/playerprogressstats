local mod = get_mod("PlayerProgressStats")
local NEW_VIEW_NAME = "player_progress_stats_view"

local view_templates = mod:io_dofile([[PlayerProgressStats\scripts\mods\PlayerProgressStats\templates\view_templates]])
local system_view_injected = false
local global_loc_registered = false
local global_loc_registered = false

-- Форматирование числа с разделителем тысяч
mod.format_number = function(number)
	local num = math.floor(number)
	if num < 1000 then
		return tostring(num)
	end
	
	local formatted = tostring(num)
	local k
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if k == 0 then
			break
		end
	end
	return formatted
end

mod._is_in_hub = function()
	if not Managers.state or not Managers.state.game_mode then
		return false
	end
	local game_mode_name = Managers.state.game_mode:game_mode_name()
	return game_mode_name == "hub"
end

-- Регистрация view
local function register_views()
	for _, view_template in pairs(view_templates) do
		local path = view_template.view_settings.path
		mod:add_require_path(path)
		mod:register_view(view_template)
	end
end

-- Переключение видимости статистики
mod.toggle_stats_display = function()
	if not Managers or not Managers.ui then
		return
	end
	
	-- Проверяем, что мы в хабе
	if not mod._is_in_hub() then
		return
	end
	
	local UIManager = Managers.ui
	
	if UIManager:view_instance(NEW_VIEW_NAME) then
		Managers.ui:close_view(NEW_VIEW_NAME)
	elseif not UIManager:chat_using_input() then
		if UIManager:view_instance("dmf_options_view") then
			Managers.ui:close_view("dmf_options_view", true)
		end

		Managers.ui:open_view(NEW_VIEW_NAME, nil, true, nil, nil, mod)
	end
end

mod.on_all_mods_loaded = function()
	register_views()

	if not system_view_injected then
		if not global_loc_registered then
			mod:add_global_localize_strings({
				player_progress_stats_button = {
					en = "Player Statistics",
					ru = "Статистика игрока",
				},
			})

			global_loc_registered = true
		end

		mod:hook_require("scripts/ui/views/system_view/system_view_content_list", function(content_list)
			if table.find_by_key(content_list.default, "text", "player_progress_stats_button") then
				return
			end

			local new_entry = {
				text = "player_progress_stats_button",
				type = "button",
				-- icon = "content/ui/materials/icons/system/escape/settings",
				icon = "content/ui/materials/icons/system/escape/achievement",
				trigger_function = function()
					mod.toggle_stats_display()
				end,
			}

			local inserted = false

			local new_default = {}
			for _, item in ipairs(content_list.default) do
				if not inserted and item.text == "mods_options" then
					table.insert(new_default, new_entry)
					inserted = true
				end

				table.insert(new_default, item)
			end

			if not inserted then
				table.insert(new_default, new_entry)
			end

			content_list.default = new_default

			local new_menu = {}
			inserted = false
			for _, item in ipairs(content_list.StateMainMenu or {}) do
				if not inserted and item.text == "mods_options" then
					table.insert(new_menu, new_entry)
					inserted = true
				end

				table.insert(new_menu, item)
			end

			if not inserted then
				table.insert(new_menu, new_entry)
			end

			content_list.StateMainMenu = new_menu

			system_view_injected = true
		end)
	end
end

mod.on_setting_changed = function()
	-- Обновление настроек при изменении
end

-- 🔍 Консольная команда для проверки локализации
mod:command("check_loc", "Check localization key. Usage: /check_loc your_key", function(key)
	if not key or key == "" then
		mod:echo("Usage: /check_loc your_localization_key")
		mod:echo("Example: /check_loc loc_breed_display_name_chaos_daemonhost")
		return
	end
	
	-- Функция проверки локализации
	local function check_localization(loc_key)
		-- Сначала пробуем официальную локализацию игры
		if loc_key:match("^loc_") then
			local success, result = pcall(function()
				return Localize(loc_key)
			end)
			
			if success and result and result ~= "" and result ~= loc_key then
				return true, result, "game"
			end
		end
		
		-- Затем локализацию мода
		local success, result = pcall(function()
			return mod:localize(loc_key)
		end)
		
		if success and result and result ~= "" and result ~= loc_key then
			return true, result, "mod"
		end
		
		return false, nil, nil
	end
	
	-- Проверяем ключ
	local found, translation, source = check_localization(key)
	
	if found then
		if source == "game" then
			mod:echo("Found in GAME localization:")
		else
			mod:echo("Found in MOD localization:")
		end
		mod:echo("Key: " .. key)
		mod:echo("Translation: " .. translation)
	else
		mod:echo("NOT FOUND: " .. key)
		mod:echo("Make sure the key is correct and starts with 'loc_'")
	end
end)

-- 📚 Команда для списка примеров
mod:command("check_loc_help", "Show example localization keys", function()
	mod:echo("Example localization keys to try:")
	mod:echo("")
	mod:echo("Breeds - Bosses:")
	mod:echo("/check_loc loc_breed_display_name_chaos_daemonhost")
	mod:echo("/check_loc loc_breed_display_name_chaos_beast_of_nurgle")
	mod:echo("")
	mod:echo("Breeds - Elites:")
	mod:echo("/check_loc loc_breed_display_name_chaos_ogryn_gunner")
	mod:echo("/check_loc loc_breed_display_name_renegade_gunner")
	mod:echo("")
	mod:echo("Achievements:")
	mod:echo("/check_loc loc_achievement_enemies_killed_by_barrels_name")
	mod:echo("")
	mod:echo("Weapons:")
	mod:echo("/check_loc loc_weapon_family_lasgun")
	mod:echo("")
	mod:echo("UI:")
	mod:echo("/check_loc loc_settings_menu_close_menu")
	mod:echo("")
	mod:echo("For statistics use: /check_stat")
end)

-- 📊 Консольная команда для проверки статистики
mod:command("check_stat", "Check player statistic. Usage: /check_stat stat_name", function(stat_name)
	if not stat_name or stat_name == "" then
		mod:echo("Usage: /check_stat your_stat_name")
		mod:echo("Example: /check_stat total_kills")
		mod:echo("Example: /check_stat missions")
		mod:echo("")
		mod:echo("Common stats:")
		mod:echo("• total_kills, total_renegade_kills, total_cultist_kills")
		mod:echo("• missions, auric_missions, havoc_missions")
		mod:echo("• total_chaos_daemonhost_killed")
		return
	end
	
	-- Проверяем доступность Managers.stats
	if not Managers or not Managers.stats then
		mod:echo("Stats manager not available (not in hub?)")
		return
	end
	
	-- Читаем статистику
	local success, value = pcall(function()
		return Managers.stats:read_user_stat(1, stat_name)
	end)
	
	if success and value then
		mod:echo("Statistic found:")
		mod:echo("Stat: " .. stat_name)
		mod:echo("Value: " .. mod.format_number(value))
	else
		mod:echo("Statistic NOT FOUND: " .. stat_name)
		mod:echo("Check if stat name is correct")
		mod:echo("Some stats only work during missions")
	end
end)

