local tween = require('tween')
local Playaz = require('playaz')
local Frames = require('frames')
local FramesInterval = 1                 -- 2 seconds
local PlayazEasing = tween.easing.inCirc
local PlayazTweenDuration = 0.04

Rows = 7
Cols = 5
DrawStartX, DrawStartY = 200, 200
SquareWidth, SquareHeight = 50, 50
CurrentFrame = 1
TimePassed = 0


function love.load()
  for playaName, playaDef in pairs(Playaz) do        
    Playaz[playaName].current.x, Playaz[playaName].current.y = GetPlayaPositionCalculated(playaName, Frames[CurrentFrame])
    Playaz[playaName].nextTarget.x, Playaz[playaName].nextTarget.y = Playaz[playaName].current.x, Playaz[playaName].current.y
    Playaz[playaName].t = tween.new(PlayazTweenDuration, Playaz[playaName].current, Playaz[playaName].nextTarget, PlayazEasing)
  end
end

function love.update(dt) 
  HandleTimePassedForFrames(dt)
  UpdatePlayazTweensTargets(dt)
  ProceedTweensInTime(dt)
end

function ProceedTweensInTime(dt)
  for playaName, playaDef in pairs(Playaz) do  
    Playaz[playaName].t:update(dt)
  end
end

function UpdatePlayazTweensTargets(dt)
  for playaName, playaDef in pairs(Playaz) do  
    Playaz[playaName].t = tween.new(PlayazTweenDuration, Playaz[playaName].current, Playaz[playaName].nextTarget, PlayazEasing)
  end
end

function HandleTimePassedForFrames(dt)
  TimePassed = TimePassed + dt    
  if TimePassed >= FramesInterval then
    TimePassed = TimePassed - FramesInterval
    SwitchToNextFrame()
    SwitchTweensToNextFrame()
  end
end

function SwitchTweensToNextFrame()
  for playaName, playaDef in pairs(Playaz) do    
    Playaz[playaName].nextTarget.x, Playaz[playaName].nextTarget.y = GetPlayaPositionCalculated(playaName, Frames[CurrentFrame])
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
  for yy, valY in ipairs(frame) do
    for xx, valX in ipairs(valY) do
      if playaName == frame[yy][xx] then
        x = xx
        y = yy
      end
    end
  end
  return x, y
end

function GetPlayaPositionCalculated(playa, frame)
  local x,y = GetPlayaPosition(playa, frame)
  local calcX = (x - 1) * SquareWidth  + DrawStartX
  local calcY = (y - 1) * SquareHeight + DrawStartY  
  return calcX, calcY
end

function DrawSquare(playaName, colors)  
  local x, y = Playaz[playaName].current.x, Playaz[playaName].current.y
  love.graphics.setColor(colors)
  love.graphics.rectangle('fill', x, y, SquareWidth, SquareHeight)
end

function DrawAllSquares()  
    DrawSquare('a', {0.4, 0.1, 0.23, 0.9})
    DrawSquare('b', {0.1, 0.3, 0.33, 0.9})  
    DrawSquare('c', {0.4, 0.0, 0.33, 0.9})  
    DrawSquare('d', {0.7, 0.5, 0.33, 0.9})  
    DrawSquare('e', {0.3, 0.7, 0.0, 0.9})  
    DrawSquare('f', {0.17, 0.7, 0.33, 0.9})
    DrawSquare('g', {0.93, 0.1, 0.33, 0.9})
    DrawSquare('h', {0.07, 0.57, 0.16, 0.9})
    DrawSquare('i', {0.43, 0.27, 0.46, 0.9})
end