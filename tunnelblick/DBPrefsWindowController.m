//
//  DBPrefsWindowController.m
//

#import "DBPrefsWindowController.h"
#import "TBUserDefaults.h"


extern TBUserDefaults * gTbDefaults;


static DBPrefsWindowController *_sharedPrefsWindowController = nil;


@implementation DBPrefsWindowController




#pragma mark -
#pragma mark Class Methods


+ (DBPrefsWindowController *)sharedPrefsWindowController
{
	if (!_sharedPrefsWindowController) {
		_sharedPrefsWindowController = [[self alloc] initWithWindowNibName:[self nibName]];
	}
	return _sharedPrefsWindowController;
}




+ (NSString *)nibName
// Subclasses can override this to use a nib with a different name.
{
    return @"Preferences";
}




#pragma mark -
#pragma mark Setup & Teardown


- (id)initWithWindow:(NSWindow *)window
// -initWithWindow: is the designated initializer for NSWindowController.
{
	self = [super initWithWindow:nil];
	if (self != nil) {
        // Set up an array and some dictionaries to keep track
        // of the views we'll be displaying.
		toolbarIdentifiers = [[NSMutableArray alloc] init];
		toolbarViews = [[NSMutableDictionary alloc] init];
		toolbarItems = [[NSMutableDictionary alloc] init];
        
        // Set up an NSViewAnimation to animate the transitions.
		viewAnimation = [[NSViewAnimation alloc] init];
		[viewAnimation setAnimationBlockingMode:NSAnimationNonblocking];
		[viewAnimation setAnimationCurve:NSAnimationEaseInOut];
		[viewAnimation setDelegate:self];
		
		[self setCrossFade:YES]; 
		[self setShiftSlowsAnimation:YES];
	}
	return self;
    
	(void)window;  // To prevent compiler warnings.
}




- (void)windowDidLoad
{
    // Create a new window to display the preference views.
    // If the developer attached a window to this controller
    // in Interface Builder, it gets replaced with this one.
    
    NSWindow *window = [[[NSWindow alloc] initWithContentRect:NSMakeRect(0.0, 0.0, 760.0, 390.0)
												    styleMask:(NSTitledWindowMask |
															   NSClosableWindowMask |
                                                               NSResizableWindowMask |
															   NSMiniaturizableWindowMask)
													  backing:NSBackingStoreBuffered
													    defer:YES] autorelease];
	[self setWindow:window];
    
    [self setShouldCascadeWindows: NO];
    
	contentSubview = [[[NSView alloc] initWithFrame:[[[self window] contentView] frame]] autorelease];
	[contentSubview setAutoresizingMask:(NSViewMinYMargin | NSViewWidthSizable | NSViewHeightSizable)];
	[[[self window] contentView] addSubview:contentSubview];
	[[self window] setShowsToolbarButton:NO];
    [[self window] setContentMinSize: NSMakeSize(760.0, 390.0)];
}




- (void) dealloc {
	[toolbarIdentifiers release];
	[toolbarViews release];
	[toolbarItems release];
	[viewAnimation release];
	[super dealloc];
}




#pragma mark -
#pragma mark Configuration


- (void)setupToolbar
{
	// Subclasses must override this method to add items to the
	// toolbar by calling -addView:label: or -addView:label:image:.
}




- (void)addView:(NSView *)view label:(NSString *)label
{
	[self addView:view
			label:label
			image:[NSImage imageNamed:label]];
}




- (void)addView:(NSView *)view label:(NSString *)label image:(NSImage *)image
{
	NSAssert (view != nil,
			  @"Attempted to add a nil view when calling -addView:label:image:.");
	
	NSString *identifier = [[label copy] autorelease];
	
	[toolbarIdentifiers addObject:identifier];
	[toolbarViews setObject:view forKey:identifier];
	
	NSToolbarItem *item = [[[NSToolbarItem alloc] initWithItemIdentifier:identifier] autorelease];
	[item setLabel:label];
	[item setImage:image];
	[item setTarget:self];
	[item setAction:@selector(toggleActivePreferenceView:)];
	
	[toolbarItems setObject:item forKey:identifier];
}




