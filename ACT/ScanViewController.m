//
//  ScanViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 24/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScanViewController.h"
#import "ViewController.h"
#import "Over_ViewController.h"
#import "config.h"
#import "NotesViewController.h"
#import "ListViewController.h"
#import "SaveData.h"

@interface ScanViewController ()

@end

@implementation ScanViewController
@synthesize keypad,supportedOrientationsMask;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSMutableArray *array;
- (void)viewDidLoad
{        //Swiping of viewcontroller//
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];

          //create background image//
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tap_ipad.png"]];
       bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
       
    UIButton *ctrcamerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ctrcamerabtn.frame = CGRectMake(430, 215, 180, 180);
    ctrcamerabtn.backgroundColor = [UIColor clearColor];
    [ctrcamerabtn addTarget:self action:@selector(scanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ctrcamerabtn];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];

    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keybtn.tag = 200;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    [keybtn addTarget:self action:@selector(presskeypad:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];

    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(scanButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];

    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:settingbtn];
    
    [enterbtn addTarget:self action:@selector(Enter) forControlEvents:UIControlEventTouchUpInside];
    [gobtn addTarget:self action:@selector(Go) forControlEvents:UIControlEventTouchUpInside];
    
     array = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M", nil]];
    
    for (int i = 100; i<133; i++) {
        UIButton *btn = (UIButton *)[keypad viewWithTag:i];
        [btn addTarget:self action:@selector(keyaction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view removeFromSuperview];    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)Notes
{
    NotesViewController *notes1 = [[NotesViewController alloc] init];
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:notes1];
    navigate.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navigate animated:YES];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
  /*  ListViewController *vehl =[[ListViewController alloc]initWithNibName:@"ListViewController" bundle:nil];
    [self.navigationController pushViewController:vehl animated:YES];*/
   // [vehl release];
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    //Over_ViewController *over =[[Over_ViewController alloc]initWithNibName:@"Over_ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)presskeypad:(UIButton*)sender
{
    [self.navigationController setNavigationBarHidden:YES];
    KeyViewController *key = [[KeyViewController alloc] initWithNibName:@"KeyViewController" bundle:nil];
    key.delegate = self;
    [self presentModalViewController:key animated:YES];
}

-(void) willAddDismissView:(BOOL)isNavigate
{
    ListViewController *release = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    release.vinnumber  = vintxt.text;  
    [self.navigationController pushViewController:release animated:YES];  
}

-(void)Go
{
    [self.navigationController setNavigationBarHidden:YES];
    ListViewController *release = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    release.vinnumber  = vintxt.text;  
    [self.navigationController pushViewController:release animated:YES];     
}

-(void)keyaction:(UIButton *)btn
{
    vintxt.text = [NSString stringWithFormat:@"%@%@",vintxt.text,[array objectAtIndex:btn.tag-100]];
    //[self.view addSubview:keypad];
}

-(void)home
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction) scanButtonTapped
{			
    /*if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"b4hvinscan:"]]) {

    }else
    {
        NSURL *urlapp = [NSURL URLWithString:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=308740640&mt=8"];
        [[UIApplication sharedApplication] openURL:urlapp];
    }*/
    
    reader =  [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.cameraFlashMode = YES;
    if(UIInterfaceOrientationLandscapeRight)
    {
        reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationLandscapeRight);
    }
    else if(UIInterfaceOrientationLandscapeLeft)
    {
        reader.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationLandscapeLeft);
    }
   
    UIView *backgrdimage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    backgrdimage.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgrdimage.contentMode = UIViewContentModeScaleToFill;
    [reader setCameraOverlayView:backgrdimage];
    UIImageView *bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_bg.png"]];
    bgImg.frame = backgrdimage.frame;
    bgImg.contentMode = UIViewContentModeScaleToFill;
    [backgrdimage addSubview:bgImg];
    
    // INFO BUTTON
    UIView * infoButton;
    infoButton = [[[[[reader.view.subviews objectAtIndex:2] subviews] objectAtIndex:0] subviews] objectAtIndex:3];
    [infoButton setFrame:CGRectMake(10, 10, 64, 31)];
    [infoButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cancel_btn"]]];
    [infoButton setHidden:YES];
    
    // THE TOOLBAR
    UIToolbar * theToolbar;
    theToolbar = [[[reader.view.subviews objectAtIndex:2] subviews] objectAtIndex:0];
    //[theToolbar setFrame:CGRectMake(0,5,768,-1)];
    //[theToolbar setBackgroundColor:[UIColor blackColor]];
    
    // Image for canceling
    UIImage* theImg = [UIImage imageNamed:@"cancel_btn"];
    UIImageView* theImgView = [[UIImageView alloc] initWithImage:theImg];
    
    // CANCEL BUTTON
    UIView * cancelButton;
    cancelButton = [[[[[reader.view.subviews objectAtIndex:2] subviews] objectAtIndex:0] subviews] objectAtIndex:2];
    //[cancelButton setBackgroundColor:[UIColor whiteColor]];
    //[cancelButton setBounds:CGRectMake(0, 0, 0, 0)];
    [cancelButton setTintColor:[UIColor clearColor]];
    [cancelButton addSubview:theImgView];
    theImgView.center = CGPointMake(50, 40);
    //[cancelButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cancel_btn_sm"]]];
    
    NSLog(@"%@",[[[reader.view.subviews objectAtIndex:2] subviews] objectAtIndex:0]);
    reader.showsZBarControls = YES;

    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_X_DENSITY to:0];
    
    reader.readerView.zoom = 0.3;

    if(reader.cameraMode == ZBarReaderControllerCameraModeSampling) {
        NSLog(@"ZBarReaderControllerCameraModeSampling");
        // additional automatic capture configuration here
    }else {
        NSLog(@"else");
        // additional manual capture configuration here
    }
    [self presentModalViewController:reader animated: YES];
    [reader release];
}

-(void)install {
	NSURL *urlapp = [NSURL URLWithString:ACT_VINCONFIG_URL];
	[[UIApplication sharedApplication] openURL:urlapp];
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry
{
    NSLog(@"decode error");
}
#pragma mark ZBarReaderDelegate

- (void) imagePickerController: (UIImagePickerController*) reader  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
	ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;

    resultText.text = symbol.data;
	
    // EXAMPLE: do something useful with the barcode image
    resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    [reader dismissModalViewControllerAnimated: YES];
        
    if(! [SaveData saveDatainArray:symbol.data forKey:ACT_SAVEVIN])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This VIN is already exist." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:YES];
        ListViewController *release = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        release.vinnumber  = symbol.data;  
        [self.navigationController pushViewController:release animated:YES];  
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc
{
    ACTReleaseNil(array);
}


@end
