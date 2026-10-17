-- Mutant Lab V5 - Studio installer
-- Source: github.com/jakemathewpayne-arch/game
-- Run in Studio Command Bar in EDIT mode, not Play mode.
local WS=game:GetService("Workspace")
local RS=game:GetService("ReplicatedStorage")
local SS=game:GetService("ServerScriptService")
local SPS=game:GetService("StarterPlayer").StarterPlayerScripts
local Storage=game:GetService("ServerStorage")
local Lighting=game:GetService("Lighting")
local function remove(parent,name)
 local old=parent:FindFirstChild(name)
 if old then old:Destroy() end
end
local previous=Storage:FindFirstChild("MutantLabBackups") or Instance.new("Folder")
previous.Name="MutantLabBackups"
previous.Parent=Storage
for _,pair in ipairs({{SS,"MutantLabV4Server"},{SPS,"MutantLabV41Client"},{SPS,"MutantLabV4Client"},{SPS,"MutantLabCleanClient"},{SPS,"MutantLabPadInventory"},{SS,"MutantLabV3Server"}}) do
 local script=pair[1]:FindFirstChild(pair[2])
 if script then script.Enabled=false; script.Parent=previous end
end
remove(WS,"MutantLabV5World")
remove(RS,"MutantLabV5Net")
remove(SS,"MutantLabV5Server")
remove(SPS,"MutantLabV5Client")
local world=Instance.new("Model",WS);world.Name="MutantLabV5World"
local net=Instance.new("Folder",RS);net.Name="MutantLabV5Net"
for _,name in ipairs({"Action","State","Reveal","Notice","Pad"}) do
 local ev=Instance.new("RemoteEvent",net);ev.Name=name
end
local clr={floor=Color3.fromRGB(214,219,219),white=Color3.fromRGB(236,239,237),metal=Color3.fromRGB(123,139,140),dark=Color3.fromRGB(60,76,81),mint=Color3.fromRGB(100,168,142),gold=Color3.fromRGB(193,156,94)}
local O=Vector3.new(440,0,0)
local function block(name,size,offset,color,material,parent)
 local v=Instance.new("Part")
 v.Name=name;v.Size=size;v.Position=O+offset;v.Anchored=true
 v.Material=material or Enum.Material.SmoothPlastic
 v.Color=color;v.TopSurface=Enum.SurfaceType.Smooth;v.BottomSurface=Enum.SurfaceType.Smooth
 v.Parent=parent or world
 return v
end
local function prompt(p,action)
 local pr=Instance.new("ProximityPrompt");pr.ActionText=action;pr.ObjectText="Mutant Lab"
 pr.HoldDuration=0;pr.MaxActivationDistance=14;pr.RequiresLineOfSight=false;pr.Parent=p
end
local function sign(part,title)
 local g=Instance.new("BillboardGui");g.Size=UDim2.fromOffset(120,32);g.StudsOffset=Vector3.new(0,2.5,0)
 g.MaxDistance=40;g.AlwaysOnTop=true;g.Parent=part
 local t=Instance.new("TextLabel");t.Size=UDim2.fromScale(1,1);t.BackgroundColor3=clr.white
 t.TextColor3=clr.dark;t.Text=title;t.TextScaled=true;t.Font=Enum.Font.GothamBold;t.Parent=g
 Instance.new("UICorner",t).CornerRadius=UDim.new(0,6)
end
block("Floor",Vector3.new(100,2,94),Vector3.new(0,-1,0),clr.floor)
block("Back Wall",Vector3.new(100,16,2),Vector3.new(0,8,47),clr.white)
for _,x in ipairs({-49,49}) do block("Side Wall",Vector3.new(2,12,94),Vector3.new(x,6,0),clr.white) end
local spawn=Instance.new("SpawnLocation",world);spawn.Name="MutantLabV5Spawn";spawn.Size=Vector3.new(8,1,8)
spawn.Position=O+Vector3.new(0,1,-36);spawn.Anchored=true;spawn.Neutral=true;spawn.Duration=0;spawn.Color=clr.mint
for _,v in ipairs(WS:GetDescendants()) do if v:IsA("SpawnLocation") and v~=spawn then v.Enabled=false end end
local machine=Instance.new("Model",world);machine.Name="RollMachine"
block("Housing",Vector3.new(15,11,4),Vector3.new(0,7,-7),clr.dark,Enum.Material.Metal,machine)
block("Base",Vector3.new(17,2,15),Vector3.new(0,1,-10),clr.metal,Enum.Material.DiamondPlate,machine)
local glass=block("Glass Chamber",Vector3.new(11,9,10),Vector3.new(0,7,-10),clr.white,Enum.Material.Glass,machine)
glass.Transparency=0.8;glass.CanCollide=false
local light=Instance.new("PointLight",glass);light.Color=clr.mint;light.Brightness=0.6;light.Range=14
for _,dx in ipairs({-5.5,5.5}) do
 for _,dz in ipairs({-5,5}) do
 block("Support",Vector3.new(.7,10,.7),Vector3.new(dx,7,dz-10),clr.metal,Enum.Material.Metal,machine)
 end
