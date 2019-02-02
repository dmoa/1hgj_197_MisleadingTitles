require("Player")
require("Coin")
function love.load()
  WW = love.graphics.getWidth()
  WH = love.graphics.getHeight()
  love.graphics.setDefaultFilter("nearest", "nearest", 1)
  love.mouse.setVisible(false)


  bg = love.graphics.newImage("background.png")
  scale = WW / bg:getWidth()
  player = Player.new()

  playing = false
  font = love.graphics.newFont(60)
  fontsmaller = love.graphics.newFont(30)
  actualtime = 60
  timetext = love.graphics.newText(font, 60)

  bigtext = love.graphics.newText(fontsmaller, "space to start, collect as many coins as you can and survive for 1 minute")
end

function love.draw()
  love.graphics.draw(bg, 0, 0, 0, scale, scale)
  love.graphics.print("collect as many coins as you can!", 0, 0)
  love.graphics.print("ad to move, space to jump", 0, 50)
  if playing then
    player.draw()
    for k, v in ipairs(coins) do
      coins[k].draw()
    end
  else
    love.graphics.draw(bigtext, WW / 2 - bigtext:getWidth() / 2, 300)
  end
  love.graphics.draw(timetext, WW / 2 - timetext:getWidth() / 2, 200)
end

function love.update(dt)
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
  if love.keyboard.isDown("space") and not playing then
    playing = true
    coins = {}
    for i = 1, 25 do
      coin = Coin.new()
      table.insert(coins, coin)
    end
    player.y = 200
    player.yv = 0
    actualtime = 60
  end
  if playing then
    player.update(dt)
    for k, v in ipairs(coins) do
      if playing then
        coins[k].update(dt)
      end
      timetext = love.graphics.newText(font, math.ceil(actualtime))
    end
    actualtime = actualtime - dt
    if actualtime < 0 then
      playing = false
      timetext = love.graphics.newText(font, 0)
      bigtext = love.graphics.newText(fontsmaller, "you win!, misleading?....")
    end
  end
end
