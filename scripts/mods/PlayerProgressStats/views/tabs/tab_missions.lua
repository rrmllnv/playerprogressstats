-- tab_missions.lua - Вкладка "Миссии"

local TabMissions = {}

TabMissions.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
    -- ============================
    -- ОСНОВНЫЕ МИССИИ
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_missions_main")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_missions"), value = format_number(safe_read_stat("missions"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_missions"), value = format_number(safe_read_stat("auric_missions"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions"), value = format_number(safe_read_stat("havoc_missions"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_maelstrom_missions"), value = format_number(safe_read_stat("mission_maelstrom"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_auric_maelstrom_missions"), value = format_number(safe_read_stat("mission_auric_maelstrom"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_circumstance_missions"), value = format_number(safe_read_stat("mission_circumstance"))})
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- ============================
    -- БЕЗУПРЕЧНЫЕ МИССИИ (FLAWLESS)
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_flawless_header")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_missions"), value = format_number(safe_read_stat("max_flawless_mission_in_a_row"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_personal_flawless_auric"), value = format_number(safe_read_stat("personal_flawless_auric"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_team_flawless_missions"), value = format_number(safe_read_stat("team_flawless_missions"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_auric_maelstrom"), value = format_number(safe_read_stat("flawless_auric_maelstrom"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_auric_maelstrom_consecutive"), value = format_number(safe_read_stat("flawless_auric_maelstrom_consecutive"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_flawless_havoc_won"), value = format_number(safe_read_stat("flawless_havoc_won"))})
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- ============================
    -- HAVOC
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_havoc_header")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_missions"), value = format_number(safe_read_stat("havoc_missions"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_havoc_win_assisted"), value = format_number(safe_read_stat("havoc_win_assisted"))})
    
    -- Havoc ранг (проверяем от высшего к низшему)
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
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- ============================
    -- TWINS МИССИИ
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_twins_header")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_mission_twins"), value = format_number(safe_read_stat("mission_twins"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_mission_twins_hard_mode"), value = format_number(safe_read_stat("mission_twins_hard_mode"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_mission_twins_secret_puzzle"), value = format_number(safe_read_stat("mission_twins_secret_puzzle_trigger"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_mission_twins_killed_within_x"), value = format_number(safe_read_stat("mission_twins_killed_successfully_within_x"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_mission_twins_no_mines"), value = format_number(safe_read_stat("mission_twins_no_mines_triggered"))})
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- ============================
    -- МИССИИ ПО ЗОНАМ
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_zones_header")})
    
    -- Список зон (только те где есть миссии, без hub/training_grounds/prologue)
    local zones = {
        {key = "dust", loc_key = "loc_zone_dust"},
        {key = "entertainment", loc_key = "loc_zone_entertainment"},
        {key = "operations", loc_key = "loc_zone_operations"},
        {key = "tank_foundry", loc_key = "loc_zone_tank_foundry"},
        {key = "throneside", loc_key = "loc_zone_throneside"},
        {key = "transit", loc_key = "loc_zone_transit"},
        {key = "void", loc_key = "loc_zone_void"},
        {key = "watertown", loc_key = "loc_zone_watertown"},
        {key = "horde", loc_key = "loc_horde_mission_breifing_zone"},
    }
    
    for _, zone in ipairs(zones) do
        local stat_name = string.format("zone_%s_missions_completed", zone.key)
        local count = safe_read_stat(stat_name)
        if count > 0 then
            table.insert(layout, {
                widget_type = "stat_line",
                text = localize(zone.loc_key),
                value = format_number(count)
            })
        end
    end
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- ============================
    -- РЕКОРДЫ
    -- ============================
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_mission_records")})
    
    local lowest_damage = safe_read_stat("lowest_damage_taken_on_win")
    if lowest_damage > 0 and lowest_damage < 9999 then
        table.insert(layout, {
            widget_type = "stat_line",
            text = localize("stats_lowest_damage_taken"),
            value = format_number(lowest_damage)
        })
    end

    return layout
end

return TabMissions
