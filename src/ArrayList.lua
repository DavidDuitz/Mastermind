ArrayList = class()
-- construct an ArrayList object
-- parameter n represents maximum number
-- of elements the object may hold
function ArrayList:init(n)
    self.arr = {}
    for i = 1, n do
        self.arr[i] = nil
    end
    self.sz = 0
end
-- returns the number of elements in the ArrayList object
function ArrayList:size()
    return self.sz
end
-- appends element e to the end of the list
-- returns true
function ArrayList:add(e)
    local nextIndex = self.sz + 1
    self.arr[nextIndex] = e
    self.sz = nextIndex
    return true
end
-- inserts e at position index
-- moves elements at position index and higher
-- to the right (adds 1 to their indices)
-- and adjusts size
function ArrayList:insert(index, e)
    if ( index >= 1 and index <= self.sz ) then
        for i = self.sz, index, -1 do
            self.arr[i+1] = self.arr[i]
        end
        self.arr[index] = e
        self.sz = self.sz + 1
    end
end

-- returns the element at position index
function ArrayList:get(index)
    if (index >= 1 and index <= self.sz) then
        return self.arr[index]
    else
        return nil
    end end
-- replaces the element at position index with e
-- returns the element formerly at the specified position
function ArrayList:set(index, e)
    local te = self.arr[index]
    self.arr[index] = e
    return te
end
-- removes element from position index
-- moves elements at position index + 1 and higher to the left
-- (i.e., subtracts one from their indices) and adjusts size
-- returns the element formerly at the specified position
function ArrayList:remove(index)
    local te = self.arr[index]
    for i = index + 1, self.sz do
        self.arr[i - 1] = self.arr[i]
    end
    self.sz = self.sz - 1
return te end
-- only use when the ArrayList is a list
-- of objects that belong to a class that
-- has defined a toString() function
function ArrayList:display()
    local str = "["
    for i = 1, self.sz do
        if ( self.arr[i] ~= nil ) then
            str = str .. self.arr[i]:toString()
        end
        if ( i < self.sz ) then
            str = str .. ", "
        end
    end
    str = str .. "]"
    print(str)
end
