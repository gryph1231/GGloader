--- Localize Vars
local RubimRH = LibStub("AceAddon-3.0"):GetAddon("RubimRH")
-- Addon
local addonName, addonTable = ...;
-- HeroLib
local HL = HeroLib;
local Cache = HeroCache;
local Unit = HL.Unit;
local Player = Unit.Player;
local Target = Unit.Target;
local Spell = HL.Spell;
local Item = HL.Item;

--- APL Local Vars
-- Spells
if not Spell.Warrior then Spell.Warrior = {}; end
Spell.Warrior.Protection = {
    -- Racials
    ArcaneTorrent = Spell(69179),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Shadowmeld = Spell(58984),
    -- Abilities
    BattleCry = Spell(1719),
    BerserkerRage = Spell(18499),
    Charge = Spell(100),
    DemoralizingShout = Spell(1160),
    Devastate = Spell(20243),
    FuriousSlash = Spell(100130),
    HeroicLeap = Spell(6544),
    HeroicThrow = Spell(57755),
    Revenge = Spell(6572),
    RevengeB = Spell(5302),
    ShieldSlam = Spell(23922),
    ThunderClap = Spell(6343),
    VictoryRush = Spell(34428),
    Victorious = Spell(32216),
    -- Talents
    ImpendingVictory = Spell(202168),
    Shockwave = Spell(46968),
    Vengeance = Spell(202572),
    VegeanceIP = Spell(202574),
    VegeanceRV = Spell(202573),
    -- Artifact
    NeltharionsFury = Spell(203524),
    -- Defensive
    IgnorePain = Spell(190456),
    LastStand = Spell(12975),
    Pummel = Spell(6552),
    ShieldBlock = Spell(2565),
    ShieldBlockB = Spell(132404),
    Avatar = Spell(107574),
	ShieldWall = Spell(871),
};
local S = Spell.Warrior.Protection;
-- Items
if not Item.Warrior then Item.Warrior = {}; end
Item.Warrior.Portection = {};
local I = Item.Warrior.Protection;

local T202PC, T204PC = HL.HasTier("T20");
local T212PC, T214PC = HL.HasTier("T21");




local function APL()
    if not Player:AffectingCombat() then
        return 0, 462338
    end

    HL.GetEnemies("Melee");
    HL.GetEnemies(8, true);
    HL.GetEnemies(10, true);
    HL.GetEnemies(12, true);

    local IsTanking = Player:IsTankingAoE(8) or Player:IsTanking(Target);
    LeftCtrl = IsLeftControlKeyDown();
    LeftShift = IsLeftShiftKeyDown();
    if LeftCtrl and LeftShift and S.Shockwave:IsReady() then
        return S.Shockwave:Cast()
    end

	
	-- ALL OUT DEFENSIVES -----------------------
	
	if S.LastStand:IsReady() and Player:HealthPercentage() <= 50 and not Player:Buff(S.ShieldWall) then
        return S.LastStand:Cast()
    end
	
	if S.ShieldWall:IsReady() and Player:HealthPercentage() <= 50 and not Player:Buff(S.LastStand) then
        return S.ShieldWall:Cast()
    end
	
	
	if S.LastStand:IsReady() and Player:HealthPercentage() <= 30 then
        return S.LastStand:Cast()
    end
	
	if S.ShieldWall:IsReady() and Player:HealthPercentage() <= 30 then
        return S.ShieldWall:Cast()
    end
	
	 if S.ThunderClap:IsReady() and Cache.EnemiesCount[12] >= 2 then
        return S.ThunderClap:Cast()
    end
	
	
	
	if Player:Buff(S.Victorious) and Player:BuffRemains(S.Victorious) <= 2 and S.VictoryRush:IsReady() and Player:HealthPercentage() <= 100 then
        return S.VictoryRush:Cast()
    end
	
	if S.ShieldBlock:IsReady("Melee") and Player:Rage() >= 30 and Player:Buff(S.IgnorePain)  and Cache.EnemiesCount[8] >= 1 and not Player:Buff(S.ShieldBlockB) and S.ShieldBlock:ChargesFractional() >= 1.8 then
        return S.ShieldBlock:Cast()
    end
	
    if RubimRH.CDsON() and S.DemoralizingShout:IsReady() and Cache.EnemiesCount[8] >= 1 and Player:RageDeficit() >= 40 then
        return S.DemoralizingShout:Cast()
    end

    if RubimRH.CDsON() and S.Avatar:IsAvailable() and S.Avatar:IsReady() and Cache.EnemiesCount[8] >= 1 then
        return S.Avatar:Cast()
    end

	
	  if Player:Buff(S.Victorious) and S.VictoryRush:IsReady() and Player:HealthPercentage() <= 85 then
        return S.VictoryRush:Cast()
    end
	
	 if S.IgnorePain:IsReady() and 
	 (Player:Rage() >= 40 and not Player:Buff(S.IgnorePain)) or
	 (Player:HealthPercentage() <= 85 and Player:Rage() >= 40 and S.ShieldBlock:ChargesFractional() < 1 and not Player:Buff(S.IgnorePain)) 
	 then
        return S.IgnorePain:Cast()
    end
	
	 if S.ShieldBlock:IsReady("Melee") and Player:Rage() >= 30 and Player:Buff(S.IgnorePain) and not Player:Buff(S.ShieldBlockB) and Player:HealthPercentage() <= 80 and Cache.EnemiesCount[8] >= 1 then
        return S.ShieldBlock:Cast()
    end
	
 


--    if S.ImpendingVictory:IsAvailable() and S.ImpendingVictory:IsReady() and Player:HealthPercentage() <= 85 then
--        return S.VictoryRush:Cast()
--    end

   -- if Player:Buff(S.Victorious) and S.ImpendingVictory:IsReady() and Player:HealthPercentage() <= 85 then
   --     return S.VictoryRush:Cast()
   -- end

   
   
    if Player:Buff(S.Victorious) and Player:BuffRemains(S.Victorious) <= 2 and S.ImpendingVictory:IsReady() then
        return S.VictoryRush:Cast()
    end

    if S.Revenge:IsReady() and Player:Rage() >= 30 and Cache.EnemiesCount[8] >= 1  and Player:Buff(S.IgnorePain) and Player:HealthPercentage()>=90 and S.ShieldBlock:ChargesFractional() < 1  then
        return S.Revenge:Cast()
    end

	 if S.Revenge:IsReady() and Cache.EnemiesCount[8] >= 1  and Player:Buff(S.RevengeB) then
        return S.Revenge:Cast()
    end
	
    if S.ShieldSlam:IsReady() then
        return S.ShieldSlam:Cast()
    end

    if S.ThunderClap:IsReady() and Cache.EnemiesCount[12] >= 1 then
        return S.ThunderClap:Cast()
    end

    if S.Devastate:IsReady() then
        return S.Devastate:Cast()
    end
   
   
    return 0, 975743
end
RubimRH.Rotation.SetAPL(73, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(73, PASSIVE);