-- tab_enemies.lua - Вкладка "Враги"

local TabEnemies = {}

TabEnemies.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
    -- Боссы
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_bosses")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_beast_of_nurgle"), value = format_number(safe_read_stat("total_chaos_beast_of_nurgle_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_chaos_spawn"), value = format_number(safe_read_stat("total_chaos_spawn_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_plague_ogryn"), value = format_number(safe_read_stat("total_chaos_plague_ogryn_killed"))})

    local daemon = safe_read_stat("total_chaos_daemonhost_killed") + safe_read_stat("total_chaos_mutator_daemonhost_killed")
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_daemonhost"), value = format_number(daemon)})

    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Элиты
    table.insert(layout, {widget_type = "stat_header", text = localize("stats_elites")})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_gunner"), value = format_number(safe_read_stat("total_chaos_ogryn_gunner_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_executor"), value = format_number(safe_read_stat("total_chaos_ogryn_executor_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_ogryn_bulwark"), value = format_number(safe_read_stat("total_chaos_ogryn_bulwark_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_renegade_gunner"), value = format_number(safe_read_stat("total_renegade_gunner_killed"))})
    table.insert(layout, {widget_type = "stat_line", text = localize("stats_cultist_gunner"), value = format_number(safe_read_stat("total_cultist_gunner_killed"))})

    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Специалисты
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

    return layout
end

return TabEnemies

