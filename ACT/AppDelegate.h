//
//  AppDelegate.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFViewController.h"
#import "VINDB.h"
#import "Reachability.h"

@class ViewController;
@class Over_ViewController;
@class formSubmitViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableDictionary *carimagearray;
    
    //Check Network Connection
	Reachability *internetReachable;
    Reachability *hostReachable;
    UINavigationController *navigation;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *carimagearray;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) Over_ViewController *overviewController;
@property (strong, nonatomic) formSubmitViewController *formController;

- (void)setUserDefault:(NSString*)key setObject:(NSString*)myString;
- (NSString*) getUserDefault:(NSString*)key;
- (void) setCarView:(UIImage *)img forkey:(NSString*)key;
- (UIImage*) getCarView:(NSString*)key;
- (void) saveCameraView:(NSMutableArray *)arr forkey:(NSString*)key;
- (void) setdate:(NSString*)str forkey:(NSString *)key;
- (NSString *) getdate:(NSString *)key;
- (NSArray*) getCameraArray:(NSString*)key;
- (NSString*)emptyStr:(NSString*)txt;
- (UIImageView*) imageview:(UIImageView*)img;
- (void) saveimages:(UIImage*)img fileName:(NSString*)name;
- (NSString*) imageFolder;
- (void) removeCarView:(NSString*)key;
- (NSString*) setTextLimits:(NSString*)str;
- (void) checkAndCreateDatabase;
- (NSString *) connectionDBPath;
- (void)SaveVin:(NSString*)str forkey:(NSString*)key;
- (NSString*) GetVin:(NSString*)key;

-(void) alertView;
-(void) formSubmit;
@end
