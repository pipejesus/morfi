local tween = require('tween')
Rows = 5
Cols = 5
DrawStartX, DrawStartY = 100, 100
SquareWidth, SquareHeight = 50, 50
CurrentFrame = 1
TimePassed = 0

OldPlayaX = 0
OldPlayaY = 0

Playaz = { 'a', 'b', 'c', 'd', 'e', 'f'}
Frames = {
  {
    ' ', ' ', 'f', ' ', ' ', 
    ' ', 'a', 'e', ' ', ' ', 
    ' ', 'b', ' ', ' ', ' ', 
    ' ', 'c', ' ', ' ', ' ', 
    ' ', 'd', ' ', ' ', ' ',   
  },
  {
    ' ', ' ', ' ', ' ', ' ', 
    'f', 'e', 'e', ' ', ' ', 
    ' ', ' ', 'a', 'b', ' ', 
    ' ', ' ', ' ', 'c', ' ', 
    ' ', ' ', ' ', 'd', ' ',   
  },
}

function love.load()
  OldPlayaX, OldPlayaY = GetPlayaPositionCalculated('a', Frames[1])  
end

function love.update(dt) 
  HandleTimePassed(dt)
end

function HandleTimePassed(dt)
  TimePassed = TimePassed + dt    
  if TimePassed >= 2 then
    TimePassed = TimePassed - 2
    SwitchToNextFrame()
  end  
end

function SwitchToNextFrame()
  local tempFrame = CurrentFrame + 1  
  tempFrame = CurrentFrame % #Frames
  CurrentFrame = tempFrame + 1
end

function love.draw()
  DrawAllSquares()
end

function GetPlayaPosition(playaName, frame)
  local x, y, i = nil, nil, nil
  for idx, val in ipairs(frame) do
    if val == playaName then
      i = idx
    end
  end  
  x = i % Cols
  y = math.floor(i / Rows)
  return x,y
end

function GetPlayaPositionCalculated(playa, frame)
  local x,y = GetPlayaPosition(playa, frame)
  local calcX = (x - 1 ) * SquareWidth  + DrawStartX
  local calcY = (y - 1 ) * SquareHeight + DrawStartY  
  return calcX, calcY
end

function DrawSquare(x, y)
end

function DrawAllSquares()
  local x,y = GetPlayaPositionCalculated('a', Frames[CurrentFrame])  
  love.graphics.setColor(0.4, 0.1, 0.23, 0.9)
  love.graphics.rectangle('fill', x, y, 50, 50)
end