#pragma mark -
#pragma mark Accessor Methods


- (BOOL)crossFade
{
    return _crossFade;
}




- (void)setCrossFade:(BOOL)fade
{
    _crossFade = fade;
}




- (BOOL)shiftSlowsAnimation
{
    return _shiftSlowsAnimation;
}




- (void)setShiftSlowsAnimation:(BOOL)slows
{
    _shiftSlowsAnimation = slows;
}




#pragma mark -
#pragma mark Overriding Methods


- (IBAction)showWindow:(id)sender 
{
    // This forces the resources in the nib to load.
	(void)[self window];
    
    // Clear the last setup and get a fresh one.
	[toolbarIdentifiers removeAllObjects];
	[toolbarViews removeAllObjects];
	[toolbarItems removeAllObjects];
	[self setupToolbar];
    
	NSAssert (([toolbarIdentifiers count] > 0),
			  @"No items were added to the toolbar in -setupToolbar.");
	
	if ([[self window] toolbar] == nil) {
		NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"DBPreferencesToolbar"];
		[toolbar setAllowsUserCustomization:NO];
		[toolbar setAutosavesConfiguration:NO];
		[toolbar setSizeMode:NSToolbarSizeModeDefault];
		[toolbar setDisplayMode:NSToolbarDisplayModeIconAndLabel];
		[toolbar setDelegate:self];
		[[self window] setToolbar:toolbar];
		[toolbar release];
	}
	
	NSString *firstIdentifier = [toolbarIdentifiers objectAtIndex:0];
	[[[self window] toolbar] setSelectedItemIdentifier:firstIdentifier];
	[self displayViewForIdentifier:firstIdentifier animate:NO];

	[super showWindow:sender];
}




#pragma mark -
#pragma mark Toolbar


- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar
{
	return toolbarIdentifiers;
    
	(void)toolbar;
}




- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar 
{
	return toolbarIdentifiers;
    
	(void)toolbar;
}




- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar
{
	return toolbarIdentifiers;
	(void)toolbar;
}




- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)identifier willBeInsertedIntoToolbar:(BOOL)willBeInserted 
{
	return [toolbarItems objectForKey:identifier];
	(void)toolbar;
	(void)willBeInserted;
}




- (void)toggleActivePreferenceView:(NSToolbarItem *)toolbarItem
{
	[self displayViewForIdentifier:[toolbarItem itemIdentifier] animate:YES];
}




// Override in subclass if desired
-(void) oldViewWillDisappear: (NSView *) view identifier: (NSString *) identifier
{
	(void) view;
	(void) identifier;
}


// Override in subclass if desired
-(void) newViewWillAppear: (NSView *) view identifier: (NSString *) identifier
{
	(void) view;
	(void) identifier;
}


// Override in subclass if desired
-(void) newViewDidAppear: (NSView *) view
{
	(void) view;
}


- (void)displayViewForIdentifier:(NSString *)identifier animate:(BOOL)animate
{	
    // Find the view we want to display.
	NSView *newView = [toolbarViews objectForKey:identifier];
    
    // See if there are any visible views.
	NSView *oldView = nil;
	if ([[contentSubview subviews] count] > 0) {
        // Get a list of all of the views in the window. Usually at this
        // point there is just one visible view. But if the last fade
        // hasn't finished, we need to get rid of it now before we move on.
		NSEnumerator *subviewsEnum = [[contentSubview subviews] reverseObjectEnumerator];
		
        // The first one (last one added) is our visible view.
		oldView = [subviewsEnum nextObject];
		
        // Remove any others.
		NSView *reallyOldView = nil;
		while (  (reallyOldView = [subviewsEnum nextObject])  ) {
			[reallyOldView removeFromSuperviewWithoutNeedingDisplay];
		}
	}
	
	if (![newView isEqualTo:oldView]) {		
		NSRect frame = [newView bounds];
		frame.origin.y = NSHeight([contentSubview frame]) - NSHeight([newView bounds]);
		[newView setFrame:frame];
		[contentSubview addSubview:newView];
		[[self window] setInitialFirstResponder:newView];
        
		if (animate && [self crossFade])
			[self crossFadeView:oldView withView:newView];
		else {
			[oldView removeFromSuperviewWithoutNeedingDisplay];
			[newView setHidden:NO];
			[[self window] setFrame:[self frameForView:newView] display:YES animate:animate];
            [self newViewDidAppear: newView];
		}
		
        [[self window] setTitle:[self windowTitle: [[toolbarItems objectForKey:identifier] label]]];

    }
}


