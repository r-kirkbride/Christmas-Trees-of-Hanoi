push = require 'lib/push'
Class = require 'lib/class'

require 'Layer'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Christmas Tree of Hanoi')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    love.keyboard.keysPressed = {}

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(smallFont)

    numDiscs = 6
    layers = {}

    rod1 = {}
    rod2 = {}
    rod3 = {}
    
    for i=0,numDiscs,1 do
        layers[i] = Layer(200, 650-(numDiscs*30)+30*i, 75+25*i, 50, 10)
    end

    for i, v in ipairs(layers) do
        rod1[i] = v
        rod2[i] = nil
        rod3[i] = nil
    end


end

--[[ function love.update(dt)
    if GAME_STATE == "start" then
        if love.keyboard.wasPressed('return') then
            GAME_STATE = "serve"
        end
        player1Score = 0
        player2Score = 0
    elseif GAME_STATE == "serve" then
        if love.keyboard.isDown('w') then
            player1:moveUp(dt)
        end
        if love.keyboard.isDown('s') then
            player1:moveDown(dt)
        end

        if love.keyboard.isDown('p') then
            player2:moveUp(dt)
        end
        if love.keyboard.isDown('l') then
            player2:moveDown(dt)
        end
        if love.keyboard.wasPressed('return') then
            ball.dy = ball.dy + math.random(-50, 50)
            if math.random(1, 2) == 1 then
                ball.dx = -400
            else
                ball.dx = 400
            end
            GAME_STATE = "play"
        end
    elseif GAME_STATE == "play" then
        if love.keyboard.isDown('w') then
            player1:moveUp(dt)
        end
        if love.keyboard.isDown('s') then
            player1:moveDown(dt)
        end

        if love.keyboard.isDown('p') then
            player2:moveUp(dt)
        end
        if love.keyboard.isDown('l') then
            player2:moveDown(dt)
        end

        if ball:collides(player1) then
            if ball.dx < 0 then
                ball.x = ball.x + 5
            else
                ball.x = ball.x - 5
            end
            if love.keyboard.isDown('w') or love.keyboard.isDown('s') then
                ball.dy = ball.dy * 2
            end
            ball.dx = ball.dx * -1
        elseif ball:collides(player2) then
            if ball.dx < 0 then
                ball.x = ball.x + 5
            else
                ball.x = ball.x - 5
            end
            if love.keyboard.isDown('p') or love.keyboard.isDown('l') then
                ball.dy = ball.dy * 2
            end
            ball.dx = ball.dx * -1
        end

        if ball.x < 0 then
            GAME_STATE = "serve"
            player2Score = player2Score + 1
            ball:reset()
        elseif ball.x > 432 then
            GAME_STATE = "serve"
            player1Score = player1Score + 1
            ball:reset()
        end
        if player1Score == 10 or player2Score == 10 then
            GAME_STATE = "end"
        end

    end
    ball:update(dt)

    love.keyboard.keysPressed = {}
end ]]

function love.draw()
    push:start()
    love.graphics.setColor(0,1,0)

    for i,v in ipairs(layers) do
        v:render()
    end

--[[     if GAME_STATE == "start" then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Press Enter to start!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif GAME_STATE == "serve" then
        love.graphics.setFont(largeFont)
	love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
	love.graphics.printf(player1Score, 0, 20, VIRTUAL_WIDTH, 'left')
	love.graphics.printf(player2Score, 0, 20, VIRTUAL_WIDTH, 'right')
    elseif GAME_STATE == "play" then
	love.graphics.setFont(largeFont)
	love.graphics.printf('Play!', 0, 20, VIRTUAL_WIDTH, 'center')
	love.graphics.printf(player1Score, 0, 20, VIRTUAL_WIDTH, 'left')
	love.graphics.printf(player2Score, 0, 20, VIRTUAL_WIDTH, 'right')
    elseif GAME_STATE == "end" then
	love.graphics.setFont(largeFont)
	if player1Score > player2Score then
	    love.graphics.printf('Player 1 wins!', 0, 20, VIRTUAL_WIDTH, 'center')
	else
	    love.graphics.printf('Player 2 wins!', 0, 20, VIRTUAL_WIDTH, 'center')
	end
	love.graphics.printf(player1Score, 0, 20, VIRTUAL_WIDTH, 'left')
	love.graphics.printf(player2Score, 0, 20, VIRTUAL_WIDTH, 'right')
    end]]

    push:finish()
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end