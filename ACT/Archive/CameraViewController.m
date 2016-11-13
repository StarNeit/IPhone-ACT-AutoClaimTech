//
//  CameraViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 07/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"
#import "CarTopViewController.h"
#import "PDRViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    [rightRecognizer setNumberOfTouchesRequired:1];
    rightRecognizer.delegate = self;
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
    
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    //     bg.backgroundColor = [UIColor blueColor];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    bg.hidden = YES;
    [self.view addSubview:bg];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self performSelector:@selector(loadcam) withObject:nil afterDelay:0.4f];
}


-(void) loadcam
{

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if (imagePickerController == nil) 
             imagePickerController = [[UIImagePickerController alloc] init];
        
       
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;                
        imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentModalViewController:imagePickerController animated:YES];
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker 
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    // Dismiss the image selection, hide the picker and
    //show the image view with the picked image
    
    //imagePickerController.view.hidden = NO;
   // bg.image = image;
   // bg.hidden = YES;
  //  [window bringSubviewToFront:imageView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissModalViewControllerAnimated:YES];
    NSLog(@"info%@",info);
    
    [self performSelector:@selector(loadcam) withObject:nil afterDelay:0.2f];
    
    
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //[self dismissModalViewControllerAnimated:YES];
    if (buttonIndex == 0) {
       // [self performSelector:@selector(loadcam) withObject:nil afterDelay:0.2f];
    }
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    PDRViewController *pdr =[[PDRViewController alloc]initWithNibName:@"PDRViewController" bundle:nil];
    [self.navigationController pushViewController:pdr animated:YES];
    [pdr release];    
    
    
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    CarTopViewController *top =[[CarTopViewController alloc]initWithNibName:@"CarTopViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [top release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
