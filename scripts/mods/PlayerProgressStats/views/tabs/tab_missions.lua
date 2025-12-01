-- tab_missions.lua - Вкладка "Миссии"

local TabMissions = {}

TabMissions.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
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

    return layout
end

return TabMissions

