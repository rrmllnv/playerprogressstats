local UIWidget = require("scripts/managers/ui/ui_widget")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local ViewElementGrid = require("scripts/ui/view_elements/view_element_grid/view_element_grid")

PlayerProgressStatsView = class("PlayerProgressStatsView", "BaseView")

local mod = get_mod("PlayerProgressStats")

local Color = Color
local base_z = 100
local base_x = 0
local panel_size = {1220, 600}
local BORDER_PADDING = 40
local LEFT_COLUMN_WIDTH = 300
local TAB_BUTTON_HEIGHT = 50
local TAB_BUTTON_SPACING = 5
local TAB_START_Y = 100
local hud_body_font_settings = UIFontSettings.hud_body or {}

-- Blueprints для grid элементов
local stat_line_blueprint = {
    size = {panel_size[1] - LEFT_COLUMN_WIDTH - BORDER_PADDING * 2 - 50, 25},
    size_function = function(parent, element, ui_renderer)
        return {panel_size[1] - LEFT_COLUMN_WIDTH - BORDER_PADDING * 2 - 50, 25}
    end,
    pass_template = {
        {
            pass_type = "text",
            value_id = "text",
            style = {
                text_vertical_alignment = "center",
                text_horizontal_alignment = "left",
                font_type = hud_body_font_settings.font_type or "machine_medium",
                font_size = hud_body_font_settings.font_size or 18,
                text_color = {255, 255, 255, 255},
                offset = {10, 0, 1},
            },
        },
    },
    init = function(parent, widget, element, callback_name)
        local content = widget.content
        content.text = element.text or ""
    end,
}

local stat_header_blueprint = {
    size = {panel_size[1] - LEFT_COLUMN_WIDTH - BORDER_PADDING * 2 - 50, 35},
    size_function = function(parent, element, ui_renderer)
        return {panel_size[1] - LEFT_COLUMN_WIDTH - BORDER_PADDING * 2 - 50, 35}
    end,
    pass_template = {
        {
            pass_type = "text",
            value_id = "text",
            style = {
                text_vertical_alignment = "center",
                text_horizontal_alignment = "left",
                font_type = hud_body_font_settings.font_type or "machine_medium",
                font_size = (hud_body_font_settings.font_size or 18) + 2,
                text_color = Color.terminal_text_header(255, true),
                offset = {10, 0, 1},
            },
        },
    },
    init = function(parent, widget, element, callback_name)
        local content = widget.content
        content.text = element.text or ""
    end,
}

local blueprints = {
    stat_line = stat_line_blueprint,
    stat_header = stat_header_blueprint,
}