end
local roll=block("Roll Control",Vector3.new(6,1,3),Vector3.new(0,2.5,-19),clr.mint,Enum.Material.SmoothPlastic,machine)
prompt(roll,"ROLL");sign(roll,"ROLL MUTANT")
local pads=Instance.new("Folder",world);pads.Name="Pads"
for i=1,10 do
 local x=17+math.floor((i-1)/5)*15
 local z=-25+((i-1)%5)*15
 local model=Instance.new("Model",pads);model.Name="Pad"..i
 local pedestal=block("Pedestal",Vector3.new(11,1.7,11),Vector3.new(x,.85,z),clr.metal,Enum.Material.Concrete,model)
 local top=block("Top",Vector3.new(9,.35,9),Vector3.new(x,1.85,z),clr.mint,Enum.Material.SmoothPlastic,model)
 local control=block("Control",Vector3.new(5,.7,2.5),Vector3.new(x,2.2,z-6),clr.dark,Enum.Material.Metal,model)
 prompt(control,"PLACE / REMOVE");if i<=4 then sign(control,"PAD "..i) end
end
local collector=Instance.new("Model",world);collector.Name="Collector"
block("Collector Base",Vector3.new(11,2,10),Vector3.new(-28,1,0),clr.metal,Enum.Material.DiamondPlate,collector)
block("Collector Body",Vector3.new(7,5,7),Vector3.new(-28,4.5,0),clr.dark,Enum.Material.Metal,collector)
local collect=block("Collect Control",Vector3.new(6,1,3),Vector3.new(-28,2.5,-6),clr.mint,nil,collector)
prompt(collect,"COLLECT CASH");sign(collect,"COLLECT CASH")
local upgrades=Instance.new("Folder",world);upgrades.Name="Upgrades"
for _,data in ipairs({{"Luck",-33,32},{"Rolls",-16,32},{"Rebirth",1,32}}) do
 local m=Instance.new("Model",upgrades);m.Name=data[1]
 block("Body",Vector3.new(10,7,9),Vector3.new(data[2],4.5,data[3]),clr.metal,Enum.Material.Metal,m)
 local b=block("Control",Vector3.new(6,1,3),Vector3.new(data[2],2,data[3]-6),data[1]=="Rebirth" and clr.gold or clr.mint,nil,m)
 prompt(b,"UPGRADE");sign(b,data[1]:upper())
