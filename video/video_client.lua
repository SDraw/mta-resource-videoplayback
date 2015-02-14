video = {}
video.sx,video.sy = guiGetScreenSize()

function video.load(szFile)
    if(video.loaded == true) then return false end
    video.file = fileOpen(szFile,true)
    if(not video.file) then return false end
    local at = {}
    
    video.fps = string.byte(fileRead(video.file,1))
    video.frame_tick = 1000.0/video.fps
    fileRead(video.file,1)
    
    for i=1,4 do
        at[i] = string.byte(fileRead(video.file,1))
    end
    video.frames = 0
    for i=1,4 do
        video.frames = video.frames+(at[5-i]*(256^(i-1)))
    end
    fileRead(video.file,1)
    
    for i=1,4 do
        at[i] = string.byte(fileRead(video.file,1))
    end
    video.audio_size = 0
    for i=1,4 do
        video.audio_size = video.audio_size+(at[5-i]*(256^(i-1)))
    end
    fileRead(video.file,1)
    
    if(video.audio_size > 0) then
        local buf = fileRead(video.file,video.audio_size)
        local af = fileCreate("audio_track.tmp")
        fileWrite(af,buf)
        fileClose(af)
    end
    
    video.start_offset = fileGetPos(video.file)
    
    video.loaded = true
    video.ended = false
    outputDebugString("Video loaded")
    outputDebugString("FPS: "..video.fps)
    outputDebugString("Frame tick: "..video.frame_tick)
    outputDebugString("Frames: "..video.frames)
    outputDebugString("Audio track size: "..video.audio_size)
    return true
end

function video.play()
    if(not video.loaded) then return false end
    if(video.ended == true) then return false end
    video.dif = getTickCount()
    video.current_frame = 0
    video.prtime = 0
    video.as_previous = true
    video.sound = playSound("audio_track.tmp")
    addEventHandler("onClientRender",root,video.draw)
end

function video.rewind()
    if(not video.loaded) then return false end
    fileSetPos(video.file,video.start_offset)
    video.dif = getTickCount()
    video.current_frame = 0
    video.prtime = 0
    video.as_previous = true
    if(video.sound) then
        setSoundPosition(video.sound,0.0)
    end
    if(video.ended == true) then
        video.ended = false
    end
end

function video.stop()
    if(not video.loaded) then return false end
    if(video.ended == true) then return false end
    if(video.sound) then
        stopSound(video.sound)
        video.sound = false
    end
    video.ended = true
    removeEventHandler("onClientRender",root,video.draw)
end

function video.unload()
    if(not video.loaded) then return false end
    fileClose(video.file)
    if(video.sound) then
        stopSound(video.sound)
        video.sound = false
    end
    fileDelete("audio_track.tmp")
    if(video.ended == false) then
        removeEventHandler("onClientRender",root,video.draw)
    end
    video.loaded = false
end

function video.draw()
    local olf = video.current_frame
    video.as_previous = true
    
    local buffer = ""
    local at = {}
    
    video.dif = getTickCount()-video.dif
    video.prtime = video.prtime+video.dif
    video.dif = getTickCount()
    video.current_frame = math.floor(video.prtime/video.frame_tick)
    if(video.current_frame >= video.frames) then
        video.stop()
        return
    end
    for i=olf+1,video.current_frame do
        fileRead(video.file,1) -- 00
        local fs = 0
        --read size
        for j=1,4 do
            at[j] = string.byte(fileRead(video.file,1))
        end
        for j=1,4 do
            fs = fs+(at[5-j]*(256^(j-1)))
        end
        fileRead(video.file,1)
        if(i == video.current_frame) then
            buffer = fileRead(video.file,fs)
            video.as_previous = false
        else
            fileRead(video.file,fs)
        end
    end
    if(video.as_previous == false) then
        if(video.texture) then
            destroyElement(video.texture)
        end
        if(buffer ~= "" and buffer ~= false) then
            video.texture = dxCreateTexture(buffer,"argb",false,"wrap")
        end
        if(video.texture) then
            dxDrawImage(video.sx/2-160,video.sy/2-90,320,180,video.texture)
        end
    end
    if(video.texture) then
        dxDrawImage(video.sx/2-160,video.sy/2-90,320,180,video.texture)
    end
    dxDrawText("Frame: "..video.current_frame,video.sx/2-159,video.sy/2-106,video.sx/2-74,video.sy/2-92,tocolor(255,255,255),1,"default","left","top")
end


function commandLoad(_,szFile)
    video.load(szFile)
end
addCommandHandler("vload",commandLoad)

function commandPlay()
    video.play()
end
addCommandHandler("vplay",commandPlay)

function commandStop()
    video.stop()
end
addCommandHandler("vstop",commandStop)

function commandRewind()
    video.rewind()
end
addCommandHandler("vrewind",commandRewind)

function commandUnload()
    video.unload()
end
addCommandHandler("vunload",commandUnload)