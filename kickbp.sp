#pragma semicolon 1

#define PLUGIN_AUTHOR "F0rest"
#define PLUGIN_VERSION "1.00"

#include <sourcemod>
#include <sdktools>
#include <cstrike>
#include "kodinc.sp"
//#include <sdkhooks>

#pragma newdecls required

EngineVersion g_Game;

public Plugin myinfo = 
{
	name = "Kick Baipiao",
	author = PLUGIN_AUTHOR,
	description = "Kick baipiao when cmd executed",
	version = PLUGIN_VERSION,
	url = "https://github.com/F0rest-csgo"
};

public void OnPluginStart()
{
	g_Game = GetEngineVersion();
	if(g_Game != Engine_CSGO && g_Game != Engine_CSS)
	{
		SetFailState("This plugin is for CSGO/CSS only.");	
	}
	RegAdminCmd("sm_kickbp", OnKickBp, ADMFLAG_ROOT);
}

public Action OnKickBp(int client,int args)
{
	char reason[1000];
	GetCmdArgString(reason, sizeof(reason));
	for (int i = 1; i <= MaxClients; i++)
	{
		if(IsValidClient(i))
		{
			bool PlayerFlags[AdminFlags_TOTAL];
			PlayerFlags = GetAccess(i);
			if(!PlayerFlags[VIP])
			{
				KickClient(i, reason);
			}
		}
	}
	return Plugin_Continue;
}