end
Lighting.ClockTime=13;Lighting.Brightness=2
local server=Instance.new("Script");server.Name="MutantLabV5Server";server.Source=[==[
local P=game:GetService("Players")
local DS=game:GetService("DataStoreService")
local net=game.ReplicatedStorage:WaitForChild("MutantLabV5Net")
local world=workspace:WaitForChild("MutantLabV5World")
local store=DS:GetDataStore("MutantLabV5_1")
local types={
 {name="Slime",cost=50,rate=5,weight=48},
 {name="Toxic Frog",cost=180,rate=15,weight=27},
 {name="Crystal Beast",cost=650,rate=55,weight=15},
 {name="Shadow Mutant",cost=2500,rate=200,weight=7},
 {name="Omega Dragon",cost=12000,rate=900,weight=2.7},
 {name="Void Titan",cost=100000,rate=7000,weight=.3}
}
local users={};local saves={};local throttle={}
local function fresh() return {Cash=400,Bank=0,Rebirths=0,Luck=0,RollCount=1,Owned={},Placed={},Offer={}} end
local function slots(d)return math.min(10,4+2*d.Rebirths)end
local function income(d)local n=0;for _,v in pairs(d.Placed)do if types[v]then n+=types[v].rate end end;return n end
local function sync(p)
 local d=users[p];if not d then return end
 net.State:FireClient(p,{Cash=d.Cash,Bank=math.floor(d.Bank),Income=income(d),Rebirths=d.Rebirths,Slots=slots(d),Luck=d.Luck,RollCount=d.RollCount,Owned=d.Owned,Placed=d.Placed,Offer=d.Offer,RollCost=50*d.RollCount,LuckCost=math.floor(300*2^d.Luck),RollUpgradeCost=d.RollCount*600,RebirthCost=25000*3^d.Rebirths})
 local ls=p:FindFirstChild("leaderstats")
 if ls then ls.Cash.Value=math.floor(d.Cash);ls.Rebirths.Value=d.Rebirths end
end
local function tell(p,s)net.Notice:FireClient(p,s)end
local function limit(p,key,interval)
 throttle[p]=throttle[p] or {};local now=os.clock()
 if now-(throttle[p][key] or -999)<interval then return true end
 throttle[p][key]=now;return false
end
local function pick(luck)
 local sum=0;local cum={}
 for i,m in ipairs(types)do
 local w=m.weight*(i>=3 and (1+.4*luck) or 1/(1+.2*luck))
 sum+=w;cum[i]=sum
 end
 local v=math.random()*sum
 for i,w in ipairs(cum)do if v<=w then return i end end
 return 1
end
local function roll(p)
 local d=users[p];if not d or limit(p,"roll",1.5)then return end
 if #d.Offer>0 then tell(p,"Buy or skip your previous roll.")return end
 local cost=50*d.RollCount
 if d.Cash<cost then tell(p,"You need $"..cost.." to roll.")return end
 d.Cash-=cost
 for i=1,d.RollCount do table.insert(d.Offer,pick(d.Luck))end
 sync(p);net.Reveal:FireClient(p,table.clone(d.Offer))
end
local function buy(p,pos)
 local d=users[p];if not d or type(pos)~="number" or pos%1~=0 then return end
 local id=d.Offer[pos];local m=types[id or 0]
 if not m then return end
 if d.Cash<m.cost then tell(p,"Need $"..m.cost.." to buy "..m.name)return end
 d.Cash-=m.cost;d.Owned[tostring(id)]=(d.Owned[tostring(id)] or 0)+1
 table.remove(d.Offer,pos);sync(p);tell(p,"Bought "..m.name.."! Equip it from the bottom hotbar.")
end
local function place(p,slot,id)
 local d=users[p]
 if not d or type(slot)~="number" or slot%1~=0 or slot<1 or slot>slots(d) or not types[id] then return end
 local key=tostring(slot);local owned=tostring(id)
 if (d.Owned[owned] or 0)<1 then return end
 local former=d.Placed[key]
 if former then d.Owned[tostring(former)]=(d.Owned[tostring(former)] or 0)+1 end
 d.Owned[owned]-=1;d.Placed[key]=id;sync(p)
 tell(p,"Placed "..types[id].name.."! Collect its cash nearby.")
end
local function remove(p,slot)
 local d=users[p]
 if not d or type(slot)~="number" or slot%1~=0 or slot<1 or slot>slots(d) then return end
 local key=tostring(slot);local id=d.Placed[key];if not id then return end
 d.Owned[tostring(id)]=(d.Owned[tostring(id)] or 0)+1;d.Placed[key]=nil;sync(p)
end
local function collect(p)
 local d=users[p];if not d or limit(p,"collect",.3)then return end
 local sum=math.floor(d.Bank);if sum<1 then return end
 d.Bank-=sum;d.Cash+=sum;sync(p);tell(p,"Collected $"..sum)
end
local function upgrade(p,kind)
 local d=users[p];if not d or limit(p,"upgrade",.4)then return end
 local cost
 if kind=="Luck" then
 if d.Luck>=15 then return end;cost=math.floor(300*2^d.Luck)
 if d.Cash>=cost then d.Cash-=cost;d.Luck+=1 else tell(p,"Need $"..cost)end
 elseif kind=="Rolls" then
 if d.RollCount>=5 then return end;cost=d.RollCount*600
 if d.Cash>=cost then d.Cash-=cost;d.RollCount+=1 else tell(p,"Need $"..cost)end
 elseif kind=="Rebirth" then
 if d.Rebirths>=3 then return end;cost=25000*3^d.Rebirths
 if d.Cash>=cost then
 d.Rebirths+=1;d.Cash=400;d.Bank=0;d.Placed={};d.Owned={};d.Offer={}
 tell(p,"Rebirth! Two new pads unlocked.")
 else tell(p,"Need $"..cost)end
 end
 sync(p)
end
net.Action.OnServerEvent:Connect(function(p,kind,a,b)
 if kind=="Get" then sync(p)
 elseif kind=="Roll" then roll(p)
 elseif kind=="Buy" then buy(p,a)
 elseif kind=="Skip" then local d=users[p];if d then d.Offer={};sync(p)end
 elseif kind=="Place" then place(p,a,b)
 elseif kind=="Remove" then remove(p,a)
 elseif kind=="Collect" then collect(p)
 elseif kind=="Upgrade" then upgrade(p,a)end
end)
world.RollMachine["Roll Control"].ProximityPrompt.Triggered:Connect(roll)
world.Collector["Collect Control"].ProximityPrompt.Triggered:Connect(collect)
for _,m in ipairs(world.Upgrades:GetChildren())do
 m.Control.ProximityPrompt.Triggered:Connect(function(p)upgrade(p,m.Name)end)
end
for i=1,10 do
 world.Pads["Pad"..i].Control.ProximityPrompt.Triggered:Connect(function(p)net.Pad:FireClient(p,i)end)
end
local function save(p)
 local d=users[p];if not d or not saves[p] then return end
 local payload={Cash=d.Cash,Bank=d.Bank,Rebirths=d.Rebirths,Luck=d.Luck,RollCount=d.RollCount,Owned=d.Owned,Placed=d.Placed,Offer=d.Offer}
 local ok,err=pcall(function()store:UpdateAsync("U"..p.UserId,function()return payload end)end)
 if not ok then warn("Mutant Lab save error:",err)end
end
P.PlayerAdded:Connect(function(p)
 local ls=Instance.new("Folder",p);ls.Name="leaderstats"
 for _,n in ipairs({"Cash","Rebirths"})do local v=Instance.new("IntValue",ls);v.Name=n end
 local d=fresh()
 local ok,loaded=pcall(function()return store:GetAsync("U"..p.UserId)end)
 saves[p]=ok
 if ok and type(loaded)=="table" then
 for _,k in ipairs({"Cash","Bank","Rebirths","Luck","RollCount"})do
 if type(loaded[k])=="number" and loaded[k]>=0 and loaded[k]<1e13 then d[k]=math.floor(loaded[k])end end
 for _,k in ipairs({"Owned","Placed","Offer"})do if type(loaded[k])=="table"then d[k]=loaded[k]end end
 d.Rebirths=math.clamp(d.Rebirths,0,3);d.Luck=math.clamp(d.Luck,0,15);d.RollCount=math.clamp(d.RollCount,1,5)
 else if not ok then warn("Mutant Lab load failed; saving disabled this session for",p.Name)end end
 users[p]=d;p.RespawnLocation=world.MutantLabV5Spawn;sync(p)
end)
P.PlayerRemoving:Connect(function(p)save(p);users[p]=nil;saves[p]=nil;throttle[p]=nil end)
task.spawn(function()while task.wait(1)do for p,d in pairs(users)do d.Bank+=income(d);sync(p)end end end)
task.spawn(function()while task.wait(60)do for p in pairs(users)do save(p)end end end)
game:BindToClose(function()for p in pairs(users)do save(p)end end)
]==];server.Parent=SS
local client=Instance.new("LocalScript");client.Name="MutantLabV5Client";client.Source=[==[
local Players=game:GetService("Players")
local RS=game:GetService("ReplicatedStorage")
local SG=game:GetService("StarterGui")
local player=Players.LocalPlayer
local net=RS:WaitForChild("MutantLabV5Net")
local world=workspace:WaitForChild("MutantLabV5World")
local names={"Slime","Toxic Frog","Crystal Beast","Shadow Mutant","Omega Dragon","Void Titan"}
local prices={50,180,650,2500,12000,100000}
local rates={5,15,55,200,900,7000}
local colors={Color3.fromRGB(125,180,133),Color3.fromRGB(107,170,157),Color3.fromRGB(113,154,195),Color3.fromRGB(151,123,185),Color3.fromRGB(196,160,96),Color3.fromRGB(180,106,126)}
local gui=Instance.new("ScreenGui");gui.Name="MutantLabV5UI";gui.ResetOnSpawn=false;gui.Parent=player:WaitForChild("PlayerGui")
local function rounded(o)local c=Instance.new("UICorner",o);c.CornerRadius=UDim.new(0,9)end
local function frame(size,pos)
 local f=Instance.new("Frame");f.Size=size;f.Position=pos;f.BackgroundColor3=Color3.fromRGB(246,248,246);f.Parent=gui;rounded(f);return f
end
local function text(parent,value,size,pos,sz)
 local t=Instance.new("TextLabel");t.Size=size;t.Position=pos;t.BackgroundTransparency=1;t.Text=value;t.TextColor3=Color3.fromRGB(53,68,69);t.Font=Enum.Font.GothamBold;t.TextSize=sz or 15;t.TextWrapped=true;t.Parent=parent;return t
end
local function button(parent,title,size,pos,color)
 local b=Instance.new("TextButton");b.Size=size;b.Position=pos;b.Text=title;b.TextColor3=Color3.new(1,1,1);b.Font=Enum.Font.GothamBold;b.TextSize=15;b.BackgroundColor3=color or Color3.fromRGB(86,152,125);b.Parent=parent;rounded(b);return b
end
local hud=frame(UDim2.fromOffset(235,120),UDim2.fromOffset(10,10))
text(hud,"MUTANT LAB",UDim2.fromOffset(220,30),UDim2.fromOffset(10,6),21)
local cashText=text(hud,"Loading...",UDim2.fromOffset(220,84),UDim2.fromOffset(10,37),15)
local guide=frame(UDim2.fromOffset(420,47),UDim2.new(.5,-210,1,-59))
local tip=text(guide,"Press E at the ROLL machine.",UDim2.new(1,-12,1,0),UDim2.fromOffset(6,0),16)
tip.TextXAlignment=Enum.TextXAlignment.Center
local results=frame(UDim2.fromOffset(310,340),UDim2.new(1,-320,.5,-170));results.Visible=false
text(results,"YOUR ROLL",UDim2.fromOffset(280,32),UDim2.fromOffset(12,8),21)
local list=Instance.new("ScrollingFrame");list.Size=UDim2.new(1,-15,1,-105);list.Position=UDim2.fromOffset(8,44)
list.BackgroundTransparency=1;list.ScrollBarThickness=4;list.Parent=results
local layout=Instance.new("UIListLayout",list);layout.Padding=UDim.new(0,6)
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()list.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y+8)end)
local skip=button(results,"SKIP",UDim2.new(1,-16,0,39),UDim2.new(0,8,1,-47),Color3.fromRGB(120,125,130))
local function clear(p)for _,v in ipairs(p:GetChildren())do if v:IsA("GuiObject")then v:Destroy()end end end
local state;local busy=false;local hasRevealed=false
local preview=Instance.new("Folder",workspace);preview.Name="V5RollVisual"
local displays=Instance.new("Folder",workspace);displays.Name="V5DisplayVisual"
local function monster(id,pos,scale,parent)
 local model=Instance.new("Model",parent);model.Name=names[id]
 local function piece(name,offset,size,color,material,shape)
 local p=Instance.new("Part");p.Name=name;p.Size=size*scale;p.Position=pos+offset*scale;p.Anchored=true;p.CanCollide=false
 p.Material=material or Enum.Material.SmoothPlastic;p.Shape=shape or Enum.PartType.Ball;p.Color=color;p.Parent=model;return p end
 local base=piece("Body",Vector3.zero,Vector3.new(3.5,3.7,3.5),colors[id])
 for _,s in ipairs({-1,1})do
 piece("Eye",Vector3.new(s*.8,.45,-1.65),Vector3.new(.72,.8,.42),Color3.new(1,1,1))
 piece("Pupil",Vector3.new(s*.8,.45,-1.91),Vector3.new(.25,.32,.13),Color3.fromRGB(22,31,34))
 piece("Foot",Vector3.new(s*.8,-1.9,-.3),Vector3.new(1,1,1.5),colors[id])
 end
 if id>=3 then for _,s in ipairs({-1,1})do piece("Horn",Vector3.new(s,2,0),Vector3.new(.6,1.6,.7),colors[id],Enum.Material.Glass,Enum.PartType.Block)end end
 if id==5 then for _,s in ipairs({-1,1})do piece("Wing",Vector3.new(s*2.2,.2,.5),Vector3.new(.6,2.5,2),colors[id],nil,Enum.PartType.Block)end end
 return model
