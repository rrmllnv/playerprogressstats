-- tab_records.lua - Вкладка "Рекорды"

local TabRecords = {}

TabRecords.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_headshots"), value = format_number(safe_read_stat("max_head_shot_in_a_row"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_max_kills_60s"), value = format_number(safe_read_stat("max_kills_last_60_sec"))})

    local fastest_boss = safe_read_stat("fastest_boss_kill")

    if fastest_boss > 0 and fastest_boss < 18000 then
        table.insert(layout, {widget_type = "stat_line", text = localize("stats_fastest_boss_kill"), value = format_number(fastest_boss) .. "s"})
    end
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    table.insert(layout, {widget_type = "stat_line", text = "Player Rescues (TEST)", value = format_number(safe_read_stat("total_player_rescues"))})
    table.insert(layout, {widget_type = "stat_line", text = "Player Assists (TEST)", value = format_number(safe_read_stat("total_player_assists"))})
    table.insert(layout, {widget_type = "stat_line", text = "Coherency Toughness (TEST)", value = format_number(safe_read_stat("total_coherency_toughness"))})
    table.insert(layout, {widget_type = "stat_line", text = "Melee Toughness Regen (TEST)", value = format_number(safe_read_stat("total_melee_toughness_regen"))})

    return layout
end

return TabRecords

