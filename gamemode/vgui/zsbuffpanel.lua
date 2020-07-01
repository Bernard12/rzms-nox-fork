local PANEL = {}

function PANEL:Init()
    local width = BetterScreenScale() * 300
    local height = BetterScreenScale() * 15
    self:SetWide(width)
    self:SetTall(height)
    
    self:SetPos(ScrW() / 2 - width / 2, ScrH() * 60 / 100)
end

function PANEL:Paint(w, h)
    local lp = MySelf
    if not lp:IsValid() and lp:Team() ~= TEAM_HUMAN then
        return
    end

    local startTime = lp:GetPatientStatusStartTime()
    local duration = lp:GetPatientStatusDuration()
    local isStatusNotExpired = CurTime() - startTime < duration

    if startTime and duration and isStatusNotExpired then
        local remainingTime = duration  - (CurTime() - startTime)
        local partition = math.Clamp(remainingTime / duration, 0, 1)
        local patientName = lp:GetPatient():Name()

        local w = self:GetWide()
        local h = self:GetTall()

        surface.SetDrawColor(0, 0, 0, 230)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(214, 158, 27, 255)
        surface.DrawRect(1, 1, partition * (w - 2), h - 2)
    end

    return true
end

vgui.Register("ZSBuffPanel", PANEL, "Panel")