end
local function show(id)
 preview:ClearAllChildren()
 local chamber=world.RollMachine["Glass Chamber"]
 monster(id,chamber.Position+Vector3.new(0,0,-1),.8,preview)
end
local backpack=player:WaitForChild("Backpack")
pcall(function()SG:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,true)end)
local signature=""
local function equipped()
 local c=player.Character
 if not c then return nil end
 for _,tool in ipairs(c:GetChildren())do if tool:IsA("Tool") and tool:GetAttribute("MutantID") then return tool:GetAttribute("MutantID")end end
 return nil
end
local function inventory()
 if not state then return end
 local hash=""
 for i=1,#names do hash..=tostring(state.Owned[tostring(i)] or state.Owned[i] or 0).."," end
 if hash==signature then return end
 signature=hash
 local held=equipped()
 for _,parent in ipairs({backpack,player.Character})do
 if parent then for _,obj in ipairs(parent:GetChildren())do if obj:IsA("Tool") and obj:GetAttribute("MutantID") then obj:Destroy()end end end end
 for i,name in ipairs(names)do
 local count=state.Owned[tostring(i)] or state.Owned[i] or 0
 if count>0 then
 local t=Instance.new("Tool");t.RequiresHandle=false;t.CanBeDropped=false;t.Name=name..(count>1 and " x"..count or "")
 t.ToolTip="$"..rates[i].."/sec";t:SetAttribute("MutantID",i);t.Parent=backpack
 if i==held then task.defer(function()
 local hum=player.Character and player.Character:FindFirstChildOfClass("Humanoid")
 if hum and t.Parent then hum:EquipTool(t)end end)end
 end end
