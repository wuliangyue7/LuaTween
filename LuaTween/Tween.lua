local easing = require("LuaTween.Easing")
local Tween = {};

Tween.TweenStat =
{
    None=0,
    Update = 1,
    Complete = 2,
};

--param = {
--    startVal=0, 
--    endVal=100, 
--    time=3, 
--    easing=func, 
--    backward=false, 
--    startHandler=handler, 
--    startArg = arg,
--    updateHandler=handler,
--    updateArg = arg, 
--    completeHandler = handler,
--    completeArg = arg
--};
function Tween.new(param)
    if not param then
        print("Tween.new with nil param");
    end

    local t = {};
    t.startVal = param.startVal;
    t.endVal = param.endVal;
    t.time = param.time;
    t.easing = param.easing or easing.linear;
    t.backward = param.backward or false;
    t.startHandler = param.startHandler;
    t.startArg = param.startArg;
    t.updateHandler = param.updateHandler;
    t.updateArg = param.updateArg;
    t.completeHandler = param.completeHandler;
    t.completeArg = param.completeArg;

    setmetatable(t, Tween);
    Tween.__index = Tween;
    t:Reset();
    return t;
end

function Tween:Reset()
    self.elapsed = 0;
    self.tweenStat = Tween.TweenStat.None;
    self.isStop = true;
end

function Tween:GetTweenStat()
    return self.tweenStat;
end

function Tween:Update(dt)
--    if self.isStop then
--        return;
--    end

    if self.tweenStat ==  Tween.TweenStat.Complete then
            print("Tween:Update alreay Completed");
        return;
    end

    if self.tweenStat ==  Tween.TweenStat.None then
       self:CallBack(self.startHandler, self.startArg);
        self.tweenStat =  Tween.TweenStat.Update;
    end

    local isComplete = false;
    self.elapsed = self.elapsed + dt;
    self.elapsed = (self.elapsed > self.time and self.time) or self.elapsed;
    local progress = 0; 
    if not self.backward then
        progress = self.easing(self.elapsed, self.startVal, self.endVal-self.startVal, self.time);
    else
        progress = self.easing(self.time-self.elapsed, self.startVal, self.endVal-self.startVal, self.time);
    end

    if self.updateHandler then
        self.updateHandler(progress, self.updateArg);
    end

    if self.elapsed == self.time then
        self.tweenStat =  Tween.TweenStat.Complete;
        self:CallBack(self.completeHandler, self.completeArg);
    end
end

function Tween:CallBack(handler, arg)
    if handler then
        handler(arg);
    end
end

return Tween;