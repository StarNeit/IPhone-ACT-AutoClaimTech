//
//  signViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 10/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "signViewController.h"
#import "signview.h"
#import "SaveData.h"

@interface signViewController ()

@end

@implementation signViewController


- (void)viewDidLoad
{

    /*UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Home) ];
    self.navigationItem.rightBarButtonItem = btn;*/
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    UILabel *headertext = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 1000, 40)];
    headertext.text = @"RECEIPT OF SATISFACTION,RELEASE AND AUTHORIZATION TO PAY";
    headertext.font = [UIFont fontWithName:@"Gill Sans" size:24.0];
    headertext.backgroundColor = [UIColor clearColor];
    headertext.textColor = [UIColor whiteColor];
    [self.view addSubview:headertext];
    
    UILabel *paytext = [[UILabel alloc] initWithFrame:CGRectMake(30, 80, 980, 200)];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *val;
    if (standardUserDefaults) 
        val = [standardUserDefaults objectForKey:ACTLoginDetails];
    int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
    if(org == 1)
    {
        paytext.text = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Auto Claim Technology. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Auto Claim Technology. If paid by another party, I hereby authorize payment to be made directly to Auto Claim Technology, of a sum representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
    }
    else
    {
        paytext.text = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Dent Zone Companies, Inc. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Dent Zone Companies, Inc. If paid by another party, I hereby authorize payment to be made directly to Dent Zone Companies, Inc., of a sum representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
    }

    paytext.font = [UIFont fontWithName:@"Gill Sans" size:20.0];
    paytext.numberOfLines = 5;
    paytext.backgroundColor = [UIColor clearColor];
    paytext.textColor = [UIColor whiteColor];
    [self.view addSubview:paytext];
    
    signbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signbtn.frame = CGRectMake(200, 330, 250, 40);
    signbtn.tag = 1000;
    signbtn.contentMode = UIViewContentModeCenter;
    signbtn.backgroundColor = [UIColor whiteColor];
    [signbtn addTarget:self action:@selector(showview1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signbtn];
    
    datebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    datebtn.frame = CGRectMake(700, 330, 180, 40);
    [datebtn setTitle:@"" forState:UIControlStateNormal];
    [datebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    datebtn.backgroundColor = [UIColor clearColor];
    [datebtn addTarget:self action:@selector(datepicker1) forControlEvents:UIControlEventTouchUpInside];
    [datebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    datebtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:datebtn];

    UILabel *signlbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 330, 100, 40)];
    signlbl.text = @"Signature";
    signlbl.textColor = [UIColor whiteColor];
    signlbl.font = [UIFont fontWithName:@"Gill Sans" size:20.0];
    signlbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:signlbl];
    
    UILabel *datelbl = [[UILabel alloc] initWithFrame:CGRectMake(600, 330, 100, 40)];
    datelbl.text = @"Date";
    datelbl.backgroundColor = [UIColor clearColor];
    datelbl.font = [UIFont fontWithName:@"Gill Sans" size:20.0];
    datelbl.textColor = [UIColor whiteColor];
    [self.view addSubview:datelbl];
    
    signimage = [[signview alloc] initWithFrame:CGRectMake(0, 45, 600, 220)];
    signimage.userInteractionEnabled = YES;
    signimage.backgroundColor = [UIColor whiteColor];
    //[self.view addSubview:signimage];
    
    okbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okbtn.enabled = NO;
    [okbtn setBackgroundImage:[UIImage imageNamed:@"ok.png"] forState:UIControlStateNormal];
    okbtn.frame = CGRectMake(380, 450, 125, 42);
    [okbtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okbtn];
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    cancelbtn.frame = CGRectMake(550, 450, 125, 42);
    [cancelbtn addTarget:self action:@selector(Home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelbtn];
    
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated
{
    NSString *str = updateVINDB.finaldate;
    if (str) {
        [datebtn setTitle:str forState:UIControlStateNormal];
    }
    [super viewWillAppear:YES];
}
-(void) viewWillDisappear:(BOOL)animated
{
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.finaldate = [ACTAPP_DELEGATE getdate:ACTPDFDate] ;
    [updateVINDB save];
    [super viewWillDisappear:YES];
}

- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = signimage.bounds;
    
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    
    [view.layer renderInContext:ctx];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
                            
-(void) Home
    {
        signimage.image = nil;
        datebtn.titleLabel.text = nil;

        [self dismissModalViewControllerAnimated:NO];
        
    }
-(void)ok
{
    
    if([datebtn.titleLabel.text length]==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please select the date." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        
        if(signimage.image)
        {
            
            [ACTAPP_DELEGATE setCarView:signimage.image forkey:ACTScreenShotSign];
            // [ACTAPP_DELEGATE saveimages:[self captureView:signimage] fileName:ACTScreenShotSignfull];
            [SaveData saveCarImg:[self captureView:signimage] forKey:ACTScreenShotSign filename:ACTScreenShotSignfull];
        }
        [ACTAPP_DELEGATE setdate:datebtn.titleLabel.text forkey:ACTPDFDate];
        [self updateSQL];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"pdfgenerate" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void) updateSQL
{
    updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    updateVINDB.finaldate = [ACTAPP_DELEGATE getdate:ACTPDFDate] ;
    [updateVINDB save];
}
/*-(BOOL) isSelect:(NSInteger)val
{
    if (val == 0) {
        if (signimage.image == nil || [datebtn.titleLabel.text isEqualToString:@""]) okbtn.enabled = NO;
        else okbtn.enabled = YES;
    }
        
}*/

-(void)showview1:(id)sender
{
        okbtn.enabled = YES;
        UIViewController *imageView = [[UIViewController alloc] init];
        UIView *popoverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 600)];
        popoverview.backgroundColor = [UIColor clearColor];
        imageView.view = popoverview;
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 750, 44)];
        UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(Done)];
        UIBarButtonItem *barbtn1 = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clear)];
        
               
        NSArray *bar = [NSArray arrayWithObjects:barbtn1,barbtn, nil];
        [toolbar setItems:bar];
        [popoverview addSubview:toolbar];
        [popoverview addSubview:signimage];
        
        imageView.contentSizeForViewInPopover = CGSizeMake(750, 260);
        signimage.image = [ACTAPP_DELEGATE getCarView:ACTScreenShotSign];
        
        //create a popover controller
        popoverController = [[UIPopoverController alloc] initWithContentViewController:imageView];
        popoverController.delegate = self;
        
        //refrence to the button pressed within the current view
        [popoverController presentPopoverFromRect:CGRectMake(100, 100, 600, 600) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];                              //release the popover content
        
        [popoverview release]; 
        [imageView release];
      
   }
