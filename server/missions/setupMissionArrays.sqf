// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

MainMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 0.1],
	["mission_Coastal_Convoy", 0.1],
	["mission_Convoy", 1],
	["mission_HostileHeliFormation", 0.1],
	["mission_APC", 1],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 1],
	["mission_CivHeli", 1],
	["mission_Smugglers", 1]
];

SideMissions =
[
	["mission_HostileHelicopter", 0.3],
	["mission_HostileJet", 0.5],
	["mission_MiniConvoy", 1],
	["mission_SunkenSupplies", 0.2],
	["mission_AirWreck", 1],
	["mission_Outpost", 1],
	["mission_Truck", 0.5],
	["mission_GeoCache", 0.1],
	["mission_HostageRescue", 1],
	["mission_Occupation", 0.5],
	["mission_Sniper", 0.8]
];

MoneyMissions =
[
	["mission_MoneyShipment", 0.6],
	["mission_SunkenTreasure", 0.2],
	["mission_drugsRunners", 0.5],
	["mission_Roadblock", 1],
	["mission_TownInvasion", 1]
];

missionType_water =
[
	"mission_ArmedDiversquad",
	"mission_Coastal_Convoy",
	"mission_SunkenSupplies",
	"mission_SunkenTreasure"
];

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
RoadblockMissionMarkers = (allMapMarkers select {["Roadblock_", _x] call fn_startsWith}) apply {[_x, false]};
SniperMissionMarkers = (allMapMarkers select {["Sniper_", _x] call fn_startsWith}) apply {[_x, false]};
OccupationMissionMarkers = (allMapMarkers select {["Occupation_", _x] call fn_startsWith}) apply {[_x, false]};

if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
	["mission_AirWreck", 3],
	["mission_Outpost", 0.1],
	["mission_Truck", 0.1],
	["mission_HostageRescue", 0.1],
	["mission_Sniper", 1]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter", "mission_HostileJet"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;

{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;