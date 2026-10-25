Peg = class()

function Peg:init(radius, color, loc)
    self.radius = radius
    self.color = color
    self.loc = loc
end

function Peg:drawBL()
    ellipseMode(CENTER)
    noStroke()
    local x, y = locToXY(self.loc, self.board)
    if ( self.color == RED ) then
        fill(255, 0, 0)
    elseif(self.color == WHITE ) then
        fill(255)
    end
    ellipse(x - 12, y - 12, self.radius)
end

function Peg:drawBR()
    ellipseMode(CENTER)
    noStroke()
    local x, y = locToXY(self.loc, self.board)
    if ( self.color == RED ) then
        fill(255, 0, 0)
    elseif(self.color == WHITE ) then
        fill(255)
    end
    ellipse(x + 12, y - 12, self.radius)
end

function Peg:drawTL()
    ellipseMode(CENTER)
    noStroke()
    local x, y = locToXY(self.loc, self.board)
    if ( self.color == RED ) then
        fill(255, 0, 0)
    elseif(self.color == WHITE ) then
        fill(255)
    end
    ellipse(x - 12, y + 12, self.radius)
end

function Peg:drawTR()
    ellipseMode(CENTER)
    noStroke()
    local x, y = locToXY(self.loc, self.board)
    if ( self.color == RED ) then
        fill(255, 0, 0)
    elseif(self.color == WHITE ) then
        fill(255)
    end
    ellipse(x + 12, y + 12, self.radius)
end
