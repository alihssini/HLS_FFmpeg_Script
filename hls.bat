@ECHO off
Rem This command will create a VoD HLS from a source video. Developed by: Ali Hosseini
echo Conversion started
set ffmpeg_home=%FFMPEG_HOME%
set file_name=%1
set directory_name=%file_name:~0,-4%
echo Creating output directory ...
MD %directory_name%
set qualities=%2
set qualities=%qualities:~1,-1%
echo Rendering thumbnail...
ffmpeg -itsoffset -1 -i %file_name% -vcodec mjpeg -vframes 1 -an -f rawvideo -s 320x240 %directory_name%/thumbnail.jpg
echo Generating shell for selected qualities...
set com=ffmpeg -hide_banner -y -i %file_name% 
echo Creating playlist.m3u8
echo #EXTM3U >> %directory_name%/playlist.m3u8
echo #EXT-X-VERSION:3 >> %directory_name%/playlist.m3u8
IF "%qualities:~0,3%"=="240" (
echo #EXT-X-STREAM-INF:BANDWIDTH=100000,RESOLUTION=426x240 >> %directory_name%/playlist.m3u8
echo 240p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=426:h=240:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 15 -b:v 100k -maxrate 175k -bufsize 250k -b:a 64k -hls_segment_filename %directory_name%/240p_%%04d.ts %directory_name%/240p.m3u8
)
IF "%qualities:~4,3%"=="360" (
echo #EXT-X-STREAM-INF:BANDWIDTH=250000,RESOLUTION=640x360 >> %directory_name%/playlist.m3u8
echo 360p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 20 -b:v 250k -maxrate 355k -bufsize 750k -b:a 96k -hls_segment_filename %directory_name%/360p_%%04d.ts %directory_name%/360p.m3u8
)
IF "%qualities:~8,3%"=="480" (
echo #EXT-X-STREAM-INF:BANDWIDTH=310000,RESOLUTION=842x480 >> %directory_name%/playlist.m3u8
echo 480p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=842:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 20 -b:v 310k -maxrate 400k -bufsize 850k -b:a 96k -hls_segment_filename %directory_name%/480p_%%04d.ts %directory_name%/480p.m3u8
)
IF "%qualities:~12,3%"=="720" (
echo #EXT-X-STREAM-INF:BANDWIDTH=420000,RESOLUTION=1280x720 >> %directory_name%/playlist.m3u8
echo 720p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 25 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 25 -b:v 420k -maxrate 550k -bufsize 1260k -b:a 128k -hls_segment_filename %directory_name%/720p_%%04d.ts %directory_name%/720p.m3u8
)
IF "%qualities:~16,4%"=="1080" (
echo #EXT-X-STREAM-INF:BANDWIDTH=600000,RESOLUTION=1920x1080 >> %directory_name%/playlist.m3u8
echo 1080p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 30 -b:v 600k -maxrate 900k -bufsize 1800k -b:a 192k -hls_segment_filename %directory_name%/1080p_%%04d.ts %directory_name%/1080p.m3u8
)
IF "%qualities:~21,4%"=="2160" (
echo #EXT-X-STREAM-INF:BANDWIDTH=1500000,RESOLUTION=3840x2160 >> %directory_name%/playlist.m3u8
echo 2160p.m3u8 >> %directory_name%/playlist.m3u8
set com=%com% -vf scale=w=3840:h=2160:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -r 30 -b:v 1500k -maxrate 2500k -bufsize 4500k -b:a 192k -hls_segment_filename %directory_name%/2160p_%%04d.ts %directory_name%/2160p.m3u8
)
echo Start converting for qualities: %qualities%
start /wait %com% 
echo Conversion success


