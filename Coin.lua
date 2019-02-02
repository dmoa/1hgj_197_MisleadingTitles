Coin = {}

Coin.new = function()
  local self = {}
  self.image = love.graphics.newImage("coin.png")
  self.x = love.math.random(0, WW - self.image:getWidth() * scale)
  self.y = love.math.random(-600, - 60)

  self.draw = function()
    love.graphics.draw(self.image, self.x, self.y, 0, scale, scale)
  end

  self.update = function(dt)
    self.y = self.y + 300 * dt
    if self.y + self.image:getHeight() * scale > player.landing then
      self.y = love.math.random(-600, - 60)
      self.x = love.math.random(0, WW - self.image:getWidth() * scale)
    end
    if self.y + self.image:getHeight() * scale > player.y and self.y < player.y + player.currentImage:getHeight() * scale and
    self.x + self.image:getWidth() * scale > player.x and self.x < player.x + player.currentImage:getWidth() * scale then
      playing = false
      coins = {}
      bigtext = love.graphics.newText(fontsmaller, "space to try again!, collect as many coins as you can and survive for 1 minute")
    end
  end
  return self
end
