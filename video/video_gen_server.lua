local frames = 8900
local fps = 30
local sound_file = "mus.ogg"

local fl = fileCreate("video.mvf")

fileWrite(fl,string.char(fps))
fileWrite(fl,string.char(0))

local str_s = string.format("%08x",frames)
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,1,2)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,3,4)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,5,6)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,7,8)))))
fileWrite(fl,string.char(0))

local mf = fileOpen(sound_file,true)

str_s = string.format("%08x",fileGetSize(mf))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,1,2)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,3,4)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,5,6)))))
fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,7,8)))))
fileWrite(fl,string.char(0))

str_s = fileRead(mf,fileGetSize(mf))
fileClose(mf)
fileWrite(fl,str_s)

for i=0,frames-1 do
    fileWrite(fl,string.char(0))
    local ff = fileOpen("frames/frame_"..string.format("%06d",i)..".jpeg",true)
    str_s = string.format("%08x",fileGetSize(ff))
    fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,1,2)))))
    fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,3,4)))))
    fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,5,6)))))
    fileWrite(fl,string.char(tonumber(string.format("%d","0x"..string.sub(str_s,7,8)))))
    str_s = fileRead(ff,fileGetSize(ff))
    fileClose(ff)
    fileWrite(fl,string.char(0))
    fileWrite(fl,str_s)
    outputServerLog("Frame "..i.." has been written")
end

fileClose(fl)
outputServerLog("Video file has been successfully created")
