local _, mods = ...

mods["Clique"] = function(F, C)
    if not CliqueSpellTab then return end
    --print("HELLO Clique!!!", F, C)
    local tab = CliqueSpellTab
    F.ReskinTab(tab)

    tab:SetCheckedTexture(C.media.checked)
    local hl = tab:GetHighlightTexture()
    hl:SetPoint("TOPLEFT", 0, 0)
    hl:SetPoint("BOTTOMRIGHT", 0, 0)

    local bg = CreateFrame("Frame", nil, tab)
    bg:SetPoint("TOPLEFT", -1, 1)
    bg:SetPoint("BOTTOMRIGHT", 1, -1)
    bg:SetFrameLevel(tab:GetFrameLevel()-1)
    F.CreateBD(bg)

    select(6, tab:GetRegions()):SetTexCoord(.08, .92, .08, .92)
end
