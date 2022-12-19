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
    self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.speed *dt)
end

function Layer:moveLeft(dt)
    self.x = math.max(0, self.x - self.speed * dt)
end

function Layer:moveRight(dt)
    self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.speed * dt)
end

function Layer:render()
    --vertices = {self.x-self.width*0.25,self.y, self.x-self.width*0.5,self.y, self.x-self.width*0.375,self.y-self.height*0.5, self.x+self.width*0.375,self.y-self.height*0.5, self.x+self.width*0.5,self.y, self.x+self.width*0.25,self.y, self.x+self.width*0.375,self.y+self.height*0.5, self.x-self.width*0.375,self.y+self.height*0.5}
    vertices = {self.x-self.width*0.5,self.y, self.x-self.width*0.5+35,self.y-self.height*0.5, self.x+self.width*0.5-35,self.y-self.height*0.5, self.x+self.width*0.5,self.y}
    love.graphics.polygon('fill', vertices)
end