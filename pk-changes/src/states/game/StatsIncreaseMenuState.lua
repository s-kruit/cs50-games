-- Menu to display stats increases when Levelling up

StatsIncreaseMenuState = Class{__includes = BaseState}

function StatsIncreaseMenuState:init(pokemon, HPIncrease, attackIncrease, defenseIncrease, speedIncrease)

    -- define menu items and text, calculate before and after values
    local numchars = 7
    local menuItems = {
        {text = pokemon.name,
         onSelect = function()
            gStateStack:pop()
         end},
        {text = "",
         onSelect = function()
            gStateStack:pop()
         end}
    }
    menuItems.insert(self:createMenuItem("HP", pokemon.HP, HPIncrease, numchars))
    menuItems.insert(self:createMenuItem("Attack", pokemon.attack, attackIncrease, numchars))
    menuItems.insert(self:createMenuItem("Defense", pokemon.defense, defenseIncrease, numchars))
    menuItems.insert(self:createMenuItem("Speed", pokemon.speed, speedIncrease, numchars))

    self.statsIncreaseMenu = Menu {
        x = VIRTUAL_WIDTH - 64,
        y = VIRTUAL_HEIGHT - 64,
        width = 64,
        height = 64,
        items = menuItems
    }
end

function StatsIncreaseMenuState:update(dt)
    self.statsIncreaseMenu:update(dt)
end

function StatsIncreaseMenuState:render()
    self.statsIncreaseMenu:render()
end

-- function to generate stat increase text (name: x -> y (+z)) with padding
function StatsIncreaseMenuState:statIncreaseText(name, current_stat, increase, numchars)
    return self:padText(name, numchars, True) .. ": " ..
    self:padText(current_stat - increase, numchars, True) .. " -> " ..
    self:padText(current_stat, numchars, False) .. " (+" .. increase .. ")"

-- function to convert number/string to text of length n with whitespace before or after
function StatsIncreaseMenuState:padText(x, n, whitespace_before)
    local s = tostring(x)
    if #s >= n then
        return s
    else
        whitespace = n - #s
        if whitespace_before == True then
            return string.rep(" ", whitespace) .. s
        else
            return s .. string.rep(" ", whitespace)

-- generate menu item from pokemon, stat name and 
function StatsIncreaseMenuState:createMenuItem(stat_name, current_stat, increase, numchars)
    return {
        text = self:statIncreaseText(stat_name, current_stat, increase, numchars),
        onSelect = function()
            gStateStack:pop()
        end
    }