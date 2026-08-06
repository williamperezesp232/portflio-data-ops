# SQL | Project "Formula 1 Analysis"

## 📋 Project Description
This repository contains an end-to-end analytical SQL project focused on historical **Formula 1** race telemetry, drivers, and standings. The project explores raw datasets, solves 15 specific business intelligence questions through relational SQL querying, and implements automated database objects (Views and Stored Procedures) for localized reporting.

## 🎯 Objectives
- Conduct systematic exploratory data analysis (EDA) across historical Formula 1 relational tables.
- Query multi-table join relationships to evaluate driver metrics, team dominance, and race outcomes.
- Apply advanced SQL techniques including self-joins, window functions (`RANK()`), conditional logic (`CASE`), and aggregation with missing-value handling (`COALESCE`).
- Analyze long-term competitive eras, constructor resurgences, and driver consistency across historical regulations.

## 🆘 The Problem
Raw motorsport telemetry and race management data contain millions of records spread across multiple entities. Extracting strategic insights—such as historical team 1-2 finishes, driver grid position improvements, close GP time gaps, and multi-decade team performance shifts—requires optimized relational SQL queries.

## 🛠️ Tools to Use
- **Database Engine:** MySQL / MariaDB (utilizing custom schema `raw_formula_unicorn`)
- **Query Tool:** DBeaver / Visual Studio Code
- **Language:** SQL (Data Query Language & Data Definition Language)

## 📊 Project Dataset
The analytical queries run on the `raw_formula_unicorn` schema, which includes the following core entities:
- `circuits`, `races`, `seasons`
- `drivers`, `driver_standings`
- `constructors`, `constructor_results`, `constructor_standings`
- `results`, `sprint_results`, `qualifying`, `pit_stops`, `status`

## ⚖️ Relational Analysis
The database employs a normalized relational structure:
- **Foreign Keys:** `raceId`, `driverId`, `constructorId`, `statusId`, and `circuitId` link transactional tables (`results`, `qualifying`) to dimension entities (`drivers`, `constructors`, `races`).
- **Self-Joins:** Applied on `results` to identify team 1-2 finishes (`r1.position = 1 AND r2.position = 2`) and minimal time differences between 1st and 2nd place.

## 🔄 Exploratory Data Analysis
Initial inspection included schema validation and limit checks across all tables:
- Standardized data structure verification via `DESCRIBE` commands.
- Record preview using `LIMIT 10` on all core raw tables.
- Data consistency checks revealing **77 distinct circuits** and **26,759 driver entries/records** across historical records.

## 💡 Development

### Code Analysis and Description
The main script (`f1_analysis.sql`) covers key analytical querying and database automation techniques, including stored procedures and view definitions.

## ✅ Insights Obtained

- **Circuits & Driver Scale:** 77 unique circuits and 26,759 driver entries recorded throughout F1 history.
- **Most Historical Wins:** Ferrari, McLaren, and Mercedes lead all-time constructor victories.
- **Podium & Fastest Lap Leaders:** Lewis Hamilton holds the highest number of fastest laps and total podium finishes.
- **Best Average Finishing Positions:** Historical legends such as Fangio, Fagioli, Wallard, Serafini, and Amick hold top consistency records.
- **Pole Positions Leader:** Mercedes holds the record for most team pole positions.
- **Top 2024 Season Constructors:**
  - **McLaren:** 609 points (1st)
  - **Ferrari:** 595 points (2nd)
  - **Red Bull:** 537 points (3rd)
  - **Mercedes:** 433 points (4th)
  - **Aston Martin:** 94 points (5th)
- **Position Gain Record:** Driver Ball registered the highest average position gains from starting grid spots.
- **1-2 Team Finishes (Dobletes):** Ferrari, Mercedes, and McLaren lead all-time 1-2 finishes.
- **Narrowest GP Victory Margins:** Italian GP, US GP, Spanish GP, and Austrian GP registered the smallest millisecond gaps between 1st and 2nd place.
- **Recent Driver Participation:** 2024 (24 drivers), 2023 (22), 2022 (22), 2021 (21), 2020 (23).
- **All-Time Constructor Points Top 5:**
  - **Ferrari:** 11,091.27 pts
  - **Mercedes:** 7,730.64 pts
  - **Red Bull:** 7,673.00 pts
  - **McLaren:** 7,022.50 pts
  - **Williams:** 3,641.00 pts

## 🔍 Conclusions

### 🏁 History, Drivers & Participation Evolution
- **Driver Participation:** Early eras (1950s–1970s) saw high driver turnover (30 to 100+ drivers per season). From 2000 to the present, participation stabilized into a closed range of **20–24 drivers**, reflecting structural professionalization, fixed team grid spots (10–12 teams), and strict contractual regulations.
- **Driver Legacy Shift:** While Lewis Hamilton consolidates historical dominance in podiums and fastest laps, the current competitive era highlights a generational shift towards Verstappen, Norris, Leclerc, Piastri, and Sainz.

### 🏆 Team Performance & Era Dominance
- **Ferrari:** Remains the most successful historical team (11,000+ total points) and demonstrated a strong resurgence in 2024 with 595 points.
- **Mercedes Hybrid Era (2014–2021):** Dominated qualifying (poles) and 1-2 finishes, regularly exceeding 700 points per season (peaking at 765 in 2016). However, performance dropped to 433 points in 2024.
- **Red Bull Era (2013, 2022–2023):** Maintained elite dominance exceeding 700 points in championship-winning seasons and remained competitive in 2024 (537 pts).
- **McLaren's Resurgence:** Showed a dramatic competitive turnaround, rising from 27 points in 2015 to leading the 2024 Constructors' Championship with **609 points**.
- **Historical Decline (Williams):** Highlighted the technical gap faced by legacy teams—dropping from 300+ points in 2014–2015 to minimal tallies in recent seasons.