# 🗺️ Вкладка "Миссии" (Missions)

---

## Статистики для вкладки "Миссии"

### 📊 Основные миссии:

| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `missions` | Своя: `stats_missions` | Общее количество пройденных миссий |
| `auric_missions` | Своя: `stats_auric_missions` | Auric миссии (сложность 4-5) |
| `havoc_missions` | Своя: `stats_havoc_missions` | Havoc миссии |

### 🏆 Рекорды миссий:

| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `max_flawless_mission_in_a_row` | Своя: `stats_flawless_missions` | Максимальное количество безупречных миссий подряд |

### 🔥 Havoc ранги:

| Статистика | Локализация | Соответствует рангу |
|-----------|-------------|---------------------|
| `havoc_rank_reached_01` | Своя: `stats_havoc_rank` | Ранг 5 |
| `havoc_rank_reached_02` | Своя: `stats_havoc_rank` | Ранг 10 |
| `havoc_rank_reached_03` | Своя: `stats_havoc_rank` | Ранг 15 |
| `havoc_rank_reached_04` | Своя: `stats_havoc_rank` | Ранг 20 |
| `havoc_rank_reached_05` | Своя: `stats_havoc_rank` | Ранг 25 |
| `havoc_rank_reached_06` | Своя: `stats_havoc_rank` | Ранг 30 |
| `havoc_rank_reached_07` | Своя: `stats_havoc_rank` | Ранг 35 |
| `havoc_rank_reached_08` | Своя: `stats_havoc_rank` | Ранг 40 |

**Логика:** Проверяется от 08 до 01, возвращается первый найденный * 5.

---

## 💻 Пример кода для вкладки:

```lua
-- tab_missions.lua

local layout = {}

-- Основные миссии
table.insert(layout, {
    widget_type = "stat_line",
    text = localize("stats_missions"),
    value = format_number(safe_read_stat("missions"))
})

table.insert(layout, {
    widget_type = "stat_line",
    text = localize("stats_auric_missions"),
    value = format_number(safe_read_stat("auric_missions"))
})

table.insert(layout, {
    widget_type = "stat_line",
    text = localize("stats_havoc_missions"),
    value = format_number(safe_read_stat("havoc_missions"))
})

-- Безупречные миссии
table.insert(layout, {
    widget_type = "stat_line",
    text = localize("stats_flawless_missions"),
    value = format_number(safe_read_stat("max_flawless_mission_in_a_row"))
})

-- Havoc ранг (проверяем от высшего к низшему)
local havoc_rank = 0
for i = 8, 1, -1 do
    if safe_read_stat("havoc_rank_reached_0" .. i) > 0 then
        havoc_rank = i * 5
        break
    end
end

if havoc_rank > 0 then
    table.insert(layout, {
        widget_type = "stat_line",
        text = localize("stats_havoc_rank"),
        value = format_number(havoc_rank)
    })
end
```

---

## 📋 Текущая реализация:

Файл: `PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_missions.lua`

Отображает:
1. Общее количество миссий
2. Auric миссии
3. Havoc миссии
4. Безупречные миссии подряд
5. Максимальный достигнутый Havoc ранг

---

## 🔧 Дополнительные статистики миссий (не реализовано):

### Специальные типы миссий:

| Статистика | Описание |
|-----------|----------|
| `personal_flawless_auric` | Безупречные Auric миссии (без смертей игрока) |
| `mission_maelstrom` | Maelstrom миссии |
| `mission_auric_maelstrom` | Auric Maelstrom миссии |
| `flawless_auric_maelstrom` | Безупречные Auric Maelstrom |
| `mission_circumstance` | Миссии с обстоятельствами |
| `havoc_win_assisted` | Победы в Havoc (не владелец заказа) |
| `flawless_havoc_won` | Безупречные Havoc (ранг >= 35) |

### Миссии по типам:

Формат: `mission_<mission_name>_difficulty_<1-5>`

Примеры:
- `mission_cm_raid_difficulty_5`
- `mission_dm_stockpile_difficulty_4`
- `mission_lm_scavenge_difficulty_3`

### Миссии по зонам:

Формат: `zone_<zone_name>_missions_completed`

Примеры:
- `zone_watertown_missions_completed`
- `zone_hub_ship_missions_completed`

### Twins миссии:

| Статистика | Описание |
|-----------|----------|
| `mission_twins` | Twins миссии (максимальная сложность) |
| `mission_twins_hard_mode` | Twins хард мод (сложность 5+) |
| `mission_twins_secret_puzzle_trigger` | Активация секретной головоломки |
| `mission_twins_killed_successfully_within_x` | Убийство Twins за X секунд |
| `mission_twins_no_mines_triggered` | Без активации мин |

---

## 📝 Локализация в файле мода:

Файл: `PlayerProgressStats/scripts/mods/PlayerProgressStats/PlayerProgressStats_localization.lua`

```lua
stats_missions = {
    en = "Missions Completed",
    ru = "Пройдено миссий",
},
stats_auric_missions = {
    en = "Auric Missions",
    ru = "Auric миссий",
},
stats_havoc_missions = {
    en = "Havoc Missions",
    ru = "Havoc миссий",
},
stats_flawless_missions = {
    en = "Flawless Missions in a Row",
    ru = "Безупречных миссий подряд",
},
stats_havoc_rank = {
    en = "Havoc Rank Reached",
    ru = "Достигнут Havoc ранг",
},
```

