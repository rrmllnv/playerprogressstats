local PlayerProgressStatsDMFView = class("PlayerProgressStatsDMFView", "BaseView")

local mod = get_mod("PlayerProgressStats")

local ViewElementGrid = require("scripts/ui/view_elements/view_element_grid/view_element_grid")
local ViewElementInputLegend = require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local ScrollbarPassTemplates = require("scripts/ui/pass_templates/scrollbar_pass_templates")
local ButtonPassTemplates = require("scripts/ui/pass_templates/button_pass_templates")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")

local Color = Color
local hud_body_font_settings = UIFontSettings.hud_body or {}

local category_panel_size = {500, 820}
local stats_panel_size = {1000, 820}
local tab_height = 64
local tab_spacing = 6
local scrollbar_width = 10
local grid_size = {stats_panel_size[1] - 140, stats_panel_size[2] - 120}
local mask_size = {grid_size[1] + 32, grid_size[2] + 32}

local stat_line_blueprint = {
    size = {grid_size[1] - 20, 34},
    size_function = function()
        return {grid_size[1] - 20, 34}
    end,
    pass_template = {
        {
            content_id = "hotspot",
            pass_type = "hotspot",
            content = {
                use_is_focused = false,
            },
        },
        {
            pass_type = "texture",
            value = "content/ui/materials/backgrounds/default_square",
            style = {
                color = Color.terminal_background_selected(0, true),
                offset = {0, 0, 0},
            },
            change_function = function(content, style)
                local hotspot = content.hotspot
                local hover_progress = hotspot.anim_hover_progress or 0
                local alpha = 100 * hover_progress
                style.color[1] = alpha
            end,
        },
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
        {
            pass_type = "text",
            value_id = "value",
            style = {
                text_vertical_alignment = "center",
                text_horizontal_alignment = "right",
                font_type = hud_body_font_settings.font_type or "machine_medium",
                font_size = hud_body_font_settings.font_size or 18,
                text_color = Color.terminal_text_header(255, true),
                offset = {-10, 0, 1},
            },
        },
    },
    init = function(_, widget, element)
        widget.content.text = element.text or ""
        widget.content.value = element.value or ""
    end,
}

local stat_header_blueprint = {
    size = {grid_size[1] - 20, 40},
    size_function = function()
        return {grid_size[1] - 20, 40}
    end,
    pass_template = {
        {
            pass_type = "text",
            value_id = "text",
            style = {
                text_vertical_alignment = "center",
                text_horizontal_alignment = "left",
                font_type = UIFontSettings.list_button.font_type or "glass_gothic_medium",
                font_size = (UIFontSettings.list_button.font_size or 24) + 2,
                text_color = Color.terminal_text_header(255, true),
                offset = {10, 0, 1},
            },
        },
    },
    init = function(_, widget, element)
        widget.content.text = element.text or ""
    end,
}

local blueprints = {
    stat_line = stat_line_blueprint,
    stat_header = stat_header_blueprint,
}

local tabs_definitions = {
    {key = "tab_general", fallback = "GENERAL"},
    {key = "tab_enemies", fallback = "ENEMIES"},
    {key = "tab_records", fallback = "RECORDS"},
    {key = "tab_missions", fallback = "MISSIONS"},
    {key = "tab_defense", fallback = "DEFENSE"},
}

