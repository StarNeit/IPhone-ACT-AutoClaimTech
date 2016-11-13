//
//  AppDelegate.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PDFViewController.h"
#import "ViewController.h"
#import "Over_ViewController.h"
#import "VINDB.h"
#import "PDFViewController.h"
#import "formSubmitViewController.h"
#import "UIViewController+Present.h"
#import "PDR1ViewController.h"
#import "ReleaseViewController.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize overviewController;
@synthesize carimagearray;
@synthesize formController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    //self.viewController = [[PDR1ViewController alloc] init];
    
    navigation = [[UINavigationController alloc] initWithRootViewController:self.viewController];

    [self checkAndCreateDatabase];
    
    // check for internet connection
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
	
	internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
	
	// check if a pathway to a random host exists
	hostReachable = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReachable startNotifier];
    
    carimagearray = [[NSMutableDictionary alloc] init];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
   
    return YES;
}

- (void) checkNetworkStatus:(NSNotification *)notice
{	
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	switch (internetStatus)
	{

		case NotReachable:
		{
			//NSLog(@"The internet is down.");
				/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to connect"
																message:@"Unable to connect to the server, please ensure you are connected to the internet." 
															   delegate:self
													  cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];*/
			break;
		}
		case ReachableViaWiFi:
		{ 
            NSString *str = [self getUserDefault:ACT_RESCHEDULE];
			//NSLog(@"The internet is working via WIFI.");
            if (str && [str isEqualToString:@"yes"]) {
                [self alertView];
            }
			break;
			
		}
		case ReachableViaWWAN:
		{
			//NSLog(@"The internet is working via WWAN.");
			break;
			
		}
	}
}

-(void) alertView
{
    
    [self formSubmit];
    
   /* UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                    message:ACT_NWStart_Reschedule 
                                                   delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];  */
}

-(void) formSubmit
{
    NSArray *viewCont = navigation.viewControllers;
   
   // NSLog(@"navigation %@",navigation.viewControllers);

    /*formController = [[formSubmitViewController alloc] initWithStyle:UITableViewStyleGrouped ];
    formController.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:formController];
    navi.modalPresentationStyle = UIModalPresentationFormSheet;
    
    
    //UIViewController *presentVS = [viewCont lastObject];
    
    [[viewCont lastObject] presentNavigationController:navi];
    
    // if([navigation.viewControllers indexOfObject:[viewCont lastObject]]!=NSNotFound){

    //}*/
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void) checkAndCreateDatabase
{
	
	BOOL success;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *database=[self connectionDBPath];
	NSFileManager *fileManager = [NSFileManager defaultManager];

    	success = [fileManager fileExistsAtPath:database];
	if(success){ 
		return; 
	}

	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"act.sql"];
   // NSLog(@"databasePathFromApp %@",databasePathFromApp);
	[fileManager copyItemAtPath:databasePathFromApp toPath:documentsDir error:nil];
	databasePathFromApp = nil;
	[fileManager release];
}

-(NSString *) connectionDBPath
{
    NSString *databasePath;
    NSString *databaseName = @"act.sql";
    
    // Get the path to the documents directory and append the databaseName
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    return databasePath;
}

- (void)setUserDefault:(NSString*)key setObject:(NSString*)myString
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	
	if (standardUserDefaults) {
		[standardUserDefaults setObject:myString forKey:key];
		[standardUserDefaults synchronize];
	}
}

- (NSString*) getUserDefault:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:key];
	
	return val;
}

- (void) setCarView:(UIImage *)img forkey:(NSString*)key
{
     [carimagearray setObject:img forKey:key];
}

- (UIImage*) getCarView:(NSString*)key
{
    return [carimagearray objectForKey:key];
}

-(void) removeCarView:(NSString*)key
{
    [carimagearray removeObjectForKey:key];
}

-(NSString*) setTextLimits:(NSString*)str
{
    if([str length]>ACTMAXLimits)
    {
        str = [str substringToIndex:[str length]-([str length]-ACTMAXLimits)];
       return  str = [NSString stringWithFormat:@"%@...",str];
    }
    else 
    {
        return str;
    }
}

-(void) saveimages:(UIImage*)img fileName:(NSString*)name
{    
    NSData *pngData = UIImageJPEGRepresentation(img, 0.5 );      
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",[self imageFolder],name];
  //  NSLog(@"path file %@",filePath);
    [pngData writeToFile:filePath atomically:YES];
}

-(NSString*) imageFolder
{
    NSFileManager *NSFm= [NSFileManager defaultManager]; 
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/Photo",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir = YES;
    NSError *error;
    if(![NSFm fileExistsAtPath:dirToCreate isDirectory:&isDir])
        if(![NSFm createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Error: Create folder failed");
    return dirToCreate;
}

- (NSArray*) getCameraArray:(NSString*)key
{
    return [carimagearray objectForKey:key];
}

- (void) saveCameraView:(NSMutableArray *)arr forkey:(NSString*)key
{
    [carimagearray setObject:arr forKey:key];
}

-(void) setdate:(NSString*)str forkey:(NSString *)key
{
    [carimagearray setObject:str forKey:key];
}

-(NSString *) getdate:(NSString *)key
{
    return [carimagearray objectForKey:key]; 
}

-(NSString*)emptyStr:(NSString*)txt
{
    if (txt) return txt;
    else return @"";
}

@end