-(void)Done
{   
    
    
    [signbtn setImage:signimage.image forState:UIControlStateNormal];
     [popoverController dismissPopoverAnimated:YES];
    
    if (signimage.image == nil)    {
        okbtn.enabled = NO;
    }
    else
    {
        okbtn.enabled = YES;
    }

    /*NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    [signbtn setImage:image forState:UIControlStateNormal];
    [popoverController dismissPopoverAnimated:YES];
    [signimage removeFromSuperview];
    [popoverController release];*/
}
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}

-(void)clear
{
    signimage.image = nil;
    datebtn.titleLabel.text = nil;
    [signbtn setImage:nil forState:UIControlStateNormal];
    [datebtn setTitle:nil forState:UIControlStateNormal];
    return;
}

-(void)datepicker1
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
        [popoverController presentPopoverFromRect:CGRectMake(700, 300, 120, 120) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES]   ;                              //release the popover content
        [pickView release];
        [barbtn release];
        [popoverView release];
    }
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    ACTReleaseNil(popoverController);
}
-(void) ok1
{
   
    NSDateFormatter *datefr = [[NSDateFormatter alloc]init];
    [datefr setDateFormat:@"MM/dd/YYYY"];
    NSString *date = [datefr stringFromDate:datepicker1.date];
    NSLog(@"date %@",date);
    ACTReleaseNil(datefr);
    [datebtn setTitle:date forState:UIControlStateNormal];
    [popoverController dismissPopoverAnimated:YES];
    [ACTAPP_DELEGATE setdate:date forkey:ACTPDFDate];
 
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) dealloc
{
    NSLog(@"sign %@",[signViewController superclass]);
    ACTReleaseNil(signimage);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return  UIInterfaceOrientationIsLandscape(interfaceOrientation);
   
}

@end
