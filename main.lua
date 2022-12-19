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
    love.graphics.setFont(smallFont)

    numDiscs = 6
    layers = {}

    rod1 = {}
    rod2 = {}
    rod3 = {}
    
    for i=0,numDiscs,1 do
        layers[i] = Layer(200, 650-(numDiscs*30)+30*i, 75+25*i, 50, 10)
        rod1[i] = i
        rod2[i] = nil
        rod3[i] = nil
    end

end

function love.update(dt)
    if GAME_STATE == "start" then
        if love.keyboard.wasPressed('return') then
            GAME_STATE = "play"
        end
        score = 0
    elseif GAME_STATE == "play" then
        a = "a"
        end

        flag = true
        for i=0,numDiscs,1 do
            if rod3[i] ~= i then
                flag = false
            end
        end
        if flag then
            GAME_STATE = "end"
        end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    love.graphics.setColor(0,1,0)

    for i,v in ipairs(layers) do
        v:render()
    end

    if GAME_STATE == "end" then
        love.graphics.printf('Game Over', 0, 20, VIRTUAL_WIDTH, 'center')
    end
    push:finish()
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end