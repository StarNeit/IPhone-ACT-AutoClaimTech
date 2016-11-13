//
//  SummeryViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 15/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SummeryViewController.h"
#import "CameraViewController.h"

@interface SummeryViewController ()

@end

@implementation SummeryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
NSMutableArray *summaryarray;
NSMutableDictionary *dictionary;
NSMutableDictionary *Cutomdict;
NSArray *array;
NSArray *vehiclearray;
NSArray *customerarray;
NSArray *cameraarray;
NSArray *vecKey;
NSArray *vecVal;
NSArray *cusKey;
NSArray *cusVal;

- (void)viewDidLoad
{
    //[self.navigationController setNavigationBarHidden:YES];
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    [rightRecognizer release];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    [super viewDidLoad];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 1024, 500) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    //tableview.rowHeight = 65.0f;
    [self.view addSubview:tableview];
    
    self.navigationItem.title = @"Summary";
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [camerabtn setBackgroundImage:[UIImage imageNamed:@"camera_1.png"] forState:UIControlStateHighlighted];
    camerabtn.frame = CGRectMake(820, 660, 51, 69);
    [camerabtn addTarget:self action:@selector(Takepic) forControlEvents:UIControlEventTouchUpInside];
    camerabtn.backgroundColor = [UIColor clearColor];
    [self.view addSubview:camerabtn];
    
    UIButton *homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home.png"] forState:UIControlStateNormal];
    [homebtn setBackgroundImage:[UIImage imageNamed:@"home_1.png"] forState:UIControlStateHighlighted];
    homebtn.frame = CGRectMake(700, 660, 51, 69);
    homebtn.backgroundColor = [UIColor clearColor];
    [homebtn addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homebtn];
    
      
    UIButton *keybtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // keybtn.enabled =NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    // [keybtn addTarget:self action:@selector(presskeypad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
   // settingbtn.enabled =NO;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    //  [settingbtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];

    
    summaryarray = [[NSMutableArray alloc] initWithObjects:@"Vehicle Info",@"Customer Info",@"Pre existing Damages Inspection was authorized by clien",@"Pre-Existing Damages inspection was denied by client",@"Damage Images",@"Car Photographs",@"PDR Estimate", nil];
    array = [[NSArray alloc] initWithObjects:@"9",@"8",@"1",@"1",@"1",@"1",@"1",nil];
    
    NSLog(@"make %@",[ACTAPP_DELEGATE carimagearray]);
    
    cameraarray = [[NSArray alloc] initWithArray:[ACTAPP_DELEGATE getCameraArray:ACTScreenShotCamera] copyItems:YES];
    vecVal = [[NSArray alloc] initWithArray:[NSArray arrayWithObjects:[ACTAPP_DELEGATE getdate:ACTVEHICLEClaimNumber],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOMake],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOYear],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOModel],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOClaim],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOColor],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOMiliage],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOContaminant],[ACTAPP_DELEGATE getdate:ACTVEHICLEINFOWindShield],nil]];
    
    // NSLog(@"count %d key %d",[vecVal count],[vecKey count]);
    dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[NSArray arrayWithObjects:@"Claim Number", @"Make",@"Year",@"Model",@"Vin",@"Color",@"Miliage",@"Cont.material",@"Windshield", nil] forKey:@"veckey"];
    
    [dictionary setObject:[NSArray arrayWithObjects:[self getData:ACTVEHICLEClaimNumber],[self getData:ACTVEHICLEINFOMake],[self getData:ACTVEHICLEINFOYear],[self getData:ACTVEHICLEINFOModel],[self getData:ACTVEHICLEINFOClaim],[self getData:ACTVEHICLEINFOColor],[self getData:ACTVEHICLEINFOMiliage],[self getData:ACTVEHICLEINFOContaminant],[self getData:ACTVEHICLEINFOWindShield],nil] forKey:@"vecVal"];
    
    NSLog(@"dic %@",dictionary);
    
    Cutomdict = [[NSMutableDictionary alloc] init];
    [Cutomdict setObject:[NSArray arrayWithObjects:@"Cutomer",@"Date",@"project",@"Technician",@"Address1",@"Address2",@"license Number",@"phone Number", nil] forKey:@"cuskey"];
    [Cutomdict setObject:[NSArray arrayWithObjects:[self getData:ACTCUSTOMERINFOCustomer],[self getData:ACTCUSTOMERINFODate],[self getData:ACTCUSTOMERINFOProject],[self getData:ACTCUSTOMERINFOTechinician],[self getData:ACTCUSTOMERINFOAddress1],[self getData:ACTCUSTOMERINFOAddress2],[self getData:ACTCUSTOMERINFOScense],[self getData:ACTCUSTOMERINFOPhone] ,nil] forKey:@"cusVal"];

    // Do any additional setup after loading the view from its nib.
}

