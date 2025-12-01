# ⚔️ Вкладка "Враги" (Enemies)

---

## Статистики для вкладки "Враги"

### 👹 Боссы (Bosses):

| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `total_chaos_beast_of_nurgle_killed` | Игра: `loc_breed_display_name_chaos_beast_of_nurgle`<br>Своя: `stats_beast_of_nurgle` | Beast of Nurgle |
| `total_chaos_spawn_killed` | Игра: `loc_breed_display_name_chaos_spawn`<br>Своя: `stats_chaos_spawn` | Chaos Spawn |
| `total_chaos_plague_ogryn_killed` | Игра: `loc_breed_display_name_chaos_plague_ogryn`<br>Своя: `stats_plague_ogryn` | Plague Ogryn |
| `total_chaos_daemonhost_killed` | Игра: `loc_breed_display_name_chaos_daemonhost`<br>Своя: `stats_daemonhost` | Daemonhost |
| `total_chaos_mutator_daemonhost_killed` | Игра: `loc_breed_display_name_chaos_daemonhost`<br>Своя: `stats_daemonhost` | Mutator Daemonhost |

**Примечание:** Daemonhost и Mutator Daemonhost суммируются вместе.

### 🛡️ Элиты (Elites):

#### Chaos Ogryn:
| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `total_chaos_ogryn_gunner_killed` | Игра: `loc_breed_display_name_chaos_ogryn_gunner`<br>Своя: `stats_ogryn_gunner` | Chaos Ogryn Gunner |
| `total_chaos_ogryn_executor_killed` | Игра: `loc_breed_display_name_chaos_ogryn_executor`<br>Своя: `stats_ogryn_executor` | Chaos Ogryn Executor |
| `total_chaos_ogryn_bulwark_killed` | Игра: `loc_breed_display_name_chaos_ogryn_bulwark`<br>Своя: `stats_ogryn_bulwark` | Chaos Ogryn Bulwark |

#### Gunners:
| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `total_renegade_gunner_killed` | Игра: `loc_breed_display_name_renegade_gunner`<br>Своя: `stats_renegade_gunner` | Renegade Gunner |
| `total_cultist_gunner_killed` | Игра: `loc_breed_display_name_cultist_gunner`<br>Своя: `stats_cultist_gunner` | Cultist Gunner |

### ⚡ Специалисты (Specials):

| Статистика | Локализация | Описание |
|-----------|-------------|----------|
| `total_chaos_poxwalker_bomber_killed` | Игра: `loc_breed_display_name_chaos_poxwalker_bomber`<br>Своя: `stats_poxburster` | Poxburster |
| `total_chaos_hound_killed` | Игра: `loc_breed_display_name_chaos_hound`<br>Своя: `stats_hound` | Chaos Hound |
| `total_chaos_hound_mutator_killed` | Игра: `loc_breed_display_name_chaos_hound`<br>Своя: `stats_hound` | Chaos Hound Mutator |
| `total_cultist_mutant_killed` | Игра: `loc_breed_display_name_cultist_mutant`<br>Своя: `stats_mutant` | Cultist Mutant |
| `total_cultist_mutant_mutator_killed` | Игра: `loc_breed_display_name_cultist_mutant`<br>Своя: `stats_mutant` | Cultist Mutant Mutator |
| `total_renegade_flamer_killed` | Игра: `loc_breed_display_name_renegade_flamer`<br>Своя: `stats_flamer` | Renegade Flamer |
| `total_renegade_flamer_mutator_killed` | Игра: `loc_breed_display_name_renegade_flamer`<br>Своя: `stats_flamer` | Renegade Flamer Mutator |
| `total_cultist_flamer_killed` | Игра: `loc_breed_display_name_cultist_flamer`<br>Своя: `stats_flamer` | Cultist Flamer |
| `total_renegade_sniper_killed` | Игра: `loc_breed_display_name_renegade_sniper`<br>Своя: `stats_sniper` | Renegade Sniper |
| `total_renegade_netgunner_killed` | Игра: `loc_breed_display_name_renegade_netgunner`<br>Своя: `stats_netgunner` | Renegade Netgunner |

**Примечания:** 
- Hound: обычный + mutator суммируются
- Mutant: обычный + mutator суммируются
- Flamer: renegade + renegade_mutator + cultist суммируются

---

## 💻 Пример кода для вкладки:

