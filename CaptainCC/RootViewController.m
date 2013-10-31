//
//  RootViewController.m
//  CaptainCC
//
//  Created by Ann Niou on 10/27/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

//
// RootViewController + iAd
// If you want to support iAd, use this class as the controller of your iAd
//

#import "cocos2d.h"

#import "RootViewController.h"
#import "GameConfig.h"

@implementation RootViewController


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
	// Custom initialization
	}
	return self;
 }
 
- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
}
/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	[super viewDidLoad];
//     [self setupMaze];
 }



// Override to allow orientations other than the default portrait orientation
//valid for iOS 4 and 5, IMPORTANT, for iOS6 also modify supportedInterfaceOrientations
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	//
	// There are 2 ways to support auto-rotation:
	//  - The OpenGL / cocos2d way
	//     - Faster, but doesn't rotate the UIKit objects
	//  - The ViewController way
	//    - A bit slower, but the UiKit objects are placed in the right place
	//
	
#if GAME_AUTOROTATION==kGameAutorotationNone
	//
	// EAGLView won't be autorotated.
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	//
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION==kGameAutorotationCCDirector
	//
	// EAGLView will be rotated by cocos2d
	//
	// Sample: Autorotate only in landscape mode
	//
	if( interfaceOrientation == UIInterfaceOrientationLandscapeLeft ) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeRight];
	} else if( interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[[CCDirector sharedDirector] setDeviceOrientation: kCCDeviceOrientationLandscapeLeft];
	}
	
	// Since this method should return YES in at least 1 orientation, 
	// we return YES only in the Portrait orientation
	return ( interfaceOrientation == UIInterfaceOrientationPortrait );
	
#elif GAME_AUTOROTATION == kGameAutorotationUIViewController
	//
	// EAGLView will be rotated by the UIViewController
	//
	// Sample: Autorotate only in portrait mode
	//
	// return YES for the supported orientations
	
	return ( UIInterfaceOrientationIsPortrait( interfaceOrientation ) );
	
#else
#error Unknown value in GAME_AUTOROTATION
	
#endif // GAME_AUTOROTATION
	
	// Shold not happen
	return NO;
}

// these methods are needed for iOS 6
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000

-(NSUInteger)supportedInterfaceOrientations{
    //Modify for supported orientations, put your masks here, trying to mimic behavior of shouldAutorotate..
    #if GAME_AUTOROTATION==kGameAutorotationNone
	    return UIInterfaceOrientationMaskPortrait;
    #elif GAME_AUTOROTATION==kGameAutorotationCCDirector
    	NSAssert(NO, @"RootviewController: kGameAutorotation isn't supported on iOS6");
	    return UIInterfaceOrientationMaskLandscape;
    #elif GAME_AUTOROTATION == kGameAutorotationUIViewController
    	return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
    	//for both landscape orientations return UIInterfaceOrientationLandscape
    #else 
    #error Unknown value in GAME_AUTOROTATION
	
	#endif // GAME_AUTOROTATION
}

#if GAME_AUTOROTATION==kGameAutorotationUIViewController
- (BOOL)shouldAutorotate {
    return YES;
}
#else 
- (BOOL)shouldAutorotate {
    return NO;
}
#endif

//__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#else //deprecated in iOS6, so call only < 6. 
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#endif //__IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#endif 

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

//@synthesize  director=director_;

//- (void)setupMaze {
//    
//	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
//	CCGLView *glView = [CCGLView viewWithFrame: self.view.bounds
//								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
//								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
//							preserveBackbuffer:NO
//									sharegroup:nil
//								 multiSampling:NO
//							   numberOfSamples:0];
//    
//	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//    
//    //	director_.wantsFullScreenLayout = YES;
//    
//	// Display FSP and SPF
//	[director_ setDisplayStats:YES];
//    
//	// set FPS at 60
//	[director_ setAnimationInterval:1.0/60];
//    
//	// attach the openglView to the director
//	[director_ setView:glView];
//    
//	// for rotation and other messages
//	[director_ setDelegate:self];
//    
//	// 2D projection
//	[director_ setProjection:kCCDirectorProjection2D];
//    //	[director setProjection:kCCDirectorProjection3D];
//    
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director_ enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
//    
//	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
//	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
//	// You can change anytime.
//	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
//    
//	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
//	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
//	// On iPad     : "-ipad", "-hd"
//	// On iPhone HD: "-hd"
//	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
//	[sharedFileUtils setEnableFallbackSuffixes:YES];				// Default: NO. No fallback suffixes are going to be used
//	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
//	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
//	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
//    
//	// Assume that PVR images have premultiplied alpha
//	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
//    //
//    //	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
//	[director_ pushScene: [PracticeMazeScene node]];
//}
@end
