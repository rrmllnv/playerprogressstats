local mod = get_mod("PlayerProgressStats")
local NEW_VIEW_NAME = "player_progress_stats_view_dmf"

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

