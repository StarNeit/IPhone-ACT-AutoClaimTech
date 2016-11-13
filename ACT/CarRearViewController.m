//
//  CarRearViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 02/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CarRearViewController.h"

#import "Over_ViewController.h"
#import "CarLeftViewController.h"
#import "CarRightViewController.h"
#import "SaveData.h"

@interface CarRearViewController ()

@end

@implementation CarRearViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    leftRecognizer.delegate = self;
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    // right swipe controller
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
      rightRecognizer.delegate = self;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];

    
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    //     bg.backgroundColor = [UIColor blueColor];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
        
    UIImageView *damagelabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rear.png"]];
    damagelabel.frame = CGRectMake(40, 80, 206, 24);
   [self.view addSubview:damagelabel];
    
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
     keybtn.enabled =NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
     [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
   // [keybtn addTarget:self action:@selector(presskeypad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
     camerabtn.enabled =NO;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
   
    UIImageView *damageimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"damage.png"]];
    damageimage.frame = CGRectMake(40, 192, 271, 369);
    damageimage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:damageimage];
    
    carbackimage = [[UIView alloc] initWithFrame:CGRectMake(320, 200, 644, 340)];
    carbackimage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:carbackimage];

    UIImageView *car = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car3.png"]];
    car.frame = CGRectMake(0, 0, 644, 355);
    car.backgroundColor = [UIColor clearColor];
    [carbackimage addSubview:car];

    carsign3 = [[signview alloc] initWithFrame:CGRectMake(0, 0, 644, 355)];
    carsign3.userInteractionEnabled=YES;
    carsign3.backgroundColor = [UIColor clearColor];
    [carbackimage addSubview:carsign3];
  
    clearbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearbtn.frame = CGRectMake(920, 200, 30, 21);
    [clearbtn setBackgroundImage:[UIImage imageNamed:@"eraser.png"] forState:UIControlStateNormal];
    [clearbtn addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearbtn];
    // Do any additional setup after loading the view from its nib.
}
-(void)Notes
{
    NotesViewController *notes1 = [[NotesViewController alloc] init];
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:notes1];
    navigate.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navigate animated:YES ];
    
}
- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = carbackimage.bounds;
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(void) viewWillAppear:(BOOL)animated
{
    UIImage *leftshot = [ACTAPP_DELEGATE getCarView:ACTScreenShotRearView];
    if (leftshot){ 
        carsign3.image = leftshot;}
   
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    UIImage *img = carsign3.image;
    if (img) {
        //[ACTAPP_DELEGATE saveimages:[self captureView:carbackimage] fileName:ACTScreenShotRearViewFull];        
        [ACTAPP_DELEGATE setCarView:carsign3.image forkey:ACTScreenShotRearView];
        [SaveData saveCarImg:[self captureView:carbackimage] forKey:ACTScreenShotRearView filename:ACTScreenShotRearViewFull];
    }
}
-(void)clear
{
    carsign3.image = nil;
    [ACTAPP_DELEGATE removeCarView:ACTScreenShotRearView];
    return;
}
- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    CarRightViewController *top =[[CarRightViewController alloc]initWithNibName:@"CarRightViewController" bundle:nil];
    [self.navigationController pushViewController:top animated:YES];
  //  [top release];
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    CarLeftViewController *front =[[CarLeftViewController alloc]initWithNibName:@"CarLeftViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
   // [front release];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([carbackimage isEqual:touch.view] || [carsign3 isEqual:touch.view]) {
        return NO;
    } else {
        return YES;
    }
}
-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to go to Home page? You will lose any unsaved data." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag =300;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //  NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView.tag == 300 && buttonIndex == 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
