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
-- Spells
if not Spell.Warrior then Spell.Warrior = {}; end
Spell.Warrior.Fury = {
    -- Racials
    ArcaneTorrent = Spell(69179),
    Berserking = Spell(26297),
    BloodFury = Spell(20572),
    Shadowmeld = Spell(58984),
    -- Abilities
    BattleCry = Spell(1719),
    BerserkerRage = Spell(18499),
    Bloodthirst = Spell(23881),
    Charge = Spell(100),
    Enrage = Spell(184362),
    EnragedRegeneration = Spell(184364),
	
	BattleShout = Spell(6673),
	BS = Spell(155145),
	
    Execute = Spell(5308),
    HeroicLeap = Spell(6544),
    HeroicThrow = Spell(57755),
    MeatCleaver = Spell(85739),
    RagingBlow = Spell(85288),
    Rampage = Spell(184367),
	
	Recklessness = Spell(1719),
    Whirlwind = Spell(190411),
	
    -- Talents
    Avatar = Spell(107574),
    Bladestorm = Spell(46924),
    Bloodbath = Spell(12292),
    BoundingStride = Spell(202163),
    Carnage = Spell(202922),
    DragonRoar = Spell(118000),
    Frenzy = Spell(206313),
    FrenzyBuff = Spell(202539),
    FrothingBerserker = Spell(215571),
    InnerRage = Spell(215573),
    Massacre = Spell(206315),
    MassacreBuff = Spell(206316),
    Outburst = Spell(206320),
    RecklessAbandon = Spell(202751),
    WreckingBall = Spell(215570),
	WhirlwindBuff = Spell(85739),
    WreckingBallTalent = Spell(215569),
    -- Artifact
    Juggernaut = Spell(980),
    OdynsFury = Spell(205545),

    -- Talents
    SiegeBreaker = Spell(280772),
    FuriousSlash = Spell(100130),

    -- Defensive
    -- Utility
    Pummel = Spell(6552),
    -- Legendaries
    FujiedasFury = Spell(207776),
    StoneHeart = Spell(225947),
    -- Misc
	Victorious = Spell(32216),
	VictoryRush = Spell(34428),
	VR = Spell(20594),
	
    UmbralMoonglaives = Spell(242553),
	    FaultyCountermeasure = Spell(214962),
		FC = Spell(20572),
	
	DragonRoar = Spell(118000),
		
		
};
local S = Spell.Warrior.Fury;
-- Items
if not Item.Warrior then Item.Warrior = {}; end
Item.Warrior.Fury = {
    -- Legendaries
    KazzalaxFujiedasFury = Item(137053, { 15 }),
    NajentussVertebrae = Item(137087, { 6 }),
    -- Trinkets
    ConvergenceofFates = Item(140806, { 13, 14 }),
    DraughtofSouls = Item(140808, { 13, 14 }),
    UmbralMoonglaives = Item(147012, { 13, 14 }),
	 FaultyCountermeasure = Item(137539, { 13, 14 }),
    -- Potions
    PotionOfProlongedPower = Item(142117),
    PotionoftheOldWar = Item(127844),
};
local I = Item.Warrior.Fury;
local T202PC, T204PC = HL.HasTier("T20");
local T212PC, T214PC = HL.HasTier("T21");

--- APL Action Lists (and Variables)
-- # AoE
local function AoE()



end

-- # CDs
local function CDs()





end

-- Cleave
local function Cleave()





end



-- # execute
local function Execute()

end

-- # single_target
local function Single_Target()

    if I.FaultyCountermeasure:IsReady() and I.FaultyCountermeasure:IsEquipped() and Player:BuffP(S.Recklessness)  then
        return S.FC:Cast()
    end

	
	
	
		
	if S.Rampage:IsReady() and S.Recklessness:CooldownRemainsP() < 3 then
		return S.Rampage:Cast()
	end
	
	
	
		if S.DragonRoar:IsReady() and Player:BuffP(S.Enrage) and Cache.EnemiesCount[10] > 1 then
		return S.DragonRoar:Cast()
	end
	
	
	if S.Whirlwind:IsReady() and Cache.EnemiesCount[10] > 1 and not Player:BuffP(S.WhirlwindBuff) then
		return S.Whirlwind:Cast()
	end 
	
	if RubimRH.CDsON() and S.Recklessness:IsReady(6) then
         return S.Recklessness:Cast()
     end

	 if S.EnragedRegeneration:IsReady() and Player:HealthPercentage() <= 50 then
		return S.EnragedRegeneration:Cast()
	end
	
	 
	 if S.VictoryRush:IsReady() and Player:HealthPercentage() <= 60 and Player:Buff(S.Victorious) then
		return S.VR:Cast()
	end
	 
	 
	if S.Rampage:IsReady() and Player:Rage() > 75 and (
	(Player:BuffP(S.Recklessness)) or 
	((S.FrothingBerserker:IsAvailable() or S.Carnage:IsAvailable()) and (Player:BuffRemainsP(S.Enrage) < Player:GCD() or Player:Rage() > 90)) or
	(S.Massacre:IsAvailable() and (Player:BuffRemainsP(S.Enrage) < Player:GCD() or Player:Rage() > 90))
	)
	then
		return S.Rampage:Cast()
	end
	
	if S.Execute:IsReady() and Player:BuffP(S.Enrage) then
		return S.Execute:Cast()
	end
	
	if S.Bloodthirst:IsReady() and not Player:BuffP(S.Enrage) then
		return S.Bloodthirst:Cast()
	end
	
	if S.RagingBlow:IsReady() and S.RagingBlow:ChargesFractional() >= 1.8 then
		return S.RagingBlow:Cast()
	end
		
	if S.Bloodthirst:IsReady() then
		return S.Bloodthirst:Cast()
	end
	
	--dragon_roar,if=buff.enrage.up&(buff.siegebreaker.up|!talent.siegebreaker.enabled)
	if S.DragonRoar:IsReady() and Player:BuffP(S.Enrage) then
		return S.DragonRoar:Cast()
	end
	
	
	if S.RagingBlow:IsReady() and (
	(S.Carnage:IsAvailable()) or
	(S.Massacre:IsAvailable() and Player:Rage() < 80) or 
	(S.FrothingBerserker:IsAvailable() and Player:Rage() < 90)
	)
	then
		return S.RagingBlow:Cast()
	end
	
	
	--if S.VictoryRush:IsReady() and Player:HealthPercentage() < 100 and Player:Buff(S.Victorious) and Player:BuffRemains(Victorious) < 2 then
	--	return S.VR:Cast()
--	end
	
	if S.Whirlwind:IsReady() then
		return S.Whirlwind:Cast()
	end 
	
end

-- APL Main
local function APL()
    -- Unit Update
	HL.GetEnemies(6);
    HL.GetEnemies(8);
    HL.GetEnemies(10);

    if not Player:AffectingCombat() then
	
	 if S.BattleShout:IsCastable() and not Player:BuffP(S.BattleShout) then 
             return S.BS:Cast()
        end
		
	
	
        return 0, 462338
    end

	
	
  if Target:Exists() then
        if Single_Target() ~= nil then
            return Single_Target()
        end
    end
	
	
    return 0, 975743
end
RubimRH.Rotation.SetAPL(72, APL);

local function PASSIVE()
    return RubimRH.Shared()
end

RubimRH.Rotation.SetPASSIVE(72, PASSIVE);