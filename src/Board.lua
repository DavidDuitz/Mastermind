Board = class()

function Board:init(nr, nc, sz, brdr)
    self.nr = nr
    self.nc = nc
    self.sz = sz
    self.brdr = brdr
end

function Board:getNumRows()
    return self.nr
end

function Board:getNumCols()
    return self.nc
end

function Board:getSize()
    return self.sz
end

function Board:getBorder()
    return self.brdr
end

function Board:draw()
    noStroke()
    rectMode(CENTER)
    for r = 1, self.nr do
        for c = 1, self.nc do
            local x, y = locToXY(Location(r, c), self)
            fill(100)
            rect(x, y, self.sz, self.sz)
        end
    end
end