local definitions = {
    scenegraph_definition = {
        screen = {
            scale = "fit",
            size = {1920, 1080},
        },
        background = {
            parent = "screen",
            horizontal_alignment = "center",
            vertical_alignment = "center",
            size = panel_size,
            position = {base_x, 0, 0},
        },
        title = {
            parent = "background",
            horizontal_alignment = "center",
            vertical_alignment = "top",
            size = {panel_size[1] - BORDER_PADDING * 2, 40},
            position = {0, 0, base_z + 300},
        },
        tab_button_1 = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {LEFT_COLUMN_WIDTH - BORDER_PADDING - 10, TAB_BUTTON_HEIGHT},
            position = {BORDER_PADDING, TAB_START_Y, base_z + 300},
        },
        tab_button_2 = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {LEFT_COLUMN_WIDTH - BORDER_PADDING - 10, TAB_BUTTON_HEIGHT},
            position = {BORDER_PADDING, TAB_START_Y + TAB_BUTTON_HEIGHT + TAB_BUTTON_SPACING, base_z + 300},
        },
        tab_button_3 = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {LEFT_COLUMN_WIDTH - BORDER_PADDING - 10, TAB_BUTTON_HEIGHT},
            position = {BORDER_PADDING, TAB_START_Y + (TAB_BUTTON_HEIGHT + TAB_BUTTON_SPACING) * 2, base_z + 300},
        },
        tab_button_4 = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {LEFT_COLUMN_WIDTH - BORDER_PADDING - 10, TAB_BUTTON_HEIGHT},
            position = {BORDER_PADDING, TAB_START_Y + (TAB_BUTTON_HEIGHT + TAB_BUTTON_SPACING) * 3, base_z + 300},
        },
        tab_button_5 = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {LEFT_COLUMN_WIDTH - BORDER_PADDING - 10, TAB_BUTTON_HEIGHT},
            position = {BORDER_PADDING, TAB_START_Y + (TAB_BUTTON_HEIGHT + TAB_BUTTON_SPACING) * 4, base_z + 300},
        },
        grid_pivot = {
            parent = "background",
            horizontal_alignment = "left",
            vertical_alignment = "top",
            size = {0, 0},
            position = {LEFT_COLUMN_WIDTH + 10, TAB_START_Y, 5},
        },
    },
    widget_definitions = {
        background = UIWidget.create_definition({
            {
                pass_type = "texture",
                value = "content/ui/materials/frames/dropshadow_heavy",
                style = {
                    vertical_alignment = "center",
                    scale_to_material = true,
                    horizontal_alignment = "center",
                    offset = {base_x, 0, base_z + 200},
                    size = {panel_size[1] - 4, panel_size[2] - 3},
                    color = Color.black(255, true),
                    disabled_color = Color.black(255, true),
                    default_color = Color.black(255, true),
                    hover_color = Color.black(255, true),
                }
            },
            {
                pass_type = "texture",
                value = "content/ui/materials/frames/inner_shadow_medium",
                style = {
                    vertical_alignment = "center",
                    scale_to_material = true,
                    horizontal_alignment = "center",
                    offset = {base_x, 0, base_z + 100},
                    size = {panel_size[1] - 24, panel_size[2] - 28},
                    color = Color.terminal_grid_background(255, true),
                    disabled_color = Color.terminal_grid_background(255, true),
                    default_color = Color.terminal_grid_background(255, true),
                    hover_color = Color.terminal_grid_background(255, true),
                }
            },
            {
                value = "content/ui/materials/backgrounds/terminal_basic",
                pass_type = "texture",
                style = {
                    vertical_alignment = "center",
                    scale_to_material = true,
                    horizontal_alignment = "center",
                    offset = {base_x, 0, base_z},
                    size = {panel_size[1] - 4, panel_size[2]},
                    color = Color.terminal_grid_background(255, true),
                    disabled_color = Color.terminal_grid_background(255, true),
                    default_color = Color.terminal_grid_background(255, true),
                    hover_color = Color.terminal_grid_background(255, true),
                }
            },
            {
                pass_type = "texture",
                value = "content/ui/materials/frames/premium_store/details_upper",
                style = {
                    vertical_alignment = "center",
                    scale_to_material = true,
                    horizontal_alignment = "center",
                    offset = {base_x, -panel_size[2] / 2, base_z + 200},
                    size = {panel_size[1], 80},
                    color = Color.gray(255, true),
                    disabled_color = Color.gray(255, true),
                    default_color = Color.gray(255, true),
                    hover_color = Color.gray(255, true),
                }
            },
            {
                pass_type = "texture",
                value = "content/ui/materials/frames/premium_store/details_lower_basic",
                style = {
                    vertical_alignment = "center",
                    scale_to_material = true,
                    horizontal_alignment = "center",
                    offset = {base_x, panel_size[2] / 2 - 50, base_z + 200},
                    size = {panel_size[1] + 50, 120},
                    color = Color.gray(255, true),
                    disabled_color = Color.gray(255, true),
                    default_color = Color.gray(255, true),
                    hover_color = Color.gray(255, true),
                }
            },
        }, "background"),
        title = UIWidget.create_definition({
            {
                value_id = "text",
                value = "",
                pass_type = "text",
                style_id = "text",
                style = {
                    text_vertical_alignment = "center",
                    text_horizontal_alignment = "center",
                    font_type = hud_body_font_settings.font_type or "machine_medium",
                    font_size = (hud_body_font_settings.font_size or 18) + 4,
                    default_font_size = (hud_body_font_settings.font_size or 18) + 4,
                    line_spacing = hud_body_font_settings.line_spacing or 1.2,
                    drop_shadow = true,
                    text_color = {255, 255, 255, 255},
                    size = {panel_size[1] - BORDER_PADDING * 2, 40},
                    offset = {0, BORDER_PADDING, base_z + 300},
                },
            },
        }, "title"),
        tab_button_1 = UIWidget.create_definition(ButtonPassTemplates.terminal_button_small, "tab_button_1", {
            text = "ОБЩЕЕ",
        }),
        tab_button_2 = UIWidget.create_definition(ButtonPassTemplates.terminal_button_small, "tab_button_2", {
            text = "ВРАГИ",
        }),
        tab_button_3 = UIWidget.create_definition(ButtonPassTemplates.terminal_button_small, "tab_button_3", {
            text = "РЕКОРДЫ",
        }),
        tab_button_4 = UIWidget.create_definition(ButtonPassTemplates.terminal_button_small, "tab_button_4", {
            text = "МИССИИ",
        }),
        tab_button_5 = UIWidget.create_definition(ButtonPassTemplates.terminal_button_small, "tab_button_5", {
            text = "ЗАЩИТА",
        }),
    },
}

