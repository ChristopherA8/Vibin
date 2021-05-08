@interface SBMediaController : NSObject

+ (id)sharedInstance;
- (void)decreaseVolume;
- (void)increaseVolume;
- (BOOL)muted;
- (void)setVolume:(float)arg1;
- (float)volume;
- (BOOL)setPlaybackSpeed:(int)arg1;
- (BOOL)toggleShuffle;
- (BOOL)toggleRepeat;
- (BOOL)skipFifteenSeconds:(int)arg1;
- (BOOL)stop;
- (BOOL)togglePlayPause;
- (BOOL)pause;
- (BOOL)play;
- (BOOL)endSeek:(int)arg1;
- (BOOL)beginSeek:(int)arg1;
- (BOOL)changeTrack:(int)arg1;
- (id)nowPlayingApplication;
- (BOOL)trackIsBeingPlayedByMusicApp;
- (double)trackElapsedTime;
- (id)artwork;
- (double)trackDuration;
- (int)shuffleMode;
- (int)repeatMode;
- (unsigned long long)trackUniqueIdentifier;
- (BOOL)isTVOut;
- (BOOL)isMovie;
- (BOOL)isPaused;
- (BOOL)isPlaying;
- (BOOL)isLastTrack;
- (BOOL)isFirstTrack;
- (BOOL)hasTrack;
- (void)setNowPlayingInfo:(id)arg1;
- (id)_nowPlayingInfo;

@end