-- based on: http://www.wowinterface.com/downloads/info23605-wMinimap.html
-- Icon Credit: http://game-icons.net/

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -6, -6)
Minimap:SetSize(175, 175)

Minimap:SetBackdrop({
		bgFile =  "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
		insets = {left = -0, right = -0, top = -0, bottom = -0}
					})
Minimap:SetBackdropColor(0,0,0,1)
Minimap:SetBackdropBorderColor(0,0,0,1)

-- displays time/clock

if not IsAddOnLoaded("Blizzard_TimeManager") then
  LoadAddOn("Blizzard_TimeManager")
end

-- Remove "--" in next line for 24h format
-- if not TimeManagerMilitaryTimeCheck:GetChecked() then TimeManagerMilitaryTimeCheck:Click() end

local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont("Interface\\Addons\\OobieMinimap\\PTSans-Bold.ttf", 16, "THINOUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("CENTER", Minimap, "BOTTOM", 0,11)
clockTime:Show()

-- Shape Square

Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- functions

local function StripTextures(object, kill)
	for i=1, object:GetNumRegions() do
		local region = select(i, object:GetRegions())
		if region:GetObjectType() == "Texture" then
			if kill then
				region:Hide()
			else
				region:SetTexture(nil)
			end
		end
	end
end

-- stripping textures from some icon

StripTextures(QueueStatusFrame)
StripTextures(GarrisonLandingPageMinimapButton)

-- Minimap Buttons

MinimapBorder:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MinimapBorderTop:Hide()
MiniMapVoiceChatFrame:Hide()
MinimapNorthTag:SetTexture(nil)
-- MinimapZoneTextButton:Hide()
MiniMapWorldMapButton:Hide()
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Hide()
GameTimeFrame:Hide()

--Mail

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPLEFT", Minimap, -1,2)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailIcon:SetTexture("Interface\\Addons\\OobieMinimap\\mail")
MiniMapMailBorder:Hide()
MiniMapMailFrame:SetScale(1.5)

-- Garrison

GarrisonLandingPageMinimapButton:SetSize(38, 38)
GarrisonLandingPageMinimapButton:SetAlpha(0)
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetParent(Minimap)
GarrisonLandingPageMinimapButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 3, -3)

local GarrisonIcon = CreateFrame("Frame", "GarrisonIcon")
GarrisonIcon:SetPoint("CENTER", GarrisonLandingPageMinimapButton, "CENTER", 0,0)
GarrisonIcon:SetSize(20,20)
GarrisonIcon:SetBackdrop{
	bgFile = "Interface\\Addons\\OobieMinimap\\garrison"
}
GarrisonIcon:SetAlpha(0)

-- DungeonFinder LFG LFR

QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, -2)
QueueStatusMinimapButtonBorder:Hide()
QueueStatusFrame:SetBackdrop({
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
  edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
	insets = {left = -0, right = -0, top = -0, bottom = -0}
})
QueueStatusFrame:SetBackdropColor(0,0,0,0.5)
QueueStatusFrame:SetBackdropBorderColor(0,0,0,1)
QueueStatusFrame:SetBackdropBorderColor(0, 0, 0,1)

--Tracking

MiniMapTrackingBackground:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", Minimap, 1, 1)
MiniMapTrackingButtonBorder:Hide()
MiniMapTrackingButton:SetBackdropBorderColor(0, 0, 0)
MiniMapTracking:SetAlpha(0)

local function OnLeave()
    if not Minimap:IsMouseOver() then
    	MiniMapTracking:SetAlpha(0)
    	GarrisonIcon:SetAlpha(0)
    end
end

Minimap:HookScript('OnEnter', function()
	MiniMapTracking:SetAlpha(1)
	GarrisonIcon:SetAlpha(1)
end)
Minimap:HookScript('OnLeave', OnLeave)
MiniMapTrackingButton:HookScript('OnLeave', OnLeave)
QueueStatusMinimapButton:HookScript('OnLeave', OnLeave)
MiniMapMailFrame:HookScript('OnLeave', OnLeave)
TimeManagerClockButton:HookScript('OnLeave', OnLeave)

-- Scrolling in Minimap

Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)
