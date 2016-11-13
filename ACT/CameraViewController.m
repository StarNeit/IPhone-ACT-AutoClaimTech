//
//  CameraViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"
#import "CarTopViewController.h"
#import "SaveData.h"
#import "JSON.h"
#import "signatureViewController.h"\

#define NUMBER_IMAGE 6
@interface CameraViewController ()

@end

@implementation CameraViewController
//NSArray *imagearray;
NSMutableArray *imageArr;
int countImg = 0;

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
    [super viewDidLoad];

    countImg = 0;
    imageArr = [[NSMutableArray alloc] init];
    [self.navigationController setNavigationBarHidden:YES];
     UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandle:)];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    leftRecognizer.delegate = self;
    [self.view addGestureRecognizer:leftRecognizer];
    [leftRecognizer release];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    rightRecognizer.delegate = self;
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
      
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    bg.hidden = NO;
    [self.view addSubview:bg];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 25, 1024, 490) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 150.0f;
    [self.view addSubview:tableview];
    
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
    camerabtn.enabled =YES;
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    camerabtn.backgroundColor = [UIColor clearColor];
    [camerabtn addTarget:self action:@selector(callPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:camerabtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    //[settingbtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
    
    progressAlert = [[UIAlertView alloc] initWithTitle:@"Loading Camera"
											   message:@"Please wait..."
											  delegate: self
									 cancelButtonTitle: nil
									 otherButtonTitles: nil];
    progressAlert.tag = 100;
	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
	[progressAlert addSubview:activityView];
	[activityView startAnimating];
	[progressAlert show];    

    if ([ACTAPP_DELEGATE getCarView:ACTScreenShotCamera]) {
        if (imageArr) {
            NSArray *arr = [ACTAPP_DELEGATE getCameraArray:ACTScreenShotCamera];
            for(UIImage *im in arr)
            {
                [imageArr addObject:im];
            }
        }
    }  
    
    [self performSelector:@selector(callPicker) withObject:nil afterDelay:0.1f];
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
   [super viewWillAppear:YES];
}

-(void) viewWillDisappear:(BOOL)animated
{
    if (imageArr) {
         [ACTAPP_DELEGATE saveCameraView:imageArr forkey:ACTScreenShotCamera];
    }
    [super viewWillDisappear:YES];
}
-(void) callPicker
{
    
    if(imageArr.count>=12)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Only 12 photos allowed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        if (progressAlert.tag == 100) {
            [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
            progressAlert.tag = 111;
        }
        if (imageArr.count<12) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imagePicker =[[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.allowsEditing = NO;
                [imagePicker shouldAutorotate];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
        }
        
    }
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  //Access the uncropped image from info dictionary
    UIImage *IMG = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    countImg++;
    
  //[ACTAPP_DELEGATE saveimages:IMG fileName:[NSString stringWithFormat:@"image_%d.jpg",countImg]]; 
    [SaveData saveCarImg:IMG forKey:ACTScreenShotCamera filename:[NSString stringWithFormat:@"%d",countImg]];
        
  //Save image
    [imageArr addObject:IMG];
    [self dismissModalViewControllerAnimated:YES];
     if (imageArr.count<NUMBER_IMAGE) {
         [self performSelector:@selector(callPicker) withObject:nil afterDelay:0.7f];
     }
    [tableview reloadData];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
   
  if(imageArr.count<NUMBER_IMAGE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"A minimum of 6 photos should be taken." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
    {
        signatureViewController *summary = [[signatureViewController alloc] initWithNibName:@"signatureViewController" bundle:nil];
        [self.navigationController pushViewController:summary animated:YES];
        //[summary release];
  }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 300 && buttonIndex == 0)
    {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    }
    else
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        if(imageArr.count<NUMBER_IMAGE)
        {
            if([title isEqualToString:@"OK"])
            {
                [self callPicker];
            }
        }
    }
    
}
-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Do you really want to go to Home page? You will lose any unsaved data." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag =300;
    [alert show];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger devide=[imageArr count] / 5;
    
    if ([imageArr count] % 5 > 0) {
        
        devide+=1;
        
    } else {
        
        devide=devide;
    }
    return devide;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell != nil) {
        cell = nil;
    }
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle=UITableViewCellEditingStyleNone;
        
        int x=indexPath.row;
        x=x*5;
        UIImageView *img = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x]];
        img.frame = CGRectMake(30,40,100,100);
        [cell addSubview:img]; 
        
        if((x+1) >= imageArr.count){
  
        } else if( (x+2)>=imageArr.count) {
            
            UIImageView *img1 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+1]];
            img1.frame = CGRectMake(230,40,100,100);
            [cell addSubview:img1];

        } else if( (x+3)>=imageArr.count) {
            
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,40,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,40,100,100);
            [cell addSubview:img3];

        }else if( (x+4)>=imageArr.count) {
            
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,40,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,40,100,100);
            [cell addSubview:img3];
            
            UIImageView *img4 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+3]];
            img4.frame = CGRectMake(630,40,100,100);
            [cell addSubview:img4];
            
        }else {
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,40,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,40,100,100);
            [cell addSubview:img3];
            
            UIImageView *img4 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+3]];
            img4.frame = CGRectMake(630,40,100,100);
            [cell addSubview:img4];
            
            UIImageView *img5 = [[UIImageView alloc] initWithImage:[imageArr objectAtIndex:x+4]];
            img5.frame = CGRectMake(830,40,100,100);
            [cell addSubview:img5];

        }
            } 
    return cell;
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    CarTopViewController *top =[[CarTopViewController alloc]initWithNibName:@"CarTopViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
   // [top release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc
{
    ACTReleaseNil(imageArr);
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
