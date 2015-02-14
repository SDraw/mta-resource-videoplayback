# mta-resource-videoplayback
Current resource allows you to play custom videofile.

###How to create videofile
1. You need to separate each frame of video you like. For this you can use any video editing software that can do it (I prefer Sony Vegas). Remember, that FPS should be integer.
http://i.imgur.com/oTapiN2.png
I suggest you to keep video resolution below 320x240 because you can get EXTREMELY large videofile at the end.
All frames should be in '<current_resource>/frames/' folder.
2. Separate audiotrack and put in in resource folder.
3. Change first three variables in 'video_gen_server.lua' to yours.
4. Uncomment server script line in 'meta.xml' 
5. Start resource.
6. Wait for video creating.
7. Comment server script line in 'meta.xml', uncomment file line in 'meta.xml'
8. Restart resource.

###Videofile structure
http://i.imgur.com/kxl05a2.png
###Client-side commands
vload <file_name>, vplay, vstop, vrewind, vunload.

###Warnings
1. This is demonstration resource. It's not for everyday using.
2. If you do something wrong, you probably will crash your game at playback.

###Screenshot
http://i.imgur.com/5CQwG2p.png

###Video
http://www.youtube.com/watch?v=bmTcHw3_KRc

If you can't create videofile, you can use https://dl.dropbox.com/s/y505wwilfdqnpk6/video.mvf for demonstration.
