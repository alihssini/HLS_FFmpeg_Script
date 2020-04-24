# HLS_FFmpeg_Script
Script for convert media to HLS format with FFmpeg library

For use this script you need to download and extract FFmpeg library from https://ffmpeg.org/download.html

this script can convert video files to HLS format with following structures:
1. Chunk size set to 4sec and this size is the best option between high adapting streaming and efficiency.if you need to change chunk's duration you can change "-hls_time 4" to any other duration.

2. For executing this script you can execute the following command for all qualities.
c:\...\hls d:\Media\Test.mp4 240,360,480,720,1080,2160
and to reject any quality you can set all digits of this quality to zero.ex: 000,360,000,720,0000,0000

3. In this script for low qualities I defined lower frame rate and you can change this option if you have some media with a high refresh rate(ex: action and sports media). change parameter "vod -r 15" or other rates to higher rate like 30fps

Finally: for every execution, this script creates a directory same with the filename and save all chunks with "360p_%%04d.ts" or... and for each quality create on .m3u8 QualityPlaylist file and in every directory u have one MasterPlaylist: playlist.m3u8
