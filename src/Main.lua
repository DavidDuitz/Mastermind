-- Mastermind

PINK = 1
WHITE = 2
ORANGE = 3
YELLOW = 4
GREEN = 5
PURPLE = 6
RED = 8
NUM_ROWS = 12
NUM_COLS = 5
BORDER = 75
SIZE = 55
PEG_RADIUS = 15
RADIUS = 30
var1 = 0
GAMEOVER = false

function setup()
    displayMode(STANDARD)
    board = Board(NUM_ROWS, NUM_COLS, SIZE, BORDER)
    button = Button("Go", 480, 400, 70, 50)

    pegsRed = {}
    pegsWhite = {}
    pieces = {}
    for r = 1, NUM_ROWS do
        pegsRed[r] = Peg(PEG_RADIUS, RED, Location(r, 1))
        pegsWhite[r] = Peg(PEG_RADIUS, WHITE, Location(r, 1))
        pieces[r] = {}
        for c = 2, NUM_COLS do
            pieces[r][c] = Piece(RADIUS, GRAY, Location(r, c))
        end
    end

    pieces2 = {}
    for r = 1, NUM_ROWS do
        pieces2[r] = {}
        for c = 1, NUM_COLS do
            pieces2[r][c] = nil
        end
    end
    c = math.random(1, 6)
    d = math.random(1, 6)
    e = math.random(1, 6)
    f = math.random(1, 6)
    pieces2[1][2] = Piece(RADIUS, c, Location(-1/10, 2))
    pieces2[1][3] = Piece(RADIUS, d, Location(-1/10, 3))
    pieces2[1][4] = Piece(RADIUS, e, Location(-1/10, 4))
    pieces2[1][5] = Piece(RADIUS, f, Location(-1/10, 5))

end


function draw()
    background(200)
    fill(0)
    font("Baskerville-Bold")
    fontSize(40)
    text("Mastermind", 530, 720)

    ellipseMode(CENTER)
    noStroke()
    fill(255, 0, 106)
    ellipse(480, 300, 30)
    fill(255, 123, 0)
    ellipse(480, 260, 30)
    fill(68, 216, 25)
    ellipse(480, 220, 30)
    fill(255)
    ellipse(520, 300, 30)
    fill(182, 13, 228)
    ellipse(520, 260, 30)
    fill(247, 245, 25)
    ellipse(520, 220, 30)

    board:draw()
    for r = 1, NUM_ROWS do
        for c = 1, NUM_COLS do
            if ( pieces[r][c] ~= nil ) then
                pieces[r][c]:draw()
            end
        end
    end

    for r = 1, NUM_ROWS do
        for c = 1, NUM_COLS do
            if ( pieces2[r][c] ~= nil ) then
                pieces2[r][c]:draw()
            end
        end
    end


    if (GAMEOVER == true) then
        fill(0, 4, 255)
        rect(528, 600, 200, 80)
        textMode(CENTER)
        fill(233, 7, 7)
        font("AmericanTypewriter-Bold")
        fontSize(35)
        text("You Win!", 530, 600)
        youWin = true
    else
        youWin = false
    end


    if (youWin == false and youLose == false) then
        rectMode(CENTER)
        noStroke()
        fill (255, 236, 0)
        rect(240, 720, 200, 50)
    end

    if (var1 >= 12 and
    boardFull() == true and
    GAMEOVER == false) then
        fill(0, 4, 255)
        rect(528, 490, 200, 80)
        textMode(CENTER)
        fill(233, 7, 7)
        font("AmericanTypewriter-Bold")
        fontSize(35)
        text("You Lose", 530, 490)
        youLose = true
    else
        youLose = false
    end

    button:draw()

    for i = 12, 1, -1 do
        local v = NUM_ROWS - i + 1
        if (rowFull(i) == true) then
            if (var1 >= v) then
                if (rightColorRightPlace(i) == 1) then
                    pegsRed[i]:drawTL()
                elseif(rightColorRightPlace(i) == 2) then
                    pegsRed[i]:drawTL()
                    pegsRed[i]:drawTR()
                elseif(rightColorRightPlace(i) == 3) then
                    pegsRed[i]:drawTL()
                    pegsRed[i]:drawTR()
                    pegsRed[i]:drawBL()
                end
            end
        end
    end

    for i = 12, 1, -1 do
        local v = NUM_ROWS - i + 1

        if (rowFull(i) == true) then
            if (var1 >= v) then
                if (rightColorWrongPlace(i) == 1) then
                    pegsWhite[i]:drawBR()
                elseif(rightColorWrongPlace(i) == 2) then
                    pegsWhite[i]:drawBR()
                    pegsWhite[i]:drawBL()
                elseif(rightColorWrongPlace(i) == 3) then
                    pegsWhite[i]:drawBR()
                    pegsWhite[i]:drawBL()
                    pegsWhite[i]:drawTR()
                elseif(rightColorWrongPlace(i) == 4) then
                    pegsWhite[i]:drawBR()
                    pegsWhite[i]:drawBL()
                    pegsWhite[i]:drawTR()
                    pegsWhite[i]:drawTL()
                end
            end
        end
    end

    if (var1 >= 1 and var1 <= NUM_ROWS) then
        rectMode(CENTER)
        fill(0, 255, 0)
        noStroke()
        for i = 1, var1 do
            rect(380, 60 + (i - 1) * SIZE, 40, 40)
        end
    end

end