local scenegraph_definition = {
    screen = UIWorkspaceSettings.screen,
    dim_background = {
        parent = "screen",
        horizontal_alignment = "center",
        vertical_alignment = "center",
        size = {1920, 1080},
        position = {0, 0, -5},
    },
    background_icon = {
        vertical_alignment = "center",
        parent = "screen",
        horizontal_alignment = "center",
        size = {1250, 1250},
        position = {0, 0, -4},
    },
    title_divider = {
        vertical_alignment = "top",
        parent = "screen",
        horizontal_alignment = "left",
        size = {335, 18},
        position = {180, 145, 1},
    },
    title_text = {
        vertical_alignment = "bottom",
        parent = "title_divider",
        horizontal_alignment = "left",
        size = {500, 50},
        position = {0, -35, 1},
    },
    category_panel = {
        vertical_alignment = "top",
        parent = "screen",
        horizontal_alignment = "left",
        size = category_panel_size,
        position = {140, 190, 0},
    },
    stats_panel = {
        vertical_alignment = "top",
        parent = "screen",
        horizontal_alignment = "right",
        size = stats_panel_size,
        position = {-180, 130, 0},
    },
    stats_panel_background = {
        vertical_alignment = "top",
        parent = "stats_panel",
        horizontal_alignment = "center",
        size = {stats_panel_size[1], stats_panel_size[2]},
        position = {0, 0, -1},
    },
    title = {
        vertical_alignment = "top",
        parent = "category_panel",
        horizontal_alignment = "left",
        size = {category_panel_size[1], 60},
        position = {0, -70, 2},
    },
    grid_pivot = {
        vertical_alignment = "top",
        parent = "stats_panel",
        horizontal_alignment = "left",
        size = {0, 0},
        position = {20, 20, 3},
    },
    grid_scrollbar = {
        vertical_alignment = "top",
        parent = "stats_panel",
        horizontal_alignment = "right",
        size = {scrollbar_width, stats_panel_size[2] - 60},
        position = {30, 30, 2},
    },
}

for index = 1, #tabs_definitions do
    local y = (index - 1) * (tab_height + tab_spacing)

    scenegraph_definition["tab_button_" .. index] = {
        parent = "category_panel",
        horizontal_alignment = "left",
        vertical_alignment = "top",
        size = {category_panel_size[1] - 20, tab_height},
        position = {0, y, 2},
    }
end

local title_style = table.clone(UIFontSettings.header_1 or {})
title_style.text_horizontal_alignment = "left"
title_style.text_vertical_alignment = "bottom"

local widget_definitions = {
    dim_background = UIWidget.create_definition({
        {
            pass_type = "rect",
            style = {
                color = {180, 0, 0, 0},
            },
        },
    }, "dim_background"),
    background_icon = UIWidget.create_definition({
        {
            value = "content/ui/vector_textures/symbols/cog_skull_01",
            pass_type = "slug_icon",
            style = {
                color = {80, 0, 0, 0},
            },
        },
    }, "background_icon"),
    title_divider = UIWidget.create_definition({
        {
            pass_type = "texture",
            value = "content/ui/materials/dividers/skull_rendered_left_01",
        },
    }, "title_divider"),
    title_text = UIWidget.create_definition({
        {
            value_id = "text",
            pass_type = "text",
            style = title_style,
            value = "",
        },
    }, "title_text"),
    stats_panel = UIWidget.create_definition({
        {
            pass_type = "rect",
            style = {
                color = Color.black(0, true),
            },
        },
    }, "stats_panel_background"),
    grid_scrollbar = UIWidget.create_definition(ScrollbarPassTemplates.default_scrollbar, "grid_scrollbar", {
        scroll_speed = 10,
        scroll_amount = 0.1,
    }),
}

for index = 1, #tabs_definitions do
    local widget_name = "tab_button_" .. index
    widget_definitions[widget_name] = UIWidget.create_definition(ButtonPassTemplates.list_button, "tab_button_" .. index, {
        text = tabs_definitions[index].fallback,
    })
end

local legend_inputs = {
    {
        input_action = "back",
        on_pressed_callback = "cb_on_back_pressed",
        display_name = "loc_settings_menu_close_menu",
        alignment = "left_alignment",
    },
}

local definitions = {
    scenegraph_definition = scenegraph_definition,
    widget_definitions = widget_definitions,
    legend_inputs = legend_inputs,
}

PlayerProgressStatsDMFView.init = function(self, settings, context)
    PlayerProgressStatsDMFView.super.init(self, definitions, settings, context)
    self._context = context
    self._active_tab_index = 1
end

PlayerProgressStatsDMFView.on_enter = function(self)
    PlayerProgressStatsDMFView.super.on_enter(self)

    self:_setup_input_legend()
    self:_setup_tab_buttons()
    self:_setup_stats_grid()
    self._active_tab_index = 1
    self:_update_tab_selection()
    self:_update_title()
end

