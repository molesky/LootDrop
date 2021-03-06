------------------------------------------------
-- Loot Drop - show me what I got
--
-- @classmod LootDroppable
-- @author Pawkette ( pawkette.heals@gmail.com )
--[[
The MIT License (MIT)

Copyright (c) 2014 Pawkette

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]
------------------------------------------------

LootDroppable = ZO_Object:Subclass()

function LootDroppable:New( ... )
    local result = ZO_Object.New( self )
    result:Initialize( ... )
    return result
end

function LootDroppable:Initialize( objectPool )
    self.control = CreateControlFromVirtual( 'LootDroppable', objectPool:GetControl(), 'LootDroppable', objectPool:GetNextControlId() )
    self.label = self.control:GetNamedChild( '_Name' )
    self.icon = self.control:GetNamedChild( '_Icon' )

    self.animation = ZO_AlphaAnimation:New( self.control )
    self.translate = LibTranslateAnimation:New( self.control )

    self:SetAnchor( BOTTOMRIGHT, objectPool:GetControl(), BOTTOMRIGHT, 220, 0 )

    self.control:SetAlpha( 0 )
    self.label:SetText( '' )
    self.icon:SetTexture( '' )

    self.timestamp = 0
end

function LootDroppable:IsVisible()
    return self.control:GetAlpha() > 0
end

function LootDroppable:Show( y )
    self.animation:FadeIn( 0, 200 )
    self.translate:TranslateTo( 220, y, 0, y, 200, 0 )
end

function LootDroppable:Reset()
    self.animation:FadeOut( 0, 200 )
    local y = self:GetOffsetY()
    self.translate:TranslateTo( 0, y, 220, y, 200, 0 )
    self.label:SetText( '' )
    self.icon:SetHidden( true )
    self.icon:SetTexture( '' )
    self.timestamp = 0
end

function LootDroppable:GetControl()
    return self.control
end

function LootDroppable:SetTimestamp( stamp )
    self.timestamp = stamp
end

function LootDroppable:GetTimestamp()
    return self.timestamp
end

function LootDroppable:SetLabel( label )
    self.label:SetText( label )
end

function LootDroppable:SetIcon( icon )
    self.icon:SetTexture( icon )
    self.icon:SetHidden( false )
end

function LootDroppable:SetAnchor( ... )
    self.control:SetAnchor( ... )
end

function LootDroppable:TranslateTo( ... )
    self.translate:TranslateTo( ... )
end

function LootDroppable:GetOffsetY()
    local _, _, _, _, _, offsY = self.control:GetAnchor( 0 )
    return offsY
end