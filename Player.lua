Player = {}

Player.new = function()
  local self = {}

  self.imgL = love.graphics.newImage("playerLeft.png")
  self.imgR = love.graphics.newImage("playerRight.png")

  self.currentImage = self.imgL

  self.landing = WH / 9 * 6

  self.x = 100
  self.y = self.landing

  self.yv = 0
  self.acceleration = 1400

  self.canFall = false

  self.draw = function()
    love.graphics.draw(self.currentImage, self.x, self.y, 0, scale, scale)
  end

  self.update = function(dt)
    self.canFall = true
    self.y = self.y + self.yv * dt
    if love.keyboard.isDown("a") and self.x - (500 * dt) > 0 then
      self.x = self.x - 500 * dt
      self.currentImage = self.imgL
    end
    if love.keyboard.isDown("d") and self.x + (500 * dt) + self.currentImage:getWidth() * scale < WW then
      self.x = self.x + 500 * dt
      self.currentImage = self.imgR
    end
    if self.y + self.currentImage:getHeight() * scale + self.yv * dt > self.landing then
      self.canFall = false
      self.y = self.landing - self.currentImage:getHeight() * scale
      self.yv = 0
    end

    if love.keyboard.isDown("space") and not self.canFall then
      self.yv = -600
    end

    if self.canFall then
      self.yv = self.yv + self.acceleration * dt
    end
  end

  return self
end