PlayerProgressStatsView.init = function(self, settings, context)
    PlayerProgressStatsView.super.init(self, definitions, settings, context)
    self._context = context
    self._active_tab_index = 1
end

PlayerProgressStatsView.on_enter = function(self)
    PlayerProgressStatsView.super.on_enter(self)
    
    -- Устанавливаем коллбэки для кнопок вкладок
    self:_setup_tab_buttons()
    
    -- Создаем grid для контента
    self:_setup_stats_grid()
    
    -- Выбираем первую вкладку
    self._active_tab_index = 1
    self:_update_tab_selection()
    self:_update_title()
end

PlayerProgressStatsView._setup_tab_buttons = function(self)
    local tabs = {
        {key = "tab_general", index = 1, fallback = "GENERAL"},
        {key = "tab_enemies", index = 2, fallback = "ENEMIES"},
        {key = "tab_records", index = 3, fallback = "RECORDS"},
        {key = "tab_missions", index = 4, fallback = "MISSIONS"},
        {key = "tab_defense", index = 5, fallback = "DEFENSE"},
    }
    
    for i, tab in ipairs(tabs) do
        local button_widget = self._widgets_by_name["tab_button_" .. i]
        if button_widget then
            local success, display_name = pcall(function()
                return mod:localize(tab.key)
            end)
            if not success or not display_name or display_name == "" or display_name == tab.key then
                display_name = tab.fallback
            end
            button_widget.content.text = display_name
            button_widget.content.hotspot.pressed_callback = callback(self, "_on_tab_pressed", tab.index)
            button_widget.content.hotspot.is_selected = (self._active_tab_index == tab.index)
            button_widget.dirty = true
        end
    end
end

PlayerProgressStatsView._setup_stats_grid = function(self)
    local content_width = panel_size[1] - LEFT_COLUMN_WIDTH - BORDER_PADDING * 2 - 20
    local content_height = panel_size[2] - TAB_START_Y - BORDER_PADDING - 20
    local grid_size = {content_width, content_height}
    local mask_size = grid_size
    
    local grid_settings = {
        scrollbar_width = 7,
        grid_spacing = {0, 5},
        grid_size = grid_size,
        mask_size = mask_size,
        title_height = 0,
        edge_padding = 0,
        use_terminal_background = false,
        hide_dividers = true,
        hide_background = true,
        enable_gamepad_scrolling = true,
    }
    
    local layer = 20
    self._stats_grid = self:_add_element(ViewElementGrid, "stats_grid", layer, grid_settings, "grid_pivot")
    
    -- Обновляем контент сразу
    self:_update_grid_content()
end

