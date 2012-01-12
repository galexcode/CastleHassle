//
//  PlayerData.m
//  Rev5
//
//  Created by Bryce Redd on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameSettings.h"
#import "PListReader.h"
#import "PlayerArea.h"
#import "PlayerAreaManager.h"
#import "Battlefield.h"

@implementation GameSettings

@synthesize playerID, numPlayers, backgroundType, type, followShot, hasSound, territoryID;

static GameSettings * instance = nil;

+(GameSettings *) instance {
	if(instance == nil) {
		instance = [[GameSettings alloc] init];
	} return instance;
}

-(id) init {
	if((self = [super init])) {		
		[self resetGameProperties];
		hasSound = YES;
	} return self;
}

-(void) resetGameProperties {
	playerID = 0;
	numPlayers = 1;
	backgroundType = tuscany;
	followShot = YES;
}

-(void) setHasSound:(BOOL)b {
	[SimpleAudioEngine sharedEngine].mute = !b;
	hasSound = b;
}

-(ccColor3B) getColorForPlayer:(PlayerArea*)pa {
	PlayerAreaManager* mgr = [Battlefield instance].playerAreaManager;
	int pid = [mgr getPlayerID:pa];
	
	return [self getColorForPlayerByID:pid];
}

-(ccColor3B) getColorForPlayerByID:(int)pid {
	
	if (type == campaign ) {
		if(pid != 0) { pid = 1; }
	}
		
    if(pid == 0)
        return (ccColor3B){21, 140, 202};
    if(pid == 1)
        return (ccColor3B){255,255,0};
    if(pid == 2)
        return (ccColor3B){0,255,0};

    return (ccColor3B){242, 56, 56};
}

-(ccColor3B) getColorForCurrentPlayer {
	return [self getColorForPlayerByID:playerID];
}

-(NSString*) getBackgroundFileName:(NSString*)fname {
	
	if(backgroundType == tuscany)
		return [[[NSString stringWithFormat:@"t%@", fname] retain] autorelease];
	if(backgroundType == britany)
		return [[[NSString stringWithFormat:@"b%@", fname] retain] autorelease];
	if(backgroundType == saxony)
		return [[[NSString stringWithFormat:@"s%@", fname] retain] autorelease];
	
	return @"type not found";
}

@end
