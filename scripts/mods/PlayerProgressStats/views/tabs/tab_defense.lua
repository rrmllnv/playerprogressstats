-- tab_defense.lua - Вкладка "Защита"

local TabDefense = {}

TabDefense.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_dodges"), value = format_number(safe_read_stat("max_dodges_in_a_row"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_sprint_dodges"), value = format_number(safe_read_stat("total_sprint_dodges"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_slide_dodges"), value = format_number(safe_read_stat("total_slide_dodges"))})
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_damage_blocked"), value = format_number(safe_read_stat("max_damage_blocked_last_20_sec"))})

    return layout
end

return TabDefense

