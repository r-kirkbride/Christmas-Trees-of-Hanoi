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
    GAME_STATE = "start"
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    love.graphics.setFont(scoreFont)

    numDiscs = 3
    layers = {}

    rod1 = {}
    rod2 = {}
    rod3 = {}

    moveLayer = false
    
    for i=0,numDiscs,1 do
        layers[i] = Layer(200, 500-(numDiscs*30)+60*i, 75+50*i, 75, 400)
        rod1[i] = i
        rod2[i] = false
        rod3[i] = false
    end

end

-- enables the console. Remove for release?
function love.conf(t)
	t.console = true
end

function love.update(dt)
    if GAME_STATE == "start" then
        if love.keyboard.wasPressed('return') then
            GAME_STATE = "play"
        end
        score = 0
    elseif GAME_STATE == "play" then
        empty = true
        if love.keyboard.isDown("1") then
            if love.keyboard.wasPressed("2") then
                targetX = 600
                for i,v in ipairs(rod1) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod2) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod1[tempI] = false
                            rod2[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod1[tempI] = false
                    rod2[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            elseif love.keyboard.wasPressed("3") then
                targetX = 1000
                for i,v in ipairs(rod1) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod3) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod1[tempI] = false
                            rod3[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod1[tempI] = false
                    rod3[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            end
        end
        if love.keyboard.isDown("2") then
            if love.keyboard.wasPressed("1") then
                targetX = 200
                for i,v in ipairs(rod2) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod1) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod2[tempI] = false
                            rod1[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod2[tempI] = false
                    rod1[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            elseif love.keyboard.wasPressed("3") then
                targetX = 1000
                for i,v in ipairs(rod2) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod3) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod2[tempI] = false
                            rod3[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod2[tempI] = false
                    rod3[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            end
        end
        if love.keyboard.isDown("3") then
            if love.keyboard.wasPressed("2") then
                targetX = 600
                for i,v in ipairs(rod3) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod2) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod3[tempI] = false
                            rod2[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod3[tempI] = false
                    rod2[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            elseif love.keyboard.wasPressed("1") then
                targetX = 200
                for i,v in ipairs(rod3) do
                    if v then
                        moveLayer = v
                        tempI = i
                        break
                    end
                end
                for i,v in ipairs(rod1) do
                    if v then
                        if layers[v].width > layers[moveLayer].width then
                            GAME_STATE = "move"
                            targetY = 500-(numDiscs*30)+60*(i-1)
                            rod3[tempI] = false
                            rod1[i-1] = moveLayer
                        end
                        empty = false
                        break
                    end
                end
                if empty then
                    GAME_STATE = "move"
                    rod3[tempI] = false
                    rod1[numDiscs] = moveLayer
                    targetY = 500-(numDiscs*30)+60*numDiscs
                end
            end
        end
    elseif GAME_STATE == "move" then
        if moveLayer then
            if layers[moveLayer].y > 150 and math.abs(layers[moveLayer].x - targetX ) > 1 then
                layers[moveLayer]:moveUp(dt)
            elseif math.abs(layers[moveLayer].x - targetX ) < 1 then
                if layers[moveLayer].y < targetY then
                layers[moveLayer]:moveDown(dt)
                else
                    score = score + 1
                    flag = true
                    for i=1,numDiscs,1 do
                        if rod3[i] ~= i then
                            flag = false
                        end
                    end
                    if flag then
                        GAME_STATE = "end"
                    else
                        GAME_STATE = "play"
                    end
                end
            elseif layers[moveLayer].x < targetX then
                layers[moveLayer]:moveRight(dt)
            elseif layers[moveLayer].x > targetX then
                layers[moveLayer]:moveLeft(dt)
            end
        end
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    love.graphics.setColor(0.4,0.18,0)
    love.graphics.rectangle("fill", 190, 200, 20, 500, 10, 10)
    love.graphics.rectangle("fill", 590, 200, 20, 500, 10, 10)
    love.graphics.rectangle("fill", 990, 200, 20, 500, 10, 10)

    love.graphics.setColor(0,1,0)

    for i,v in ipairs(layers) do
         v:render()
    end
    if GAME_STATE == "start" then
        love.graphics.printf('Press enter to start', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif GAME_STATE == "play" or GAME_STATE == "move" then
        love.graphics.printf(score, 0, 20, VIRTUAL_WIDTH, "center")
    elseif GAME_STATE == "end" then
        love.graphics.printf('You did it! Score: ' .. score, 0, 20, VIRTUAL_WIDTH, 'center')
    end


    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end