PlayerProgressStatsView._update_tab_selection = function(self)
    for i = 1, 5 do
        local button_widget = self._widgets_by_name["tab_button_" .. i]
        if button_widget then
            button_widget.content.hotspot.is_selected = (self._active_tab_index == i)
            button_widget.dirty = true
        end
    end
end

PlayerProgressStatsView._on_tab_pressed = function(self, index)
    self._active_tab_index = index
    self:_update_tab_selection()
    self:_update_grid_content()
end

PlayerProgressStatsView._update_title = function(self)
    if not self._widgets_by_name then
        return
    end
    
    local title_widget = self._widgets_by_name.title
    if not title_widget then
        return
    end
    
    local success, title_text = pcall(function()
        return mod:localize("stats_title")
    end)
    
    if success and title_text and title_text ~= "" then
        title_widget.content.text = title_text
    else
        title_widget.content.text = "PLAYER STATISTICS"
    end
    title_widget.dirty = true
end

PlayerProgressStatsView._update_grid_content = function(self)
    if not self._stats_grid then
        return
    end
    
    local layout = self:_create_stat_layout()
    self._stats_grid:present_grid_layout(layout, blueprints)
end

PlayerProgressStatsView._create_stat_layout = function(self)
    local function safe_read_stat(stat_name)
        if not Managers or not Managers.stats or not Managers.stats.read_user_stat then
            return 0
        end
        local success, value = pcall(function()
            local result = Managers.stats:read_user_stat(1, stat_name)
            return result and type(result) == "number" and result or 0
        end)
        return success and value or 0
    end
    
    local function format_number(number)
        if not number or type(number) ~= "number" then
            return "0"
        end
        if mod.format_number then
            local success, result = pcall(function()
                return mod.format_number(number)
            end)
            if success and result then
                return result
            end
        end
        return tostring(math.floor(number))
    end
    
    local function localize(key)
        local success, result = pcall(function()
            return mod:localize(key)
        end)
        if success and result and result ~= "" then
            return result
        end
        return key
    end
    
    local layout = {}
    local tab_index = self._active_tab_index or 1
    
    if tab_index == 1 then
        -- ОБЩЕЕ
        local total_kills = safe_read_stat("total_kills")
        local renegade_kills = safe_read_stat("total_renegade_kills")
        local cultist_kills = safe_read_stat("total_cultist_kills")
        local chaos_kills = safe_read_stat("total_chaos_kills")
        local barrel_kills = safe_read_stat("enemies_killed_with_barrels")
        local poxburster_kills = safe_read_stat("enemies_killed_with_poxburster_explosion")
        local companion_pounce_kills = safe_read_stat("adamant_killed_enemies_pounced_by_companion")
        local companion_coherency_kills = safe_read_stat("adamant_team_companion_in_coherency_kills")
        local other_kills = total_kills - (renegade_kills + cultist_kills + chaos_kills + barrel_kills + poxburster_kills + companion_pounce_kills + companion_coherency_kills)
        
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_total_kills") .. " " .. format_number(total_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_renegade_kills") .. " " .. format_number(renegade_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_cultist_kills") .. " " .. format_number(cultist_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_chaos_kills") .. " " .. format_number(chaos_kills)})
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_barrel_kills") .. " " .. format_number(barrel_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_poxburster_explosion_kills") .. " " .. format_number(poxburster_kills)})
        if companion_pounce_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_companion_pounce_kills") .. " " .. format_number(companion_pounce_kills)})
        end
        if companion_coherency_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_companion_coherency_kills") .. " " .. format_number(companion_coherency_kills)})
        end
        if other_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_other_kills") .. " " .. format_number(other_kills)})
        end
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_missions") .. " " .. format_number(safe_read_stat("missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_missions") .. " " .. format_number(safe_read_stat("auric_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions") .. " " .. format_number(safe_read_stat("havoc_missions"))})
    elseif tab_index == 2 then
        -- ВРАГИ
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_bosses")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_beast_of_nurgle") .. " " .. format_number(safe_read_stat("total_chaos_beast_of_nurgle_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_chaos_spawn") .. " " .. format_number(safe_read_stat("total_chaos_spawn_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_plague_ogryn") .. " " .. format_number(safe_read_stat("total_chaos_plague_ogryn_killed"))})
        local daemon = safe_read_stat("total_chaos_daemonhost_killed") + safe_read_stat("total_chaos_mutator_daemonhost_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_daemonhost") .. " " .. format_number(daemon)})
        
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_elites")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_gunner") .. " " .. format_number(safe_read_stat("total_chaos_ogryn_gunner_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_executor") .. " " .. format_number(safe_read_stat("total_chaos_ogryn_executor_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_bulwark") .. " " .. format_number(safe_read_stat("total_chaos_ogryn_bulwark_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_renegade_gunner") .. " " .. format_number(safe_read_stat("total_renegade_gunner_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_cultist_gunner") .. " " .. format_number(safe_read_stat("total_cultist_gunner_killed"))})
        
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_specials")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_poxburster") .. " " .. format_number(safe_read_stat("total_chaos_poxwalker_bomber_killed"))})
        local hound = safe_read_stat("total_chaos_hound_killed") + safe_read_stat("total_chaos_hound_mutator_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_hound") .. " " .. format_number(hound)})
        local mutant = safe_read_stat("total_cultist_mutant_killed") + safe_read_stat("total_cultist_mutant_mutator_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_mutant") .. " " .. format_number(mutant)})
        local flamer = safe_read_stat("total_renegade_flamer_killed") + safe_read_stat("total_renegade_flamer_mutator_killed") + safe_read_stat("total_cultist_flamer_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_flamer") .. " " .. format_number(flamer)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_sniper") .. " " .. format_number(safe_read_stat("total_renegade_sniper_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_netgunner") .. " " .. format_number(safe_read_stat("total_renegade_netgunner_killed"))})
    elseif tab_index == 3 then
        -- РЕКОРДЫ
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_headshots") .. " " .. format_number(safe_read_stat("max_head_shot_in_a_row"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_kills_60s") .. " " .. format_number(safe_read_stat("max_kills_last_60_sec"))})
        local fastest_boss = safe_read_stat("fastest_boss_kill")
        if fastest_boss > 0 and fastest_boss < 18000 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_fastest_boss_kill") .. " " .. format_number(fastest_boss) .. "s"})
        end
    elseif tab_index == 4 then
        -- МИССИИ
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_missions") .. " " .. format_number(safe_read_stat("missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_missions") .. " " .. format_number(safe_read_stat("auric_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions") .. " " .. format_number(safe_read_stat("havoc_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_missions") .. " " .. format_number(safe_read_stat("max_flawless_mission_in_a_row"))})
        
        local havoc_rank = 0
        for i = 8, 1, -1 do
            if safe_read_stat("havoc_rank_reached_0" .. i) > 0 then
                havoc_rank = i * 5
                break
            end
        end
        if havoc_rank > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_rank") .. " " .. format_number(havoc_rank)})
        end
    elseif tab_index == 5 then
        -- ЗАЩИТА
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_dodges") .. " " .. format_number(safe_read_stat("max_dodges_in_a_row"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_sprint_dodges") .. " " .. format_number(safe_read_stat("total_sprint_dodges"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_slide_dodges") .. " " .. format_number(safe_read_stat("total_slide_dodges"))})
        table.insert(layout, {widget_type = "stat_line", text = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_damage_blocked") .. " " .. format_number(safe_read_stat("max_damage_blocked_last_20_sec"))})
    end
    
    return layout
end

PlayerProgressStatsView.update = function(self, dt, t, input_service)
    PlayerProgressStatsView.super.update(self, dt, t, input_service)
    
    if input_service and input_service:get("back_released") then
        if Managers and Managers.ui then
            Managers.ui:close_view("player_progress_stats_view")
        end
    end
end

PlayerProgressStatsView.on_exit = function(self)
    PlayerProgressStatsView.super.on_exit(self)
end

return PlayerProgressStatsView