-(NSString*) getData:(id)val
{
    if ([ACTAPP_DELEGATE getdate:val]) {
        return [ACTAPP_DELEGATE getdate:val];
    }else {
        return @"";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
        
    return [summaryarray objectAtIndex:section];
   }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 50.0f;	
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [summaryarray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 5){
    
    NSUInteger devide=[cameraarray count] / 5;
    
    if ([cameraarray count] % 5 > 0) {
        
        devide+=1;
        
    } else {
        
        devide=devide;
    }
        return devide;
    }

    return [[array objectAtIndex:section] intValue];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath .section == 4)
       return 280.0f;
    else if(indexPath.section == 5)
        return 150.0f;
    else
        return 65.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
   // NSInteger section = indexPath.section;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellidentifier"];
    if (cell != nil) {
        cell = nil;
    }
    if (cell==nil) {

        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellidentifier"] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        
       if(indexPath.section == 0)
       {
           UILabel *vehiclelabel = [self customlbl:CGRectMake(20,10,200,40) lblTXt:[[dictionary objectForKey:@"veckey"] objectAtIndex:indexPath.row] lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
           [cell addSubview:vehiclelabel];
           
           UILabel *textlbl =[self customlbl:CGRectMake(300,10,200,40) lblTXt:[[dictionary objectForKey:@"vecVal"]objectAtIndex:indexPath.row] lblFont:ACTBasicFontBold(17) lblColor:ACTLabelColor];
           textlbl.backgroundColor = [UIColor whiteColor];
           [cell addSubview:textlbl];

       }
       if(indexPath.section == 1)
       {
           
         UILabel *customerlabel = [self customlbl:CGRectMake(20,10,200,40) lblTXt:[[Cutomdict objectForKey:@"cuskey"]objectAtIndex:indexPath.row] lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
          [cell addSubview:customerlabel];
           
           UILabel *textlbl =[self customlbl:CGRectMake(300,10,200,40) lblTXt:[[Cutomdict objectForKey:@"cusVal"]objectAtIndex:indexPath.row] lblFont:ACTBasicFontBold(17) lblColor:ACTLabelColor];
           textlbl.backgroundColor = [UIColor whiteColor];
           [cell addSubview:textlbl];
       }
    if(indexPath.section == 2)
    {
        UIImageView *signature = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotSignature]];
        signature.frame = CGRectMake(50,10,350,50);
        signature.backgroundColor = [UIColor whiteColor];
        [cell addSubview:signature];
    }
    if(indexPath.section == 3)
    {
        
        UIImageView *signature1 = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotSignature1]];
        signature1.frame = CGRectMake(50,10,350,50);
        signature1.backgroundColor = [UIColor whiteColor];
        [cell addSubview:signature1];
        
    }
    if(indexPath.section == 4)
    {
        UIImageView *rightcarimageview = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotRightViewFull]];
        rightcarimageview.frame =CGRectMake(20, 20, 200, 100);
        [cell addSubview:rightcarimageview];
        
        UIImageView *leftcarimageview = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotLeftViewFull]];
        leftcarimageview.frame =CGRectMake(400, 20, 200, 100);
       [cell addSubview:leftcarimageview];
        
        UIImageView *frontcarimageview = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotFrontViewFull]];
        frontcarimageview.frame =CGRectMake(800, 20, 200, 100);
        [cell addSubview:frontcarimageview];
        
        UIImageView *rearcarimageview = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotRearViewFull]];
        rearcarimageview.frame =CGRectMake(20, 140, 200, 100);
        [cell addSubview:rearcarimageview];
        
        UIImageView *topcarimageview = [[UIImageView alloc] initWithImage:[ACTAPP_DELEGATE getCarView:ACTScreenShotTopViewFull]];
        topcarimageview.frame =CGRectMake(400, 140, 200, 100);
        [cell addSubview:topcarimageview];
    
    }
    if(indexPath.section == 5)
    {
        int x=indexPath.row;
        x=x*5;
        NSLog(@"imageArr %@",cameraarray);
        UIImageView *img = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x]];
        img.frame = CGRectMake(30,20,100,100);
        [cell addSubview:img]; 
        
        if((x+1) >= cameraarray.count){
            
        } else if( (x+2)>=cameraarray.count) {
            
            UIImageView *img1 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+1]];
            img1.frame = CGRectMake(230,20,100,100);
            [cell addSubview:img1];
            
        } else if( (x+3)>=cameraarray.count) {
            
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,20,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,20,100,100);
            [cell addSubview:img3];
            
        }else if( (x+4)>=cameraarray.count) {
            
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,20,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,20,100,100);
            [cell addSubview:img3];
            
            UIImageView *img4 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+3]];
            img4.frame = CGRectMake(630,20,100,100);
            [cell addSubview:img4];
            
        }else {
            UIImageView *img2 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+1]];
            img2.frame = CGRectMake(230,20,100,100);
            [cell addSubview:img2];
            
            UIImageView *img3 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+2]];
            img3.frame = CGRectMake(430,20,100,100);
            [cell addSubview:img3];
            
            UIImageView *img4 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+3]];
            img4.frame = CGRectMake(630,20,100,100);
            [cell addSubview:img4];
            
            UIImageView *img5 = [[UIImageView alloc] initWithImage:[cameraarray objectAtIndex:x+4]];
            img5.frame = CGRectMake(830,20,100,100);
            [cell addSubview:img5];
            
        }

}
    if(indexPath.section ==  6)
    {
        UILabel *arealbl = [self customlbl:CGRectMake(20,10,200,40) lblTXt:@"Area of Cars"lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
        [cell addSubview:arealbl];
        UILabel *dentlbl = [self customlbl:CGRectMake(270,10,200,40) lblTXt:@"Dents"lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
        [cell addSubview:dentlbl];
        UILabel *sizelbl = [self customlbl:CGRectMake(520,10,200,40) lblTXt:@"Avg Size"lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
        [cell addSubview:sizelbl];
        UILabel *sublbl = [self customlbl:CGRectMake(770,10,200,40) lblTXt:@"Sub Total"lblFont:ACTBasicFontBold(17) lblColor:ACTTitleColor];
        [cell addSubview:sublbl];
}
   
    return cell;
}
-(void) Takepic
{
    CameraViewController *camera = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
     [self.navigationController pushViewController:camera animated:YES];
    [camera release];
}
-(UILabel *)customlbl:(CGRect)frame lblTXt:(NSString *)str lblFont:(UIFont *)font lblColor:(UIColor *)color
{
    UILabel *lbl = [[[UILabel alloc] initWithFrame:frame] autorelease];
    lbl.text = str;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = UITextAlignmentLeft;
    lbl.font = font;
    lbl.textColor = color;
    return lbl;
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    PDR1ViewController *front =[[PDR1ViewController alloc]initWithNibName:@"PDR1ViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [front release];
}
-(void)home
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
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
