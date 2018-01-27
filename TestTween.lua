print("test tween")
local function onTweenStart(param)
    print("onTweenStart", param);
end

local function onTweenUpdate(val, param)
    print("onTweenUpdate", val, param);
end

local function onTweenComplete(param)
    print("onTweenComplete", param);
end

local Tween = require("LuaTween.Tween");
local Easing = require("LuaTween.Easing");
local param = {
    startVal=0, 
    endVal=100, 
    time=3, 
    easing=Easing.inOutBounce, 
    backward=true, 
    startHandler=onTweenStart, 
    startArg = "start",
    updateHandler=onTweenUpdate,
    updateArg = "update", 
    completeHandler = onTweenComplete,
    completeArg = "complete"
};

local tweenIns = Tween.new(param);
local function testTweenFunc(tween)
    print("main..lua testtweenIns")
    print(tween:GetTweenStat());
    print("main..lua testtweenIns")
    while
        (tween:GetTweenStat() ~= Tween.TweenStat.Complete)
    do
        tween:Update(0.03);
    end
end

testTweenFunc(tweenIns);