end
player.CharacterAdded:Connect(function()signature="";task.wait(.8);inventory()end)
local function redraw()
 displays:ClearAllChildren();if not state then return end
 for i=1,state.Slots do
 local id=state.Placed[tostring(i)]
 local pad=world.Pads:FindFirstChild("Pad"..i)
 if id and pad then monster(id,pad.Pedestal.Position+Vector3.new(0,4.5,0),.8,displays)end
 end
end
local function resultsUI()
 if not state or busy or not hasRevealed then return end
 clear(list);results.Visible=#state.Offer>0
 for i,id in ipairs(state.Offer)do
 local row=Instance.new("Frame");row.Size=UDim2.new(1,-8,0,100);row.BackgroundColor3=Color3.fromRGB(231,235,233);row.Parent=list;rounded(row)
 text(row,names[id],UDim2.new(1,-12,0,30),UDim2.fromOffset(6,4),17)
 text(row,"Buy $ "..prices[id].." | Earn $ "..rates[id].."/sec",UDim2.new(1,-12,0,22),UDim2.fromOffset(6,32),14)
 button(row,"BUY",UDim2.new(1,-12,0,35),UDim2.fromOffset(6,60)):MouseButton1Click:Connect(function()net.Action:FireServer("Buy",i)end)
 end
