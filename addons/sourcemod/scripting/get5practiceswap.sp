/**
 * =============================================================================
 * PracticeMode & Get5 Swapping
 * Copyright (C) 2021. Jack Price.  All rights reserved.
 * =============================================================================
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <cstrike>
#include <sdktools>
#include <sourcemod>

public Plugin myinfo = {
    name = "PracticeMode & Get5 Swapping",
    author = "Ferex",
    description = "Automates the swapping of PracticeMode and Get5",
    version = "1.0.0",
    url = "https://github.com/Ferexx/get5practiceswap"
};

public void OnPluginStart() {
    RegConsoleCmd("useget5", Command_Get5Activate);
    RegConsoleCmd("usepracticemode", Command_PracticeModeActivate);
}

public Action Command_Get5Activate(int client, int args) {
    ServerCommand("sm plugins unload practicemode");
    char disabledPath[256], enabledPath[256];
    BuildPath(Path_SM, disabledPath, sizeof(disabledPath), "plugins/disabled/practicemode.smx");
    BuildPath(Path_SM, enabledPath, sizeof(enabledPath), "plugins/practicemode.smx");
    RenameFile(disabledPath, enabledPath);
    
    BuildPath(Path_SM, disabledPath, sizeof(disabledPath), "plugins/disabled/get5.smx");
    BuildPath(Path_SM, enabledPath, sizeof(enabledPath), "plugins/get5.smx");
    RenameFile(enabledPath, disabledPath);
    ServerCommand("sm plugins load get5");
    ServerCommand("sm plugins reload get5_apistats");
    ServerCommand("sm plugins reload get5discord");
}

public Action Command_PracticeModeActivate(int client, int args) {
    ServerCommand("sm plugins unload get5");
    char disabledPath[256], enabledPath[256];
    BuildPath(Path_SM, disabledPath, sizeof(disabledPath), "plugins/disabled/get5.smx");
    BuildPath(Path_SM, enabledPath, sizeof(enabledPath), "plugins/get5.smx");
    RenameFile(disabledPath, enabledPath);

    BuildPath(Path_SM, disabledPath, sizeof(disabledPath), "plugins/disabled/practicemode.smx");
    BuildPath(Path_SM, enabledPath, sizeof(enabledPath), "plugins/practicemode.smx");
    RenameFile(enabledPath, disabledPath);
    ServerCommand("sm plugins load practicemode");
    ServerCommand("sm_prac");
}