--[[
    GD50
    Breakout Remake

    -- Ball Class --

    Author: Steve Kruit
    steve.kruit@gmail.com

    Represents a powerup which falls from the top of the screen to the
    bottom, where it can collide with the player's paddle and give the player
    extra abilities such as multiple balls or the ability to unlock locked
    blocks.
]]

Ball = Class{}

function PowerUp:init()
    -- basic dimenisons of PowerUp
    self.width = 16
    self.height = 16
    
    -- initial position at top of screen (plus buffer of 16), randomise 
    -- horizontal position (with buffer of 8 on either side)
    self.x = math.random(8, VIRTUAL_WIDTH - 24)
    self.y = 16
    
    -- movement speed (constant falling)
    self.dx = 0
    self.dy = 40
    
    -- whether powerup is currently in play
    self.inPlay = false
    
    -- type of powerup (e.g. multi ball, key ball etc). Number refers to skin
    -- (index number of gFrames['powerups'] for particular powerup)
    self.skin = 1 
end

--[[
    Copy of the Ball:collides(target) function.
    Expects an argument with a bounding box (paddle)
    and returns true if the bounding boxes of this and the argument overlap.
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

--[[
    Dectivates the powerup, sets to base skin (extra balls) and moves to top
    of screen with random x position.
]]
function PowerUp:reset()
    -- initial position at top of screen (plus buffer of 16), randomise 
    -- horizontal position (with buffer of 8 on either side)
    self.x = math.random(8, VIRTUAL_WIDTH - 24)
    self.y = 16
    self.inPlay = false
    self.skin = 1
end

function PowerUp:update(dt)
    -- if the powerup is inactive, return before doing anything
    if self.inPlay == false then
        return
    end
    
    -- if the powerup is active, continue moving down
    self.y = self.y + self.dy * dt  
end

function PowerUp:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin],
        self.x, self.y)
    end
end