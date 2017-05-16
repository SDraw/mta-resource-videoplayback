# mta-resource-videoplayback
Current resource allows you to play custom videofile.

### Screenshot
![](http://i.imgur.com/5CQwG2p.png)

### Client-side console commands
```
vload <file_name>
vplay
vstop
vrewind
vunload
```

### How to create videofile
1. You need to separate each frame of video to image file in '<current_resource>/frames/' folder ([Sony Vegas example](http://i.imgur.com/oTapiN2.png)). FPS should be integer. It's better to keep video resolution near or below 320x240 because you can get EXTREMELY large videofile.
2. Separate audiotrack and put in in resource folder.
3. Change first three variables in 'video_gen_server.lua' to yours.
4. Uncomment server script line in 'meta.xml' 
5. Start resource.
6. Wait for video creating.
7. Comment server script line in 'meta.xml', uncomment file line in 'meta.xml'
8. Restart resource.  
If you can't create videofile, you can use https://dl.dropbox.com/s/y505wwilfdqnpk6/video.mvf for demonstration.

### Videofile structure
![](http://i.imgur.com/kxl05a2.png)

### Warnings
* This is only demonstration resource. You should not use it for regular usage.
* If you do something wrong, you probably will crash your game at playback.
