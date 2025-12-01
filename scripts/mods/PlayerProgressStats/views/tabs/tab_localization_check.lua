-- 🔍 ПРОВЕРКА ЛОКАЛИЗАЦИИ ЧЕРЕЗ КОНСОЛЬ
-- Эта вкладка объясняет как использовать консольные команды

local TabLocalizationCheck = {}

TabLocalizationCheck.create_layout = function(safe_read_stat, localize, format_number)
    local layout = {}
    
    -- Заголовок
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "🔍 Localization Key Checker"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Главная инструкция
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "✅ HOW TO USE - CONSOLE COMMANDS"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "1. Press ~ (tilde) to open console", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "2. Type command:", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "   /check_loc your_localization_key", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "3. Press Enter", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "4. See result in chat", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Примеры команд
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "📝 Available Commands:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "Check LOCALIZATION (text translations):", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "→ /check_loc loc_breed_display_name_chaos_daemonhost", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "→ /check_loc_help", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "Check STATISTICS (numeric values):", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "→ /check_stat total_kills", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "→ /check_stat missions", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Важное различие
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "⚠️ Important Difference:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "🌐 LOCALIZATION (use /check_loc):", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Keys start with 'loc_'", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Returns translated TEXT", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Example: loc_breed_display_name_chaos_daemonhost", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Result: 'Daemonhost' (text)", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "📊 STATISTICS (use /check_stat):", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • No 'loc_' prefix", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Returns numeric VALUE", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Example: total_kills", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "  • Result: 123,456 (number)", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Что выведет
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "💬 Example Output:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "If key found:", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "✅ Found in GAME localization:", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "   Key: loc_breed_display_name_chaos_daemonhost", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "   Translation: Daemonhost", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "If key not found:", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "❌ NOT FOUND: your_wrong_key", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "💡 Make sure the key is correct and starts with 'loc_'", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Популярные ключи локализации
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "🌐 Popular Localization Keys:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    local popular_loc_keys = {
        "loc_breed_display_name_chaos_daemonhost",
        "loc_breed_display_name_chaos_ogryn_gunner",
        "loc_achievement_enemies_killed_by_barrels_name",
        "loc_weapon_family_lasgun",
        "loc_settings_menu_close_menu",
    }
    
    for i, key in ipairs(popular_loc_keys) do
        table.insert(layout, {
            widget_type = "stat_line", 
            text = tostring(i) .. ". /check_loc " .. key, 
            value = ""
        })
    end
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Популярные статистики
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "📊 Popular Statistics:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    local popular_stats = {
        "total_kills",
        "missions",
        "auric_missions",
        "total_chaos_daemonhost_killed",
        "max_head_shot_in_a_row",
    }
    
    for i, stat in ipairs(popular_stats) do
        table.insert(layout, {
            widget_type = "stat_line", 
            text = tostring(i) .. ". /check_stat " .. stat, 
            value = ""
        })
    end
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    -- Альтернативы
    table.insert(layout, {
        widget_type = "stat_header", 
        text = "💡 Alternative Methods:"
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "1. Use 'Localization' tab (static list)", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "   → Edit tab_localization_debug.lua", 
        value = ""
    })
    
    table.insert(layout, {widget_type = "stat_line", text = "", value = ""})
    
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "2. Use DMF Console directly", 
        value = ""
    })
    table.insert(layout, {
        widget_type = "stat_line", 
        text = "   → Type: Localize('your_key')", 
        value = ""
    })
    
    return layout
end

return TabLocalizationCheck
