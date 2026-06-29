#!/usr/bin/python
#
# File: i3mpd.py
# Author: Alex Barney (electra13x7777)
# Fork of spotify.py by firatakandere
# Repo: https://github.com/electra13x7777/i3mpd
#
# Description: Fork of spotify.py that aims to add more functionality

import dbus
import os
import sys

def get_max_string(orig, maxlen):
    if len(orig) > maxlen:
        return orig[:maxlen] + '...'
    return orig[:]
# Format Album - Song
#
# @params: int max_album_len, int max_song_len, string artist, string album, string song
# Description: Formats artist, album and song strings to given length and replaces characters that break i3 prints.
def format(max_album_len, max_song_len, artist, album, song):
    # format i3 unsupported characters
    # &
    if '&' in artist:
        artist = artist.replace('&', 'And')
    if '&' in album:
        album = album.replace('&', 'And')
    if '&' in song:
        song = song.replace('&', 'And')
    
    song = get_max_string(song, max_song_len) if len(song) else '*unknown*'
    artist = 'by ' + artist if len(artist) else ''
    album = '(' + get_max_string(album, max_album_len) + ')' if len(album) else ''
    return str("%s %s %s" % (song, artist, album))

try:
    bus = dbus.SessionBus()

    # Spotify Player
    spotify = bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
    spotify_iface = dbus.Interface(spotify, 'org.freedesktop.DBus.Properties')
    props = spotify_iface.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

    nbtn = '⏭ ❳ '
    prbtn =  ' ❲ ⏮ '

    if os.environ.get('BLOCK_BUTTON'):
        control_iface = dbus.Interface(spotify, 'org.mpris.MediaPlayer2.Player')
        if os.environ['BLOCK_BUTTON'] == '1':
            control_iface.PlayPause()
        elif os.environ['BLOCK_BUTTON'] == '2':
            control_iface.Previous()
            prbtn =  ' ❲⏮  '
        elif os.environ['BLOCK_BUTTON'] == '3':
            control_iface.Next()
            nbtn = ' ⏭❳ '
        else:
            prbtn =  ' ❲ ⏮ '
            nbtn = ' ⏭ ❳ '

    # Update PlaybackStatus
    pbstate = spotify_iface.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')
    pbtn = ''

    if pbstate == 'Paused':
        pbtn = ' ⏵ '
    elif pbstate == 'Playing':
        pbtn = ' ⏸ '
    else:
        pbtn = ' ⏹ '

    # Wrapping Text
    artist = str(props['xesam:artist'][0])
    album = str(props['xesam:album'])
    song = str(props['xesam:title'])
    metadata = format(20, 25, artist, album, song)

    mins = int(props['mpris:length']/1000000//60)
    secs = str('%2f' % float(props['mpris:length']/1000000%60/100))
    time = str(" (%d:%s)" % (mins, secs[2:4]))

    if sys.version_info > (3, 0):
        print(pbtn + metadata)
    else:
        print(props['xesam:artist'][0] + pbtn + props['xesam:title']).encode('utf-8')
    exit

except dbus.exceptions.DBusException:
    exit
