//
//  UKLoginItemRegistry.m
//  TalkingMoose (XC2)
//
//  Created by Uli Kusterer on 14.03.06.
//  Copyright 2006 M. Uli Kusterer. All rights reserved.
//

#import "UKLoginItemRegistry.h"


@implementation UKLoginItemRegistry

+(NSArray*)	allLoginItems
{
	NSArray*	itemsList = nil;
    
    OSStatus	err;
    int         i;
    for (i=0; i<5; i++)
    {
        err = LIAECopyLoginItems( (CFArrayRef*) &itemsList );	// Take advantage of toll-free bridging.
        if( err == noErr )
            break;
        sleep(1);
    }
    if( err != noErr )
    {
        NSLog(@"After five tries, still could not list login items, error %ld", (long) err);
        return nil;
    }

	return [itemsList autorelease];
}

+(BOOL)		addLoginItemWithURL: (NSURL*)url hideIt: (BOOL)hide			// Main bottleneck for adding a login item.
{
	OSStatus err = LIAEAddURLAtEnd( (CFURLRef) url, (hide ? true : false) );	// CFURLRef is toll-free bridged to NSURL.
	
	if( err != noErr )
		NSLog(@"Couldn't add login item error %ld", (long) err);
	
	return( err == noErr );
}


+(BOOL)		removeLoginItemAtIndex: (int)idx			// Main bottleneck for getting rid of a login item.
{
	OSStatus err = LIAERemove( idx );
	
	if( err != noErr )
		NSLog(@"Couldn't remove login item error %ld", (long) err);
	
	return( err == noErr );
}


+(int)		indexForLoginItemWithURL: (NSURL*)url		// Main bottleneck for finding a login item in the list.
{
	NSArray*		loginItems = [self allLoginItems];
	NSEnumerator*	enny = [loginItems objectEnumerator];
	NSDictionary*	currLoginItem = nil;
	int				x = 0;
	
	while(( currLoginItem = [enny nextObject] ))
	{
		if( [[currLoginItem objectForKey: UKLoginItemURL] isEqualTo: url] )
			return x;
		
		x++;
	}
	
	return -1;
}

+(int)		indexForLoginItemWithPath: (NSString*)path
{
	NSURL*	url = [NSURL fileURLWithPath: path];
	
	return [self indexForLoginItemWithURL: url];
}

+(BOOL)		addLoginItemWithPath: (NSString*)path hideIt: (BOOL)hide
{
	NSURL*	url = [NSURL fileURLWithPath: path];
	
	return [self addLoginItemWithURL: url hideIt: hide];
}


+(BOOL)		removeLoginItemWithPath: (NSString*)path
{
	int		idx = [self indexForLoginItemWithPath: path];
	
	return (idx != -1) && [self removeLoginItemAtIndex: idx];	// Found item? Remove it and return success flag. Else return NO.
}


+(BOOL)		removeLoginItemWithURL: (NSURL*)url
{
	int		idx = [self indexForLoginItemWithURL: url];
	
	return (idx != -1) && [self removeLoginItemAtIndex: idx];	// Found item? Remove it and return success flag. Else return NO.
}

@end