- (NSString *)windowTitle: (NSString *) currentItemLabel
// Subclasses can override this.
{
    return currentItemLabel;
}


#pragma mark -
#pragma mark Cross-Fading Methods


- (void)crossFadeView:(NSView *)oldView withView:(NSView *)newView
{
	[viewAnimation stopAnimation];
	
    NSString * identifier = nil;
    NSArray * keyArray = [toolbarViews allKeysForObject: oldView];
    if (  [keyArray count] == 1  ) {
        identifier = [keyArray objectAtIndex: 0];
    }
    [self oldViewWillDisappear: oldView identifier: identifier];
    
    identifier = nil;
    keyArray = [toolbarViews allKeysForObject: newView];
    if (  [keyArray count] == 1  ) {
        identifier = [keyArray objectAtIndex: 0];
    }
    [self newViewWillAppear: newView identifier: identifier];
    
    if ([self shiftSlowsAnimation] && [[[self window] currentEvent] modifierFlags] & NSShiftKeyMask)
		[viewAnimation setDuration:1.25];
    else
		[viewAnimation setDuration:0.25];
	
	NSDictionary *fadeOutDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                       oldView, NSViewAnimationTargetKey,
                                       NSViewAnimationFadeOutEffect, NSViewAnimationEffectKey,
                                       nil];
    
	NSDictionary *fadeInDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                      newView, NSViewAnimationTargetKey,
                                      NSViewAnimationFadeInEffect, NSViewAnimationEffectKey,
                                      nil];
    
	NSDictionary *resizeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [self window], NSViewAnimationTargetKey,
                                      [NSValue valueWithRect:[[self window] frame]], NSViewAnimationStartFrameKey,
                                      [NSValue valueWithRect:[self frameForView:newView]], NSViewAnimationEndFrameKey,
                                      nil];
	
	NSArray *animationArray = [NSArray arrayWithObjects:
                               fadeOutDictionary,
                               fadeInDictionary,
                               resizeDictionary,
                               nil];
	
    [viewAnimation setViewAnimations:animationArray];
	[viewAnimation startAnimation];
}


- (void)animationDidEnd:(NSAnimation *)animation
{
	NSView *subview;
	
    // Get a list of all of the views in the window. Hopefully
    // at this point there are two. One is visible and one is hidden.
	NSEnumerator *subviewsEnum = [[contentSubview subviews] reverseObjectEnumerator];
	
    // This is our visible view. Get past it.
	NSView * visibleView = [subviewsEnum nextObject];
    [self newViewDidAppear: visibleView]; 
    
    // Remove everything else. There should be just one, but
    // if the user does a lot of fast clicking, we might have
    // more than one to remove.
	while (  (subview = [subviewsEnum nextObject])  ) {
		[subview removeFromSuperviewWithoutNeedingDisplay];
	}
    
	(void)animation;
}




- (NSRect)frameForView:(NSView *)view
// Calculate the window size for the new view.
{
	NSRect windowFrame = [[self window] frame];
	NSRect contentRect = [[self window] contentRectForFrameRect:windowFrame];
	float windowTitleAndToolbarHeight = NSHeight(windowFrame) - NSHeight(contentRect);
    
	windowFrame.size.height = NSHeight([view frame]) + windowTitleAndToolbarHeight;
	windowFrame.size.width = NSWidth([view frame]);
	windowFrame.origin.y = NSMaxY([[self window] frame]) - NSHeight(windowFrame);
	
	return windowFrame;
}




@end