PlayerProgressStatsDMFView._setup_tab_buttons = function(self)
    for index, tab in ipairs(tabs_definitions) do
        local button_widget = self._widgets_by_name["tab_button_" .. index]

        if button_widget then
            local success, display_name = pcall(function()
                return mod:localize(tab.key)
            end)

            if not success or not display_name or display_name == "" or display_name == tab.key then
                display_name = tab.fallback
            end

            button_widget.content.text = display_name
            button_widget.content.hotspot.pressed_callback = callback(self, "_on_tab_pressed", index)
            button_widget.content.hotspot.is_selected = (self._active_tab_index == index)
            button_widget.dirty = true
        end
    end
end

PlayerProgressStatsDMFView._setup_stats_grid = function(self)
    local grid_settings = {
        scrollbar_width = scrollbar_width,
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

    self:_update_grid_content()
end

PlayerProgressStatsDMFView._update_tab_selection = function(self)
    for i = 1, #tabs_definitions do
        local button_widget = self._widgets_by_name["tab_button_" .. i]

        if button_widget then
            button_widget.content.hotspot.is_selected = (self._active_tab_index == i)
            button_widget.dirty = true
        end
    end
end

PlayerProgressStatsDMFView._on_tab_pressed = function(self, index)
    self._active_tab_index = index
    self:_update_tab_selection()
    self:_update_grid_content()
end

PlayerProgressStatsDMFView._update_title = function(self)
    local title_widget = self._widgets_by_name.title_text

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

PlayerProgressStatsDMFView._update_grid_content = function(self)
    if not self._stats_grid then
        return
    end

    local layout = self:_create_stat_layout()
    self._stats_grid:present_grid_layout(layout, blueprints)
end

PlayerProgressStatsDMFView._create_stat_layout = function(self)
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
        local total_kills = safe_read_stat("total_kills")
        local renegade_kills = safe_read_stat("total_renegade_kills")
        local cultist_kills = safe_read_stat("total_cultist_kills")
        local chaos_kills = safe_read_stat("total_chaos_kills")
        local barrel_kills = safe_read_stat("enemies_killed_with_barrels")
        local poxburster_kills = safe_read_stat("enemies_killed_with_poxburster_explosion")
        local companion_pounce_kills = safe_read_stat("adamant_killed_enemies_pounced_by_companion")
        local companion_coherency_kills = safe_read_stat("adamant_team_companion_in_coherency_kills")
        local other_kills = total_kills - (renegade_kills + cultist_kills + chaos_kills + barrel_kills + poxburster_kills + companion_pounce_kills + companion_coherency_kills)

        table.insert(layout, {widget_type = "stat_line", text = localize("stats_total_kills"), value = format_number(total_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_renegade_kills"), value = format_number(renegade_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_cultist_kills"), value = format_number(cultist_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_chaos_kills"), value = format_number(chaos_kills)})
        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_barrel_kills"), value = format_number(barrel_kills)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_poxburster_explosion_kills"), value = format_number(poxburster_kills)})

        if companion_pounce_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_companion_pounce_kills"), value = format_number(companion_pounce_kills)})
        end

        if companion_coherency_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_companion_coherency_kills"), value = format_number(companion_coherency_kills)})
        end

        if other_kills > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_other_kills"), value = format_number(other_kills)})
        end

        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_missions"), value = format_number(safe_read_stat("missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_missions"), value = format_number(safe_read_stat("auric_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions"), value = format_number(safe_read_stat("havoc_missions"))})
    elseif tab_index == 2 then
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_bosses")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_beast_of_nurgle"), value = format_number(safe_read_stat("total_chaos_beast_of_nurgle_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_chaos_spawn"), value = format_number(safe_read_stat("total_chaos_spawn_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_plague_ogryn"), value = format_number(safe_read_stat("total_chaos_plague_ogryn_killed"))})

        local daemon = safe_read_stat("total_chaos_daemonhost_killed") + safe_read_stat("total_chaos_mutator_daemonhost_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_daemonhost"), value = format_number(daemon)})

        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_elites")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_gunner"), value = format_number(safe_read_stat("total_chaos_ogryn_gunner_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_executor"), value = format_number(safe_read_stat("total_chaos_ogryn_executor_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_bulwark"), value = format_number(safe_read_stat("total_chaos_ogryn_bulwark_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_renegade_gunner"), value = format_number(safe_read_stat("total_renegade_gunner_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_cultist_gunner"), value = format_number(safe_read_stat("total_cultist_gunner_killed"))})

        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_header", text = localize("stats_specials")})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_poxburster"), value = format_number(safe_read_stat("total_chaos_poxwalker_bomber_killed"))})

        local hound = safe_read_stat("total_chaos_hound_killed") + safe_read_stat("total_chaos_hound_mutator_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_hound"), value = format_number(hound)})

        local mutant = safe_read_stat("total_cultist_mutant_killed") + safe_read_stat("total_cultist_mutant_mutator_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_mutant"), value = format_number(mutant)})

        local flamer = safe_read_stat("total_renegade_flamer_killed") + safe_read_stat("total_renegade_flamer_mutator_killed") + safe_read_stat("total_cultist_flamer_killed")
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_flamer"), value = format_number(flamer)})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_sniper"), value = format_number(safe_read_stat("total_renegade_sniper_killed"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_netgunner"), value = format_number(safe_read_stat("total_renegade_netgunner_killed"))})
    
    elseif tab_index == 3 then
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_headshots"), value = format_number(safe_read_stat("max_head_shot_in_a_row"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_kills_60s"), value = format_number(safe_read_stat("max_kills_last_60_sec"))})

        local fastest_boss = safe_read_stat("fastest_boss_kill")

        if fastest_boss > 0 and fastest_boss < 18000 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_fastest_boss_kill"), value = format_number(fastest_boss) .. "s"})
        end
    elseif tab_index == 4 then
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_missions"), value = format_number(safe_read_stat("missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_missions"), value = format_number(safe_read_stat("auric_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions"), value = format_number(safe_read_stat("havoc_missions"))})
        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_missions"), value = format_number(safe_read_stat("max_flawless_mission_in_a_row"))})

        local havoc_rank = 0

        for i = 8, 1, -1 do
            if safe_read_stat("havoc_rank_reached_0" .. i) > 0 then
                havoc_rank = i * 5
                break
            end
        end

        if havoc_rank > 0 then
            table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_rank"), value = format_number(havoc_rank)})
        end
    elseif tab_index == 5 then
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_dodges"), value = format_number(safe_read_stat("max_dodges_in_a_row"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_sprint_dodges"), value = format_number(safe_read_stat("total_sprint_dodges"))})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_slide_dodges"), value = format_number(safe_read_stat("total_slide_dodges"))})
        table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_damage_blocked"), value = format_number(safe_read_stat("max_damage_blocked_last_20_sec"))})
    end

    return layout
