Layer = Class {}

-- gives layers the attributes it needs
function Layer:init(x, y, width, height, speed)
    self.x = x
    self.y = y

    self.width = width
    self.height = height

    self.speed = speed
end

function Layer:moveUp(dt)
    self.y = math.max(0, self.y - self.speed * dt)
end

function Layer:moveDown(dt)
    self.y = math.min(VIRTUAL_HEIGHT, self.y + self.speed *dt)
end

function Layer:moveLeft(dt)
    self.x = math.max(0, self.x - self.speed * dt)
end

function Layer:moveRight(dt)
    self.x = math.min(VIRTUAL_WIDTH, self.x + self.speed * dt)
end

function Layer:setXY(x,y)
    self.x = x
    self.y = y
end

function Layer:render()
    vertices = {}
    vertices[1],vertices[2] = self.x-self.width-self.height,self.y -- bottom left
    vertices[3],vertices[4] = self.x-self.width,self.y-self.height -- top left
    vertices[5],vertices[6] = self.x+self.width,self.y-self.height -- top right
    vertices[7],vertices[8] = self.x+self.width+self.height,self.y -- bottom right
    love.graphics.setColor(0,1,0)
    love.graphics.polygon('fill', vertices)
end