end
skip.MouseButton1Click:Connect(function()net.Action:FireServer("Skip");results.Visible=false;hasRevealed=false;preview:ClearAllChildren()end)
net.State.OnClientEvent:Connect(function(d)
 state=d
 cashText.Text="Cash: $"..d.Cash.."\nReady: $"..d.Bank.." | $"..d.Income.."/sec\nPads: "..d.Slots.." | Rebirths: "..d.Rebirths
 inventory();redraw();resultsUI()
end)
net.Notice.OnClientEvent:Connect(function(s)tip.Text=s end)
net.Pad.OnClientEvent:Connect(function(slot)
 if not state then return end
 if slot>state.Slots then tip.Text="Pad locked. Rebirth for more." return end
 local id=equipped()
 if id then net.Action:FireServer("Place",slot,id)
 elseif state.Placed[tostring(slot)] then net.Action:FireServer("Remove",slot)
 else tip.Text="Equip a mutant from the hotbar first." end
end)
net.Reveal.OnClientEvent:Connect(function(offers)
 if busy then return end
 busy=true;results.Visible=false
 for _,finalId in ipairs(offers)do
 tip.Text="Watch the roll machine..."
 for step=1,20 do
 show(math.random(1,#names))
 task.wait(.04+(step/20)^3*.21)
 end
 show(finalId);tip.Text="Rolled "..names[finalId].."!"
 task.wait(1.15)
 end
 busy=false;hasRevealed=true;resultsUI()
 tip.Text="Buy a mutant, or Skip."
end)
tip.Text="Step 1: Walk to ROLL and press E."
task.wait(1);net.Action:FireServer("Get")
]==];client.Parent=SPS
print("Mutant Lab V5 installed. Save, then Play to test.")