end

PlayerProgressStatsDMFView._setup_input_legend = function(self)
    self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
    local legend_inputs = definitions.legend_inputs

    for i = 1, #legend_inputs do
        local legend_input = legend_inputs[i]
        local on_pressed_callback = legend_input.on_pressed_callback and callback(self, legend_input.on_pressed_callback)

        self._input_legend_element:add_entry(legend_input.display_name, legend_input.input_action, legend_input.visibility_function, on_pressed_callback, legend_input.alignment)
    end
end

PlayerProgressStatsDMFView.cb_on_back_pressed = function(self)
    if Managers and Managers.ui then
        Managers.ui:close_view(self.view_name)
    end
end

PlayerProgressStatsDMFView.update = function(self, dt, t, input_service)
    if Managers and Managers.ui and Managers.ui:view_instance("dmf_options_view") then
        Managers.ui:close_view(self.view_name)

        return
    end

    PlayerProgressStatsDMFView.super.update(self, dt, t, input_service)

    if input_service and input_service:get("back_released") then
        if Managers and Managers.ui then
            Managers.ui:close_view(self.view_name)
        end
    end
end

PlayerProgressStatsDMFView.on_exit = function(self)
    if self._input_legend_element then
        self._input_legend_element = nil
        self:_remove_element("input_legend")
    end

    PlayerProgressStatsDMFView.super.on_exit(self)
end

return PlayerProgressStatsDMFView