```lua
-- tab_enemies.lua

local layout = {}

-- Боссы
table.insert(layout, {widget_type = "stat_header", text = localize("stats_bosses")})
table.insert(layout, {
    widget_type = "stat_line",
    text = localize("loc_breed_display_name_chaos_daemonhost"),  -- Официальная локализация
    value = format_number(safe_read_stat("total_chaos_daemonhost_killed"))
})

-- Элиты
table.insert(layout, {widget_type = "stat_header", text = localize("stats_elites")})

-- Специалисты
table.insert(layout, {widget_type = "stat_header", text = localize("stats_specials")})
```

---

## 📋 Текущая реализация:

Файл: `PlayerProgressStats/scripts/mods/PlayerProgressStats/views/tabs/tab_enemies.lua`

Структура вкладки:
1. **Секция "БОССЫ"** (header)
   - Beast of Nurgle
   - Chaos Spawn
   - Plague Ogryn
   - Daemonhost (сумма обычного и mutator)

2. **Секция "ЭЛИТЫ"** (header)
   - Ogryn Gunner
   - Ogryn Executor
   - Ogryn Bulwark
   - Renegade Gunner
   - Cultist Gunner

3. **Секция "СПЕЦИАЛИСТЫ"** (header)
   - Poxburster
   - Hound (сумма обычного и mutator)
   - Mutant (сумма обычного и mutator)
   - Flamer (сумма всех типов)
   - Sniper
   - Netgunner

---

## 🔧 Для добавления новых врагов:

1. Найдите breed_name в `scripts/settings/breed/breeds.lua`
2. Статистика автоматически: `total_{breed_name}_killed`
3. Локализация автоматически: `loc_breed_display_name_{breed_name}`
4. Проверьте наличие mutator версии
5. Добавьте в соответствующую секцию (bosses/elites/specials)

### Полный список элитных врагов:

**Renegade Elites:**
- `total_renegade_shocktrooper_killed` - `loc_breed_display_name_renegade_shocktrooper`
- `total_renegade_plasma_gunner_killed` - `loc_breed_display_name_renegade_plasma_gunner`
- `total_renegade_gunner_killed` - `loc_breed_display_name_renegade_gunner`
- `total_renegade_executor_killed` - `loc_breed_display_name_renegade_executor`
- `total_renegade_berzerker_killed` - `loc_breed_display_name_renegade_berzerker`

**Cultist Elites:**
- `total_cultist_shocktrooper_killed` - `loc_breed_display_name_cultist_shocktrooper`
- `total_cultist_gunner_killed` - `loc_breed_display_name_cultist_gunner`
- `total_cultist_berzerker_killed` - `loc_breed_display_name_cultist_berzerker`

**Chaos Ogryn Elites:**
- `total_chaos_ogryn_executor_killed` - `loc_breed_display_name_chaos_ogryn_executor`
- `total_chaos_ogryn_gunner_killed` - `loc_breed_display_name_chaos_ogryn_gunner`
- `total_chaos_ogryn_bulwark_killed` - `loc_breed_display_name_chaos_ogryn_bulwark`

### Полный список специалистов:

| Статистика | Локализация |
|-----------|-------------|
| `total_renegade_sniper_killed` | `loc_breed_display_name_renegade_sniper` |
| `total_renegade_netgunner_killed` | `loc_breed_display_name_renegade_netgunner` |
| `total_renegade_flamer_killed` | `loc_breed_display_name_renegade_flamer` |
| `total_renegade_flamer_mutator_killed` | `loc_breed_display_name_renegade_flamer` |
| `total_renegade_grenadier_killed` | `loc_breed_display_name_renegade_grenadier` |
| `total_cultist_grenadier_killed` | `loc_breed_display_name_cultist_grenadier` |
| `total_cultist_mutant_killed` | `loc_breed_display_name_cultist_mutant` |
| `total_cultist_mutant_mutator_killed` | `loc_breed_display_name_cultist_mutant` |
| `total_cultist_flamer_killed` | `loc_breed_display_name_cultist_flamer` |
| `total_chaos_poxwalker_bomber_killed` | `loc_breed_display_name_chaos_poxwalker_bomber` |
| `total_chaos_hound_killed` | `loc_breed_display_name_chaos_hound` |
| `total_chaos_hound_mutator_killed` | `loc_breed_display_name_chaos_hound` |

