Piece = class()

function Piece:init(radius, color, loc)
    self.radius = radius
    self.color = color
    self.loc = loc
end

function Piece:draw()
    ellipseMode(CENTER)
    noStroke()
    local x, y = locToXY(self.loc, self.board)
    if ( self.color == PINK ) then
        fill(255, 0, 106)
    elseif ( self.color == WHITE ) then
        fill(255)
    elseif ( self.color == ORANGE ) then
        fill(255, 123, 0)
    elseif ( self.color == YELLOW ) then
        fill(247, 245, 25)
    elseif ( self.color == GREEN ) then
        fill(68, 216, 25)
    elseif ( self.color == PURPLE ) then
        fill(182, 13, 228)
    elseif (self.color == GRAY) then
        fill(100)
    end
    ellipse(x, y, self.radius)
end

function Piece:getLoc()
    return self.loc
end

function Piece:getColor()
    return self.color
end

function Piece:moveTo(r, c)
    self.loc = Location(r, c)
end