function touched(touch)

    button:touched(touch)
    if (touch.state == BEGAN) then
        if (button.colorState == 2)then
            var1 = var1 + 1
        end
    end

    for i = 1, 12 do
        if (button.colorState == 2 and
        pieces[i][2]:getColor() == pieces2[1][2]:getColor() and
        pieces[i][3]:getColor() == pieces2[1][3]:getColor() and
        pieces[i][4]:getColor() == pieces2[1][4]:getColor() and
        pieces[i][5]:getColor() == pieces2[1][5]:getColor()) then
            GAMEOVER = true
        end
    end

    if (touch.state == BEGAN and
    xyToLoc(touch.x, touch.y, board ~= nil)) then
        loc = xyToLoc(touch.x, touch.y, board)
        row = loc:getRow()
        col = loc:getCol()
        --print(row)
        --print(col)
        if (pieces[row][col] ~= nil) then
            local x, y = locToXY(Location(row,col), board)
            if (pieces[row][col]:getColor() == GRAY) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = PINK
                    end
                end
            elseif (pieces[row][col]:getColor() == PINK) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = ORANGE
                    end
                end
            elseif (pieces[row][col]:getColor() == ORANGE) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = GREEN
                    end
                end
            elseif (pieces[row][col]:getColor() == GREEN) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = WHITE
                    end
                end
            elseif (pieces[row][col]:getColor() == WHITE) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = PURPLE
                    end
                end
            elseif (pieces[row][col]:getColor() == PURPLE) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = YELLOW
                    end
                end
            elseif (pieces[row][col]:getColor() == YELLOW) then
                if (touch.state == BEGAN) then
                    if (touch.x >= x-SIZE/2 and
                    touch.x <= x+SIZE/2 and
                    touch.y >= y-SIZE/2 and
                    touch.y <= y+SIZE/2) then
                        pieces[row][col].color = GRAY
                    end
                end
            end
        end
    end


end



-- convert a location on the board to x,y pixel values
function locToXY(loc)
    local border = BORDER
    local size = SIZE
    local r = loc:getRow()
    local c = loc:getCol()
    local x = border + (c - 0.5)*size
    local y = HEIGHT - border - (r - 0.5)*size
    return x, y
end

-- convert a x, y pixel values to a location on the board
function xyToLoc(x, y, board)
    local brdr = BORDER
    local sz = SIZE
    local nr = NUM_ROWS
    local nc = NUM_COLS
    if ( x < brdr or (x > brdr + nc * sz) or
    y > (HEIGHT - brdr) or
    y < (HEIGHT - brdr - nr * sz) ) then
        return nil -- x,y not on board
    end
    for r = 1, nr do
        for c = 1, nc do
            if ( x > (brdr + (c - 1)*sz) and
            x < (brdr + c*sz) and
            y < (HEIGHT - brdr - (r - 1)*sz) and
            y > (HEIGHT - brdr - r*sz) ) then
                return Location(r, c)
            end
        end
    end
end


function rightColorRightPlace(r)
    count = 0
    for c = 2, 5 do
        if (pieces[r][c]:getColor() == pieces2[1][c]:getColor()) then
            count = count + 1
        end
    end
    return count
end


function rightColorWrongPlace(r)
    whiteCount = 0
    codePieces = ArrayList(4)
    codePieces:add( Piece(RADIUS, c, Location(-1/10, 2)) )
    codePieces:add( Piece(RADIUS, d, Location(-1/10, 3)) )
    codePieces:add( Piece(RADIUS, e, Location(-1/10, 4)) )
    codePieces:add( Piece(RADIUS, f, Location(-1/10, 5)) )

    piecesRed = ArrayList(4)
    piecesRed:add( Piece(RADIUS, pieces[r][2]:getColor(), Location(r, 2)))
    piecesRed:add( Piece(RADIUS, pieces[r][3]:getColor(), Location(r, 3)))
    piecesRed:add( Piece(RADIUS, pieces[r][4]:getColor(), Location(r, 4)))
    piecesRed:add( Piece(RADIUS, pieces[r][5]:getColor(), Location(r, 5)))
    for c = 2, 5 do
        if (pieces[r][c]:getColor() == pieces2[1][c]:getColor()) then
            piecesRed:set(c - 1, 0)
            codePieces:set(c - 1, 0)
        end
    end

    for guessCol = 2, NUM_COLS do
        for codeCol = 2, NUM_COLS do
            if (piecesRed:get(guessCol - 1) ~= 0 and
            codePieces:get(codeCol - 1) ~= 0 and
            pieces[r][guessCol]:getColor() == codePieces:get(codeCol - 1):getColor()) then
                piecesRed:set(guessCol - 1, 0)
                codePieces:set(codeCol - 1, 0)
                whiteCount = whiteCount + 1
            end
        end
    end

    return whiteCount
end


function rowFull(r)
    if (pieces[r][2]:getColor() ~= GRAY and
    pieces[r][3]:getColor() ~= GRAY and
    pieces[r][4]:getColor() ~= GRAY and
    pieces[r][5]:getColor() ~= GRAY) then
        return true
    else
        return false
    end
end


function boardFull()
    if (pieces[1][2]:getColor() ~= GRAY and
    pieces[1][3]:getColor() ~= GRAY and
    pieces[1][4]:getColor() ~= GRAY and
    pieces[1][5]:getColor() ~= GRAY) then
        return true
    else
        return false
    end
end
