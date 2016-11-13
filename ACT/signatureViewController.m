//
//  signatureViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 29/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "signatureViewController.h"
#import "signview.h"
#import "Over_ViewController.h"
#import "ReleaseViewController.h"
#import "CameraViewController.h"
#import "config.h"
#import "NotesViewController.h"
#import "SaveData.h"
#import "ListViewController.h"
@interface signatureViewController ()

@end

@implementation signatureViewController
BOOL issign1btnEmpty = YES;
BOOL issign2btnEmpty = YES;


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
   /* UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];*/
    // right swipe controller
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];

    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    //     bg.backgroundColor = [UIColor blueColor];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
      UIImageView *signaturelbl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sign_text.png"]];
    signaturelbl.frame = CGRectMake(40, 80, 239, 29);
    [self.view addSubview:signaturelbl];
    
    
    UIImageView *sigform;
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *val;
    if (standardUserDefaults) 
        val = [standardUserDefaults objectForKey:ACTLoginDetails];
    int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
    if(org == 1)
    {
       sigform = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signature_act(1).png"]];
    }
    else
    {
        sigform = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"signature_Dent-zone(1).png"]];
    }

    sigform.frame = CGRectMake(170, 160, 683, 392);
    [self.view addSubview:sigform];
    
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
    settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];

    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
    
    sign1btn = [UIButton buttonWithType:UIButtonTypeCustom];
    sign1btn.frame = CGRectMake(310, 330, 250, 40);
    sign1btn.tag = 1000;
    sign1btn.contentMode = UIViewContentModeCenter;
    sign1btn.backgroundColor = [UIColor clearColor];
    [sign1btn addTarget:self action:@selector(showview1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sign1btn];
    
    sign2btn = [UIButton buttonWithType:UIButtonTypeCustom];
    sign2btn.frame = CGRectMake(310, 470, 250, 40);
    sign2btn.backgroundColor = [UIColor clearColor];
    [sign2btn addTarget:self action:@selector(showview2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sign2btn];
    
    datebtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    datebtn1.frame = CGRectMake(630, 330, 180, 40);
    [datebtn1 setTitle:@"" forState:UIControlStateNormal];
    [datebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    datebtn1.backgroundColor = [UIColor clearColor];
    [datebtn1 addTarget:self action:@selector(datepicker1) forControlEvents:UIControlEventTouchUpInside];
    [datebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:datebtn1];
    
    datebtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    datebtn2.frame = CGRectMake(630,470,180,40);
    [datebtn2 setTitle:@"" forState:UIControlStateNormal];
    [datebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    datebtn2.backgroundColor = [UIColor clearColor];
    [datebtn2 addTarget:self action:@selector(datepicker2) forControlEvents:UIControlEventTouchUpInside];
    [datebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:datebtn2];

    sign1 = [[signview alloc] initWithFrame:CGRectMake(0, 45, 600, 220)];
    sign1.userInteractionEnabled=YES;
    sign1.backgroundColor = [UIColor whiteColor];
    
    sign2 = [[signview alloc] initWithFrame:CGRectMake(0,45,600,220)];
    sign2.userInteractionEnabled=YES;
    sign2.backgroundColor = [UIColor whiteColor]; 
    
    savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //savebtn.enabled = NO;
    savebtn.frame = CGRectMake(850, 80, 125, 42);
    [savebtn setBackgroundImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];    
    [savebtn addTarget:self action:@selector(Save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:savebtn];


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)Notes
{
    NotesViewController *notes1 = [[NotesViewController alloc] init];
    UINavigationController *navigate = [[UINavigationController alloc] initWithRootViewController:notes1];
    navigate.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:navigate animated:YES ];
    
}
-(void) viewWillAppear:(BOOL)animated
{    
    UIImage *signshot = [ACTAPP_DELEGATE getCarView:ACTScreenShotSignature];
    UIImage *nilimage = [ACTAPP_DELEGATE getCarView:ACTScreenShotSignaturenil];
    
    if(signshot)
    {
        [sign1btn setImage:signshot forState:UIControlStateNormal];
    }
    if(nilimage)
    {
        [sign1btn setImage:nilimage forState:UIControlStateNormal];
    }

    UIImage *signshot1 = [ACTAPP_DELEGATE getCarView:ACTScreenShotSignature1];
    UIImage *nilimage1 = [ACTAPP_DELEGATE getCarView:ACTScreenShotSignature1nil];
    if(signshot1)
    {
        [sign2btn setImage:signshot1 forState:UIControlStateNormal];
    }
    if( nilimage1)
    {
        [sign2btn setImage:nilimage1 forState:UIControlStateNormal];
    }
   
    NSString *str = [ACTAPP_DELEGATE getdate:ACTScreenShotDate];
    if(str)
    {
        [datebtn1 setTitle:str forState:UIControlStateNormal];
    }
    NSString *str1 = [ACTAPP_DELEGATE getdate:ACTScreenShotDate1];
    if(str1)
    {
        [datebtn2 setTitle:str1 forState:UIControlStateNormal];
    }
    [super viewWillAppear:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

/*- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
   // if(sign1.image == nil && sign2.image == nil)
    if(sign1btn.imageView.image == nil && sign2btn.imageView.image == nil)
    {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Alert" message:@"Please choose to either accept or deny the pre-existing damages inspection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else if([datebtn1.titleLabel.text length] == 0 &&  [datebtn2.titleLabel.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Alert" message:@"Select date on one of these date fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else{
        CarLeftViewController *right =[[CarLeftViewController alloc]initWithNibName:@"CarLeftViewController" bundle:nil];
        [self.navigationController pushViewController:right animated:YES];
       // [right release];
    }
  }*/
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
  
    CameraViewController *release =[[CameraViewController alloc]initWithNibName:@"CameraViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
  //  [release release];
}
-(BOOL) isSelect:(NSInteger)val
{
    if (val == 0) {
        if (sign2.image == nil || [datebtn2.titleLabel.text isEqualToString:@""]) return YES;
        else return NO;
        
        
    }else  {
        if (sign1.image == nil || [datebtn1.titleLabel.text isEqualToString:@""]) return YES;
        else return NO;
        }
}
-(void)showview1:(id)sender
{
    if([self isSelect:0])
    {
    UIViewController *imageView = [[UIViewController alloc] init];
   // [self.navigationController pushViewController:imageViewController animated:YES];  
    UIView *popoverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];
    popoverview.backgroundColor = [UIColor clearColor];
    imageView.view = popoverview;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 750, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(Done)];
    UIBarButtonItem *barbtn1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clear)];
    
        if ([sender tag]==1000) [ACTAPP_DELEGATE setUserDefault:ACTPageSign setObject:@"1"];
        else  [ACTAPP_DELEGATE setUserDefault:ACTPageSign setObject:@"0"];

    NSArray *bar = [NSArray arrayWithObjects:barbtn1,barbtn, nil];
    [toolbar setItems:bar];
    [popoverview addSubview:toolbar];
    [popoverview addSubview:sign1];
    imageView.contentSizeForViewInPopover = CGSizeMake(750, 260);
        
        //create a popover controller
    popoverController = [[UIPopoverController alloc] initWithContentViewController:imageView];
    popoverController.delegate = self;
    
    //refrence to the button pressed within the current view
    [popoverController presentPopoverFromRect:CGRectMake(100, 100, 600, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];                              //release the popover content
   
        [popoverview release]; 
        [barbtn release];
        [imageView release];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Customer can sign only one of these boxes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
        
}
-(void)showview2:(id)sender
{
    if([self isSelect:1])
    {
        UIViewController *imageView = [[UIViewController alloc] init];
        UIView *popoverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];
        popoverview.backgroundColor = [UIColor clearColor];
        imageView.view = popoverview;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 850, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(Done1)];
    UIBarButtonItem *barbtn1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clear1)];
    
    NSArray *bar = [NSArray arrayWithObjects:barbtn1,barbtn, nil];
    [toolbar setItems:bar];
    [popoverview addSubview:toolbar];
    
        if ([sender tag]==1000) [ACTAPP_DELEGATE setUserDefault:ACTPageSign setObject:@"1"];
        else  [ACTAPP_DELEGATE setUserDefault:ACTPageSign setObject:@"0"];

    [popoverview addSubview:sign2];
      sign2.image =  [ACTAPP_DELEGATE getCarView:ACTScreenShotSignature1];
        
    imageView.contentSizeForViewInPopover = CGSizeMake(850, 260);
    [sign2 inputView];    
    //create a popover controller
    popoverController = [[UIPopoverController alloc]
                         initWithContentViewController:imageView];
    popoverController.delegate = self;
    
    //refrence to the button pressed within the current view
    [popoverController presentPopoverFromRect:CGRectMake(100, 100, 600, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];                              //release the popover content
    
    [popoverview release];
        [barbtn release];
    [imageView release];
    }
    else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Customer can sign only one of these boxes." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
    }
      
}
- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = sign1.bounds;
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(void)Done
{   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    
    if(sign1.image)
    {
        [sign1btn setImage:sign1.image forState:UIControlStateNormal];
        [ACTAPP_DELEGATE setCarView:sign1.image forkey:ACTScreenShotSignature];
        //[ACTAPP_DELEGATE saveimages:[self captureView:sign1] fileName:ACTScreenShotSignaturefull];
        [SaveData saveCarImg:[self captureView:sign1] forKey:ACTScreenShotSignature filename:ACTScreenShotSignaturefull];
        
    }
    else{
         [sign1btn setImage:[UIImage imageNamed:@"page_blank_230x30.png"] forState:UIControlStateNormal];
        [ACTAPP_DELEGATE setCarView:[UIImage imageNamed:@"page_blank_230x30.png"] forkey:ACTScreenShotSignaturenil];
    }
    [popoverController dismissPopoverAnimated:YES];
    [sign1 removeFromSuperview];
}
-(void)Done1
{    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    [sign2btn setImage:image forState:UIControlStateNormal];
    
    if(sign2.image) {
        [sign2btn setImage:sign2.image forState:UIControlStateNormal];
        [ACTAPP_DELEGATE setCarView:sign2.image forkey:ACTScreenShotSignature1];
       // [ACTAPP_DELEGATE saveimages:[self captureView:sign2] fileName:ACTScreenShotSignaturefull];
        [SaveData saveCarImg:[self captureView:sign2] forKey:ACTScreenShotSignature1 filename:ACTScreenShotSignaturefull];
    }
    else{
        [sign2btn setImage:[UIImage imageNamed:@"page_blank_230x30.png"] forState:UIControlStateNormal];
        [ACTAPP_DELEGATE setCarView:[UIImage imageNamed:@"page_blank_230x30.png"] forkey:ACTScreenShotSignature1nil];
    }
        [popoverController dismissPopoverAnimated:YES];
    [sign2 removeFromSuperview];
    
}
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    
    return NO;
}
/*-(void)setting
{
    [self.navigationController setNavigationBarHidden:YES];
    CarRightViewController *rightside = [[CarRightViewController alloc] initWithNibName:@"CarRightViewController" bundle:nil];
    [self.navigationController pushViewController:rightside animated:YES];  
}*/
-(void)home
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void)datepicker1
{
    if([self isSelect:0])
    {
        datepicker1 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 300)];
    datepicker1.datePickerMode = UIDatePickerModeDate;
    datepicker1.date = [NSDate date];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ok1)];
    NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
    
    UIViewController *pickView = [[UIViewController alloc] init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 330, 330)];
    popoverView.backgroundColor = [UIColor clearColor];
    [popoverView addSubview:toolbar];
    [popoverView addSubview:datepicker1];
    
    pickView.view = popoverView;
    pickView.contentSizeForViewInPopover = CGSizeMake(330, 260);
       //popoverview//
    popoverController = [[UIPopoverController alloc]
                         initWithContentViewController:pickView];
    popoverController.delegate = self;
    [popoverController presentPopoverFromRect:CGRectMake(630, 330, 120, 120) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]   ;                              //release the popover content
    [pickView release];
        [popoverView release];
        [barbtn release];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This action is not allowed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
       
}
-(void)datepicker2
{
    if([self isSelect:1])
    {
        datepicker2 = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 300)];
    datepicker2.datePickerMode = UIDatePickerModeDate;
    datepicker2.date = [NSDate date];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ok2)];
        NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
    
    
    UIViewController *pickView = [[UIViewController alloc] init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 330, 330)];
    popoverView.backgroundColor = [UIColor clearColor];
    [popoverView addSubview:toolbar];
    [popoverView addSubview:datepicker2];
    
    pickView.view = popoverView;
    pickView.contentSizeForViewInPopover = CGSizeMake(330, 260);
    
    popoverController = [[UIPopoverController alloc] initWithContentViewController:pickView];
    popoverController.delegate = self;
    [popoverController presentPopoverFromRect:CGRectMake(630, 470, 120, 120) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]   ;                              //release the popover content
    [pickView release];
        [barbtn release];
        [popoverView release]; }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"This action is not allowed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    ACTReleaseNil(popoverController);
}
-(void) ok1
{
    NSDateFormatter *datefr = [[NSDateFormatter alloc]init];
    [datefr setDateFormat:@"MM/dd/YYYY"];
    NSString *date = [datefr stringFromDate:datepicker1.date];
    ACTReleaseNil(datefr);
    [datebtn1 setTitle:date forState:UIControlStateNormal];
    [popoverController dismissPopoverAnimated:YES];
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.presigndate = date;
    [ACTAPP_DELEGATE setdate:date forkey:ACTScreenShotDate];
    [updateVINDB save];
    
}
-(void) ok2
{
    NSDateFormatter *datefr = [[NSDateFormatter alloc]init];
    [datefr setDateFormat:@"MM/dd/YYYY"];
    NSString *date = [datefr stringFromDate:datepicker2.date];
    ACTReleaseNil(datefr);
    [datebtn2 setTitle:date forState:UIControlStateNormal];
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.presigndate = date;
    [ACTAPP_DELEGATE setdate:date forkey:ACTScreenShotDate1];
    [updateVINDB save];
    [popoverController dismissPopoverAnimated:YES];
    
}
-(void)clear
{
    sign1.image = nil;
    datebtn1.titleLabel.text = nil;
    [sign1btn setImage:nil forState:UIControlStateNormal];
    [datebtn1 setTitle:nil forState:UIControlStateNormal];
    return;
}
-(void)clear1
{
    sign2.image = nil;
    datebtn2.titleLabel.text = nil;
    [datebtn2 setTitle:nil forState:UIControlStateNormal];
    [sign2btn setImage:nil forState:UIControlStateNormal];

}
-(void) Save
{
    if(sign1btn.imageView.image == nil && sign2btn.imageView.image == nil)
    {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Alert" message:@"Please choose to either accept or deny the pre-existing damages inspection." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else if([datebtn1.titleLabel.text length] == 0 &&  [datebtn2.titleLabel.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView  alloc] initWithTitle:@"Alert" message:@"Select date on one of these date fields." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }

    else
    {
    
       VINDB *saveJson = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
        
        saveJson.isSaved = 1;
        [saveJson save];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Job was successfully saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 200;
        [alert show];
        [alert release];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 200 )
    {
        for(UIViewController *view in self.navigationController.viewControllers)
        {
            if ([view isKindOfClass:[ListViewController class]]) 
            {
                [self.navigationController popToViewController:view animated:YES];
            }
        }
    }

}
-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame totallines:(int)lines
{
	UILabel *customLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
	customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = str;
    customLabel.numberOfLines = lines;
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.font=[UIFont fontWithName:@"Arial"size:20.0];
    customLabel.textColor=[UIColor whiteColor];
    
	return customLabel;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc
{
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
