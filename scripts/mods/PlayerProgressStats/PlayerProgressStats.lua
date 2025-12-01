local mod = get_mod("PlayerProgressStats")

local view_templates = mod:io_dofile([[PlayerProgressStats\scripts\mods\PlayerProgressStats\templates\view_templates]])

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
	
	if UIManager:view_instance("player_progress_stats_view") then
		Managers.ui:close_view("player_progress_stats_view")
	elseif not UIManager:chat_using_input() then
		Managers.ui:open_view("player_progress_stats_view", nil, nil, nil, nil, mod)
	end
end

mod.on_all_mods_loaded = function()
	register_views()
end

mod.on_setting_changed = function()
	-- Обновление настроек при изменении
end

