//
//  Over_ViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Over_ViewController.h"
#import "ViewController.h"
#import "config.h"
#import "SaveData.h"

@interface Over_ViewController ()

@end

@implementation Over_ViewController


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
    leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
        
                 //set background image//
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
   
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    UIImageView *paint = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paintless1.png"]];
    paint.frame = CGRectMake(130, 200, 332, 136);
    [self.view addSubview:paint];
    
    UIImageView *spray = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overspray1.png"]];
    spray.frame = CGRectMake(530, 200, 332, 136);
    [self.view addSubview:spray];

    paintbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    paintbtn.tag = 100;
    paintbtn.frame = CGRectMake(145, 215, 108, 106);
    paintbtn.backgroundColor = [UIColor clearColor];
    [paintbtn setBackgroundImage:[UIImage imageNamed:@"b2.png"] forState:UIControlStateNormal];
    [paintbtn setBackgroundImage:[UIImage imageNamed:@"b1.png"] forState:UIControlStateHighlighted];

    [paintbtn addTarget:self action:@selector(Enter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paintbtn];
   
     spraybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    spraybtn.tag = 200;
    spraybtn.frame = CGRectMake(545, 217, 108, 106);
    spraybtn.backgroundColor = [UIColor clearColor];
    [spraybtn setBackgroundImage:[UIImage imageNamed:@"b2.png"] forState:UIControlStateNormal];
    [spraybtn setBackgroundImage:[UIImage imageNamed:@"b1.png"] forState:UIControlStateHighlighted];
    [spraybtn addTarget:self action:@selector(Enter:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spraybtn];

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
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
     camerabtn.enabled =NO;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     settingbtn.enabled =NO;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingbtn];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    /* ScanViewController *scan =[[ScanViewController alloc]initWithNibName:@"ScanViewController" bundle:nil];
     [self.navigationController pushViewController:scan animated:YES];
     [scan release];*/
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    ViewController *view =[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [view release];
}

-(void)Enter:(UIButton *)btn
{
    //[SaveData clearVIN:ACT_SAVEVIN];
     [[ACTAPP_DELEGATE carimagearray] removeAllObjects];
    
   
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSArray *val;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:ACTLoginDetails];
    int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
    
    if(org == 1)
    {
        if(btn.tag == 200)
        {
            [self.navigationController setNavigationBarHidden:YES];
            ScanViewController *scan = [[ScanViewController alloc] initWithNibName:@"ScanViewController" bundle:nil];
            [self.navigationController pushViewController:scan animated:YES];
        }
        else if(btn.tag == 100)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You are not authorized to use it." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
    }
    else if(org == 2)
    {
        [self.navigationController setNavigationBarHidden:YES];
        ScanViewController *scan = [[ScanViewController alloc] initWithNibName:@"ScanViewController" bundle:nil];
        [self.navigationController pushViewController:scan animated:YES];
    }
    
      
    if (btn.tag == 100) [ACTAPP_DELEGATE setUserDefault:ACTPageEngingKey setObject:@"0"];
    else [ACTAPP_DELEGATE setUserDefault:ACTPageEngingKey setObject:@"1"];
    
    [ACTAPP_DELEGATE setUserDefault:ACT_Notes setObject:@""];
}
-(void)home
{
    [self.navigationController popViewControllerAnimated:YES];
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
