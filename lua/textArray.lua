EA_TITLE_MAINOPTIONS = "General Configuration";
EA_TITLE_ICONOPTIONS = "Alert Icon Options";
EA_TITLE_SOUNDOPTIONS = "Sound Options"
EA_TITLE_ALERTOPTIONS = "Configure Preset Alerts";
EA_TITLE_CUSTOMALERTOPTIONS = "Configure Custom Alerts";
EA_TITLE_ABOUT = "About EventAlert";

EA_SUBTEXT_MAINOPTIONS = "General settings for EventAlert";
EA_SUBTEXT_ICONOPTIONS = "Configure layout, size, etc of the alert icons.";
EA_SUBTEXT_SOUNDOPTIONS = "Configure sound settings";
EA_SUBTEXT_ALERTOPTIONS = "Configure default settings for preset alerts.\nUncheck to disable alert.";
EA_SUBTEXT_CUSTOMALERTOPTIONS = "Add and remove custom alerts not included in EventAlert.";
EA_SUBTEXT_ABOUT = "Version, changelog and general information about EventAlert.";

EA_TTIP_DOALERTSOUND = "Play a sound when an event triggers.";
EA_TTIP_ALERTSOUNDSELECT = "Choose which sound to play when an event triggers.";
EA_TTIP_LOCKFRAME = "Locks the notification frame so it cannot be moved.";
EA_TTIP_SHOWFRAME = "Toggle the showing/hiding of the notification frame on events.";
EA_TTIP_SHOWNAME = "Toggle the showing/hiding of the buff's name on events.";
EA_TTIP_SHOWFLASH = "Toggle the showing/hiding of the full screen flash on events.";
EA_TTIP_SHOWTIMER = "Toggle the showing/hiding of the remaining buff time on events.";
EA_TTIP_CHANGETIMER = "Changes the font and position of the remaining buff time.";
EA_TTIP_ICONSIZE = "Change the size of the alert icon.";
EA_TTIP_ALLOWESC = "Changes the ability to use the ESC key to close alert frames. (Note:  Requires a reload of the UI)";
EA_TTIP_SHOWSPELLINFO = "Enabling this option shows spell names and spell IDs in the main chat box when any kind of buff or proc activates.";
EA_TTIP_ICONXOFFSET = "Changes the horizontal spacing between notification frames.";
EA_TTIP_ICONYOFFSET = "Changes the vertical spacing between notification frames.";

EA_CLASS_DK = "DEATHKNIGHT";
EA_CLASS_DEMON_HUNTER = "DEMONHUNTER";
EA_CLASS_DRUID = "DRUID";
EA_CLASS_HUNTER = "HUNTER";
EA_CLASS_MAGE = "MAGE";
EA_CLASS_MONK = "MONK";
EA_CLASS_PALADIN = "PALADIN";
EA_CLASS_PRIEST = "PRIEST";
EA_CLASS_ROGUE = "ROGUE";
EA_CLASS_SHAMAN = "SHAMAN";
EA_CLASS_WARLOCK = "WARLOCK";
EA_CLASS_WARRIOR = "WARRIOR";

--[[
  These constants represent spellIDs to display various class power alerts
  It makes the code easier to maintain when one of them is removed from the game
  It also improves readability
--]]
EA_CLASS_DRUID_POWER_SPELLID = 114302;
EA_CLASS_MONK_POWER_SPELLID = 196745;
EA_CLASS_PRIEST_POWER_SPELLID = 199412;
EA_CLASS_PALADIN_POWER_SPELLID = 85247;
EA_CLASS_WARLOCK_POWER_SPELLID = 138556;
EA_CLASS_SHAMAN_POWER_SPELLID = 89631;
EA_CLASS_MAGE_POWER_SPELLID = 36032;
EA_COMBO_POINTS_POWER_SPELLID = 64385;

EA_WARRIOR_VENGEANCE_IGNORE_PAIN_SPELLID = 202574
EA_WARRIOR_VENGEANCE_IGNORE_PAIN_ICON_SPELLID = 190456
EA_WARRIOR_VENGEANCE_FOCUSED_RAGE_SPELLID = 202573
EA_WARRIOR_VENGEANCE_FOCUSED_RAGE_ICON_SPELLID = 204488

EA_HUNTER_KILL_COMMAND_RESET_SPELLID = 259285
EA_HUNTER_KILL_COMMAND_SPELLID = 259489

EA_CLASSES_WITH_POWER = {
  EA_CLASS_MONK,
  EA_CLASS_PALADIN,
  EA_CLASS_ROGUE,
  EA_CLASS_DRUID,
  EA_CLASS_PRIEST,
  EA_CLASS_WARLOCK,
  EA_CLASS_SHAMAN,
  EA_CLASS_MAGE
}

-- Stores the alert sounds fileDataIDs
EA_ALERT_SOUNDS = {
  ShaysBell=568154,
  FluteRun=569642,
  NetherwindFocusImpact=569487,
  PolymorphCow=568761,
  RockBiterImpact=569545,
  YarrrrImpact=568382,
  ValentinesBrokenHeart=568945,
  Millhouse1=555336,
  Millhouse2=555337,
  PissedSatyre=559630,
  PissedDwarf=555839
}
