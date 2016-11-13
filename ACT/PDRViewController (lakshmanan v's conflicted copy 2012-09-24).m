//
//  PDRViewController.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 06/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PDRViewController.h"
#import "CarTopViewController.h"
#import "PDR1ViewController.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "config.h"


@interface PDRViewController ()

@end

@implementation PDRViewController
@synthesize enteraction;
@synthesize managedobject;

BOOL isdent;
NSArray *area;
NSArray *dent;
NSArray *size;
NSMutableArray *arrayofrow;
int tableIndexPath;
int rowCount;
int selectBtnTag;
NSMutableArray *overarea;
NSMutableArray *overdent;
NSArray *overcarid;
NSDictionary *overdic;
int caridstr;
- (void)viewDidLoad
{
    
    btnTag = [[NSMutableDictionary alloc] init];
    chargesArray = [[NSMutableArray alloc] init];
    
    rowCount =1;
       
    [self.navigationController setNavigationBarHidden:YES];
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
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seconpage.png"]];
    bg.frame = CGRectMake(0, 0, 1024, 748);
    [self.view addSubview:bg];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 300, 1024, 200) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 70.0f;
    [self.view addSubview:tableview];
    
    UIButton *camerabtn = [UIButton buttonWithType:UIButtonTypeCustom];
    camerabtn.enabled = NO;
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
    keybtn.enabled =NO;
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard.png"] forState:UIControlStateNormal];
    [keybtn setBackgroundImage:[UIImage imageNamed:@"keybpard_1.png"] forState:UIControlStateHighlighted];
    keybtn.frame = CGRectMake(760, 660, 51, 69);
    keybtn.backgroundColor = [UIColor clearColor];
    // [keybtn addTarget:self action:@selector(presskeypad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:keybtn];
    
    UIButton *settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingbtn.enabled =YES;
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settings_1.png"] forState:UIControlStateHighlighted];
    [settingbtn addTarget:self action:@selector(Notes) forControlEvents:UIControlEventTouchUpInside];
    settingbtn.frame = CGRectMake(880, 660, 51, 69);
    settingbtn.backgroundColor = [UIColor clearColor];
    //  [settingbtn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingbtn];
    
    UILabel *titlelbl = [[UILabel alloc] initWithFrame:CGRectMake(430, 10, 300, 100)];
    titlelbl.font=[UIFont fontWithName:@"Gill Sans"size:34.0];
    titlelbl.text = @"PDR Estimate";
    titlelbl.backgroundColor = [UIColor clearColor];
    titlelbl.textColor=[UIColor whiteColor];
    [self.view addSubview:titlelbl];
    
             /***************OverSize Part****************/
    UILabel *overlbl = [self customLabel:@"Oversize" initFrame:CGRectMake(100, 75, 220, 50)];
    overlbl.font=[UIFont fontWithName:@"Gill Sans"size:28.0];
    [self.view addSubview:overlbl];
    
    UILabel *overarealbl = [self customLabel:@"Areas of Car" initFrame:CGRectMake(140, 110, 220, 50)];
    [self.view addSubview:overarealbl];
    
    UILabel *overdentlbl = [self customLabel:@"# of Dents" initFrame:CGRectMake(500, 110, 220, 50)];
    [self.view addSubview:overdentlbl];
    
    UILabel *oversubtlbl = [self customLabel:@"Sub Total($)" initFrame:CGRectMake(810, 110, 220, 50)];
    [self.view addSubview:oversubtlbl];
    
    overareabtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    overareabtn.tag = 50;
    overareabtn.backgroundColor = [UIColor clearColor];
    overareabtn.frame = CGRectMake(100, 160, 220, 50);
    overareabtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [overareabtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [overareabtn addTarget:self action:@selector(catageroy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:overareabtn];
    
    overdentbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    overdentbtn.tag = 51;
    overdentbtn.backgroundColor = [UIColor clearColor];
    overdentbtn.frame = CGRectMake(500 , 160, 120, 50);
    overdentbtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:18.0f];
    [overdentbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [overdentbtn addTarget:self action:@selector(catageroy:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:overdentbtn];
    
    overarea = [[NSMutableArray alloc] initWithObjects:@"Hood",@"Roof",@"Van/SUV/X-Cab",@"Deck Lid",@"L Top Roof Rail",@"L Fender",@"LF Door",@"LR Door",@"L Quarter",@"R Top Roof Rail",@"R Fender",@"RF Door",@"RR Door",@"R Quarter",@"Cowl",@"Metal Sunroof", nil];
    
    overdent = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45", nil];
    
    overtotallbl = [self customLabel:@"" initFrame:CGRectMake(800, 160, 120, 50)];
    overtotallbl.backgroundColor = [UIColor whiteColor];
    overtotallbl.textColor = [UIColor blackColor];
    overtotallbl.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:overtotallbl];
    
                 /******************Regular part*****************/
    UILabel *regularlbl = [self customLabel:@"Regular" initFrame:CGRectMake(100, 225, 220, 50)];
    regularlbl.font=[UIFont fontWithName:@"Gill Sans"size:28.0];
    [self.view addSubview:regularlbl];
    
       
    UILabel *arealabl = [self customLabel:@"Areas of Car" initFrame:CGRectMake(140, 260, 220, 50)];
    [self.view addSubview:arealabl];
    
    UILabel *dentlbl = [self customLabel:@"# of Dents" initFrame:CGRectMake(410, 260, 120, 50)];
    [self.view addSubview:dentlbl];
    
    UILabel *avglbl = [self customLabel:@"Avg Size" initFrame:CGRectMake(630, 260, 120, 50)];
    [self.view addSubview:avglbl];
    
    UILabel *sublbl = [self customLabel:@"Sub Total($)" initFrame:CGRectMake(810, 260, 135, 50)];
    [self.view addSubview:sublbl];
    
    UILabel *pdrtotal = [self customLabel:@"PDR Total($)" initFrame:CGRectMake(680, 500, 135, 50)];
    [self.view addSubview:pdrtotal];
    
    Total = [[UILabel alloc] initWithFrame:CGRectMake(820, 500, 150, 50)];
    Total.font=[UIFont fontWithName:@"Gill Sans"size:34.0];
    Total.backgroundColor = [UIColor clearColor];
    Total.textColor = [UIColor whiteColor];
    [self.view addSubview:Total];
    
    pickerview = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 350, 400)];
    pickerview.showsSelectionIndicator = YES;
    pickerview.delegate = self;
    pickerview.dataSource = self;
    
    [super viewDidLoad];
    
        
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:ACT_CarDent]];
	[request setDelegate:self];
	request.shouldPresentCredentialsBeforeChallenge = YES;
    [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"1" forKey:@"action"]];
    [request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[request startAsynchronous];

    
	progressAlert = [[UIAlertView alloc] initWithTitle:@"Loading data"
											   message:@"Please wait..."
											  delegate: self
									 cancelButtonTitle: nil
									 otherButtonTitles: nil];
	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
	[progressAlert addSubview:activityView];
	[activityView startAnimating];
	[progressAlert show];
	[progressAlert release];
    
    arrayofrow = [[NSMutableArray alloc] init];

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
    [arrayofrow removeAllObjects];
   NSString *str = [ACTAPP_DELEGATE getdate:ACT_PDREstimate];
     NSDictionary *dict = [str JSONValue];
    if([dict objectForKey:@"releasePdr"])
    {
        for (NSDictionary *ar in [dict objectForKey:@"releasePdr"]) {
            
            Charges *cha = [[Charges alloc] init];
            cha.areaId = [ar objectForKey:@"car_area_id"];
            cha.areaName =[ar objectForKey:@"area_name"];
            cha.dentId = [ar objectForKey:@"dent_range_id"];
            cha.sizeId = [ar objectForKey:@"dent_size_id"];
            cha.sizeRange = [ar objectForKey:@"dent_size_name"];
            cha.dentName = [ar objectForKey:@"dent_range_name"];
            cha.subTotal = [ar objectForKey:@"dent_charges"];
           [arrayofrow addObject:cha];
            [self total];
        }
    }
    else{
        Charges *charg = [[Charges alloc] init];
        charg.areaId = @"";
        charg.dentId = @"";
        charg.sizeId = @"";
        charg.sizeRange = @"";
        charg.areaName = @"";
        charg.dentName = @"";
        charg.subTotal = @"";
        
         [arrayofrow addObject:charg];
        //ACTReleaseNil(charg);
    }
    
    NSString *str1 = [ACTAPP_DELEGATE getdate:ACT_OverPdr];
    NSDictionary *dic1 = [str1 JSONValue];
    NSLog(@"DIC %@",dic1);
    if(dic1)
    {
       NSDictionary *dic1 = [str1 JSONValue];
        [overareabtn setTitle:[dic1 objectForKey:@"car_area_name"] forState:UIControlStateNormal];
        [overdentbtn setTitle:[dic1 objectForKey:@"dent_range_id"] forState:UIControlStateNormal];
        overtotallbl.text = [dic1 objectForKey:@"dent_charges"];
        
    }
    
       
    [super viewWillAppear:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    if ([arrayofrow count] > 0) {
        NSMutableString *PDR = [[NSMutableString alloc ]init];
        for (int i = 0; i < [arrayofrow count]; i++) {
            
            Charges *chars = [arrayofrow objectAtIndex:i];
            [PDR appendFormat:@"{\"car_area_id\" : \"%@\",\"area_name\" :\"%@\", \"dent_range_id\" : \"%@\" , \"dent_range_name\" :\"%@\", \"dent_size_id\" : \"%@\" , \"dent_size_name\" : \"%@\" , \"dent_charges\" : \"%@\"},",chars.areaId,chars.areaName,chars.dentId,chars.dentName,chars.sizeId,chars.sizeRange,chars.subTotal];
        }
         
        NSString *str = [PDR substringWithRange:NSMakeRange(0, [PDR length]-1)];
        NSString *fullFormatJson = [NSString stringWithFormat:@"{\"releasePdr\":[%@],\"PDFTotal\":\"%@\"}",str,Total.text];
        
        updateVINDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
        updateVINDB.releasePdr = fullFormatJson;
         [ACTAPP_DELEGATE setdate:updateVINDB.releasePdr forkey:ACT_PDREstimate];
        [updateVINDB save];
        ACTReleaseNil(PDR);
        
        
        NSString *overstr = [NSString stringWithFormat:@"{\"car_area_id\":\"%@\",\"car_area_name\":\"%@\",\"dent_range_id\":\"%@\",\"dent_charges\":\"%@\"}",[ACTAPP_DELEGATE emptyStr:[NSString stringWithFormat:@"%i",caridstr]],[ACTAPP_DELEGATE emptyStr:overareabtn.titleLabel.text],[ACTAPP_DELEGATE emptyStr:overdentbtn.titleLabel.text],[ACTAPP_DELEGATE emptyStr:overtotallbl.text]];
        updateVINDB.releaseoverpdr = overstr;
        NSLog(@"overstr %@",overstr);
        [ACTAPP_DELEGATE setdate:updateVINDB.releaseoverpdr forkey:ACT_OverPdr];
        [updateVINDB save];
}
    [super viewWillDisappear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayofrow count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString *CellIdentifier = @"CellView";
    
    CellView *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    
       if(cell!=nil)
        cell=nil;
	
    if (cell == nil) {
        cell = [[[CellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (arrayofrow > 0) {
        
       Charges *cls = [arrayofrow objectAtIndex:indexPath.row];
        UIButton *add;
        if (indexPath.row == 0) {
           add = [UIButton buttonWithType:UIButtonTypeCustom];
            [add setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
            add.frame = CGRectMake(50, 20, 39 , 39);
            [add setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [add addTarget:self action:@selector(addMore:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:add];
        }else {
            add = [UIButton buttonWithType:UIButtonTypeCustom];
            add.frame = CGRectMake(50, 20, 39 , 39);
            [add setBackgroundImage:[UIImage imageNamed:@"del(1).png"] forState:UIControlStateNormal];
            [add setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [add addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
            add.tag = ACTTBRowRemoveBtn + indexPath.row;
            [cell addSubview:add];
        }
        
        cell.btn1.tag = ACTTBRowPicker1Btn+indexPath.row;
        cell.btn2.tag = ACTTBRowPicker2Btn+indexPath.row;
        cell.btn3.tag = ACTTBRowPicker3Btn+indexPath.row;
        cell.label.tag = ACTTBRowlabel+indexPath.row;
       
            [cell.btn1 setTitle:cls.areaName forState:UIControlStateNormal];

            [cell.btn2 setTitle:cls.dentName forState:UIControlStateNormal];

            [cell.btn3 setTitle:cls.sizeRange forState:UIControlStateNormal];

            cell.label.text = cls.subTotal;
         // cell.textLabel.textAlignment = UITextAlignmentCenter;
    
        
        [cell.btn1 addTarget:self action:@selector(pickview:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn2 addTarget:self action:@selector(pickview:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn3 addTarget:self action:@selector(pickview:) forControlEvents:UIControlEventTouchUpInside];
    }
    
return cell;
}
-(void)addMore:(UIButton*)btn
{    
    if(arrayofrow.count <10)
    {
    Charges *charg = [[Charges alloc] init];
             
    charg.areaId = @"";
    charg.dentId = @"";
    charg.sizeId = @"";
    charg.sizeRange = @"";
    charg.areaName = @"";
    charg.dentName = @"";
    [arrayofrow addObject:charg];
    [tableview reloadData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Not exist more than 10." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}

-(void)updateData:(NSInteger)arrIndex valueIndex:(NSInteger)index valueChange:(NSString*)str setIDs:(NSString*)ids
{
    NSLog(@"arrayofrow %d  arrIndex %d",[arrayofrow count],arrIndex);
    Charges *selectCharges = [arrayofrow objectAtIndex:arrIndex];

    if (index == 1) { selectCharges.areaName = str;  selectCharges.areaId = ids;}
    else if(index == 2){ selectCharges.dentName = str; selectCharges.dentId = ids;}
    else if(index == 3){ selectCharges.sizeRange = str; selectCharges.sizeId = ids;}
    else if(index == 4){ selectCharges.subTotal = str;}
    
    [arrayofrow removeObjectAtIndex:arrIndex];
    [arrayofrow insertObject:selectCharges atIndex:arrIndex];
    [tableview reloadData];
} 

-(void)deleteRow:(UIButton*)btn
{
    int indexValue = btn.tag - ACTTBRowRemoveBtn;
    [arrayofrow removeObjectAtIndex:indexValue];
    [tableview reloadData];
    [self total];
}

- (void)leftSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer
{
    
    BOOL IsError = NO;
    

    for (Charges *cls in arrayofrow) {
        
        if ([cls.areaName length] == 0 || [cls.dentName length] == 0 || [cls.sizeRange length] == 0) {
            NSLog(@"yes %@ = %@ = %@",cls.areaName,cls.dentName,cls.sizeRange);
            IsError = YES;
        }
        
    }
    
        if(IsError)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please fill or delete the empty row." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        else{
            PDR1ViewController *top = [[PDR1ViewController alloc]initWithNibName:@"PDR1ViewController" bundle:nil];
            top.pdrtext = Total.text;
            [self.navigationController pushViewController:top animated:YES];
        }
        
}
- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    
   /* CarTopViewController *front =[[CarTopViewController alloc]initWithNibName:@"CarTopViewController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];*/
    //[front release];
}
-(void) catageroy:(id)sender
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 350, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
        
    UIViewController *pickView = [[UIViewController alloc] init];
    UIView *popoverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350, 400)];
    popoverview.backgroundColor = [UIColor clearColor];
    [popoverview addSubview:toolbar];
    pickView.view = popoverview;
    pickView.contentSizeForViewInPopover = CGSizeMake(340, 260);
   
    if(sender == overareabtn)
    {
        NSLog(@"area count %d",[overarea count]);
        if([overarea count] == 0)
        {
            overarea = [[NSMutableArray alloc] initWithObjects:@"Hood",@"Roof",@"Van/SUV/X-Cab",@"Deck Lid",@"L Top Roof Rail",@"L Fender",@"LF Door",@"LR Door",@"L Quarter",@"R Top Roof Rail",@"R Fender",@"RF Door",@"RR Door",@"R Quarter",@"Cowl",@"Metal Sunroof", nil];
        }
        
        pickerview.tag = 50;
        [pickerview reloadAllComponents];
        if (!overareabtn.titleLabel.text) {
            [overareabtn setTitle:[overarea objectAtIndex:0] forState:UIControlStateNormal];
        }else
        {
            int count=0;
            for(NSString *str in overarea)
            {
                NSRange r = [[str lowercaseString] rangeOfString:[overareabtn.titleLabel.text lowercaseString]];
                if(r.location != NSNotFound)
                {
                    [pickerview selectRow:count inComponent:0 animated:NO];
                }
                count++;
            }
        }

        
        //[pickerview reloadAllComponents];
    }
    else if(sender == overdentbtn)
    {
        NSLog(@"count %d",[overdent count]);
        if([overdent count] == 0)
        {
            overdent = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45", nil];

        }
        pickerview.tag = 51;
        [pickerview reloadAllComponents];
        if (!overdentbtn.titleLabel.text) {
            [overdentbtn setTitle:[overdent objectAtIndex:0] forState:UIControlStateNormal];
        }else
        {
            int count=0;
            for(NSString *str in overdent)
            {
                if([str intValue] == [overdentbtn.titleLabel.text intValue])
                { 
                    [pickerview selectRow:count inComponent:0 animated:NO];
                }
                count++;
            }
        }

    }
        
    [pickerview reloadAllComponents];
   [popoverview addSubview:pickerview]; 
    popoverController = [[UIPopoverController alloc] initWithContentViewController:pickView];
    popoverController.delegate = self;
    
    CGRect frameVal = CGRectMake([sender frame].origin.x-40, [sender frame].origin.y+50, 250, 50);
    [popoverController presentPopoverFromRect:frameVal inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];  
    
    [pickView release];
    [popoverview release];

}
-(void)pickview:(id)sender
{
    selectBtnTag = [sender tag];
    UIButton *selectBtn = (UIButton*)[self.view viewWithTag:selectBtnTag];

    NSString *selectRowStr =@"";
    NSString *selectRowID =@"";
    int valIndex;
    
    NSArray *tempArr;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 350, 44)];
    UIBarButtonItem *barbtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    NSArray *bar = [NSArray arrayWithObject:barbtn];
    [toolbar setItems:bar];
    
        
    UIViewController *pickView = [[UIViewController alloc] init];
    UIView *popoverview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 350, 400)];
    popoverview.backgroundColor = [UIColor clearColor];
    [popoverview addSubview:toolbar];
    pickView.view = popoverview;
    pickView.contentSizeForViewInPopover = CGSizeMake(340, 260);
    
       
    BOOL isUpdate = NO;
    if([sender tag] >= 2000 && [sender tag] <= 2999)
    {
        tempArr = [area copy];
        pickerview.tag = 100;
        tableIndexPath = selectBtnTag - 2000;
        selectRowStr = [[area objectAtIndex:0] objectForKey:@"area_name"];
        selectRowID = [[area objectAtIndex:0] objectForKey:@"car_area_id"];
        valIndex = 1;
        if (!selectBtn.titleLabel.text) {
            isUpdate = YES;
            [selectBtn setTitle:selectRowStr forState:UIControlStateNormal];
        }
    }else if([sender tag] >= 3000 && [sender tag] <= 3999)
    {
        tempArr = [dent copy];
        pickerview.tag = 200;
        tableIndexPath = selectBtnTag - 3000;
        selectRowStr = [[dent objectAtIndex:0] objectForKey:@"dent_range_name"];
        selectRowID = [[dent objectAtIndex:0] objectForKey:@"dent_range_id"];
        valIndex = 2;
       if (!selectBtn.titleLabel.text) {
            isUpdate = YES;
            [selectBtn setTitle:selectRowStr forState:UIControlStateNormal];
       }
    }else if([sender tag] >= 4000 && [sender tag] <= 4999)
    {
        tempArr = [size copy];
        pickerview.tag = 300;
        tableIndexPath = selectBtnTag - 4000;
        selectRowStr = [[size objectAtIndex:0] objectForKey:@"dent_size_name"];
        selectRowID = [[size objectAtIndex:0] objectForKey:@"dent_size_id"];
        valIndex = 3;
        if (!selectBtn.titleLabel.text) {
            isUpdate = YES;
            [selectBtn setTitle:selectRowStr forState:UIControlStateNormal];
        }
    }
    
    if (isUpdate) {
        [pickerview selectRow:0 inComponent:0 animated:NO];
        [self updateData:tableIndexPath valueIndex:valIndex valueChange:selectRowStr setIDs:selectRowID];
    }else{
        int count=0;
        for(NSDictionary *dict in tempArr)
        {
            NSString *str = @"";
            if (valIndex == 1) str = [dict objectForKey:@"area_name"];
            else if (valIndex == 2) str = [dict objectForKey:@"dent_range_name"];
            else if (valIndex == 3) str = [dict objectForKey:@"dent_size_name"];
            
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
            NSRange r = [[str lowercaseString] rangeOfString:[selectBtn.titleLabel.text lowercaseString]];
            if(r.location != NSNotFound)
            {
                [pickerview selectRow:count inComponent:0 animated:NO];
            }
            [pool release];
            count++;
        }
    }
    
     [popoverview addSubview:pickerview]; 
    
    [pickerview reloadAllComponents];
        
    popoverController = [[UIPopoverController alloc] initWithContentViewController:pickView];
    popoverController.delegate = self;
    
    CGRect frameVal = CGRectMake([sender frame].origin.x-40, [sender frame].origin.y+250, 250, 50);
    [popoverController presentPopoverFromRect:frameVal inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];  
   
    [pickView release];
    [popoverview release];
    [barbtn release];
}
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return NO;
}
- (void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
   
    ACTReleaseNil(popoverController);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
    NSInteger count;

    if (pickerView.tag == 100 ) {
         count = [area count];
    }
    else if(pickerView.tag == 200)
    {
        count = [dent count];
    }
    else if(pickerView.tag == 300)
    {
        count =  [size count];
    }
    else if(pickerView.tag == 50)
    {
        return [overarea count];
    }
    else if(pickerView.tag == 51)
    {
        return [overdent count];
    }
    else {
        count = 0;
    }    
    return count;
    
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
   
    NSString *str = @"";
    if (pickerView.tag == 100 ){
        
        str = [[area objectAtIndex:row] objectForKey:@"area_name"];
    }
    else if(pickerView.tag == 200)
    {
        
        str = [[dent objectAtIndex:row] objectForKey:@"dent_range_name"];
    }
    else if(pickerView.tag == 300)
    {
        str =  [[size objectAtIndex:row] objectForKey:@"dent_size_name"];
        [self act];
    }
    else if(pickerView.tag == 50)
    {
        return [overarea objectAtIndex:row];
        caridstr = row+1;
        NSLog(@"caridstr %d",caridstr);

    }
    else if(pickerView.tag == 51)
    {
        return [overdent objectAtIndex:row];
    }
    else {
        str = @"";
    }
    return str;
    
    
}
-(void) act
{
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    UIButton *btntag = (UIButton*)[self.view viewWithTag:selectBtnTag];
   
     NSString *selectRowStr =@"";
     NSString *selectRowID =@"";
     int valIndex;
    
    if (pickerView.tag == 100 ){
        valIndex = 1;
        selectRowStr = [[area objectAtIndex:row] objectForKey:@"area_name"];
        selectRowID = [[area objectAtIndex:row] objectForKey:@"car_area_id"];
        [btntag setTitle:selectRowStr forState:UIControlStateNormal];
            }
    else if(pickerView.tag == 200 )
    {
       valIndex = 2;
        selectRowStr = [[dent objectAtIndex:row] objectForKey:@"dent_range_name"];
        selectRowID = [[dent objectAtIndex:row] objectForKey:@"dent_range_id"];
        [btntag setTitle:selectRowStr forState:UIControlStateNormal];
        }
    else if(pickerView.tag == 300)
    {
        valIndex = 3;
        selectRowStr = [[size objectAtIndex:row] objectForKey:@"dent_size_name"];
        selectRowID = [[size objectAtIndex:row] objectForKey:@"dent_size_id"];
        [btntag setTitle:selectRowStr forState:UIControlStateNormal];
                
    }
    else if(pickerView.tag == 50)
    {
        NSLog(@"pmcategoryType test");
        NSString *pmcategoryType  = [overarea objectAtIndex:row];
        NSLog(@"pmcategoryType %@",pmcategoryType);
        [overareabtn setTitle:pmcategoryType forState:UIControlStateNormal];
        caridstr = row+1;
        NSLog(@"caridstr %d",caridstr);
    }
    else if(pickerView.tag == 51)
    {
        NSString *dentstr = [overdent objectAtIndex:row];
        [overdentbtn setTitle:dentstr forState:UIControlStateNormal];
    }
    else {
        selectRowStr = @"";
    }
    
    [self updateData:tableIndexPath valueIndex:valIndex valueChange:selectRowStr setIDs:selectRowID];
}
-(void)close
{
    if (pickerview.tag == 300) {
        
        [self callgetData];
    }
    else if(pickerview.tag == 51)
    {
        int overtotal = 0;
        overtotal = [overdentbtn.titleLabel.text intValue]*40;
        overtotallbl.text = [NSString stringWithFormat:@"%d",overtotal];
        [self total];
    }
    [popoverController dismissPopoverAnimated:YES];
    [pickerview removeFromSuperview];
}
int subtotaltag =0;

-(void) callgetData
{
    
    progressAlert = [[UIAlertView alloc] initWithTitle:@"Loading data"
											   message:@"Please wait..."
											  delegate: self
									 cancelButtonTitle: nil
									 otherButtonTitles: nil];
	activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
	[progressAlert addSubview:activityView];
	[activityView startAnimating];
	[progressAlert show];
	[progressAlert release];

    Charges *chars = [arrayofrow objectAtIndex:tableIndexPath];
    NSString *sizeID = chars.sizeId;
    NSString *dentID = chars.dentId;
    NSString *carID =  chars.areaId;
    subtotaltag = selectBtnTag;
    NSString *jsonData = [NSString stringWithFormat:@"{\"car_area_id\":\"%@\",\"dent_size_id\":\"%@\",\"dent_range_id\":\"%@\"}",carID,sizeID,dentID];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:ACT_DentCharges]];
	[request setDelegate:self];
	request.shouldPresentCredentialsBeforeChallenge = YES;
    [request setRequestMethod:@"POST"];    
	[request setPostValue:jsonData forKey:@"data"];
    request.shouldPresentCredentialsBeforeChallenge = YES;
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"0" forKey:@"action"]];
    [request addBasicAuthenticationHeaderWithUsername:ACT_USERNAME andPassword:ACT_PASSWORD];
    [request setDidFinishSelector:@selector(requestDone:)];
	[request setDidFailSelector:@selector(requestWentWrong:)];
	[request startAsynchronous];
}
-(void) requestDone:(ASIFormDataRequest*)request
{
    
    if([[[request userInfo] objectForKey:@"action"] intValue] == 1)
    {
        [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        area = [[NSArray alloc] initWithArray:[[[request responseString] JSONValue] objectForKey:@"car_areas"]];
        size = [[NSArray alloc] initWithArray:[[[request responseString] JSONValue] objectForKey:@"car_dent_size"]];
        dent = [[NSArray alloc] initWithArray:[[[request responseString] JSONValue] objectForKey:@"car_dent_range"]];

    }
    else
    {
        [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
        
        id isArr = [[request responseString] JSONValue];
        
        
        if([request responseStatusCode]==200)
        {
            NSString *checkKey = [NSString stringWithFormat:@"%d",subtotaltag];
            UILabel *lbl = (UILabel*)[self.view viewWithTag:subtotaltag+2000];
            lbl.textAlignment = UITextAlignmentCenter;
            
            [btnTag setObject:[NSArray arrayWithObjects:lbl.text,@"",nil] forKey:checkKey];
            lbl.font =[UIFont fontWithName:@"" size:18.0f];
            
            if ([isArr isKindOfClass:[NSDictionary class]]) {
                // lbl.text  = [NSString stringWithFormat:@"%@",[[[request responseString] JSONValue] objectForKey:@"dent_charges"]];
                lbl.text = [[[request responseString] JSONValue] objectForKey:@"dent_charges"];
            }else if ([isArr isKindOfClass:[NSArray class]]) {
                // lbl.text = [NSString stringWithFormat:@"%@",[[[[request responseString] JSONValue] objectAtIndex:0] objectForKey:@"dent_charges"]];
                lbl.text = [[[[request responseString] JSONValue] objectAtIndex:0] objectForKey:@"dent_charges"];
            }
            [self updateData:tableIndexPath valueIndex:4 valueChange:lbl.text setIDs:@""];
            
            [self total];
        }
        else if([request responseStatusCode] == 404)
        {
        }

    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
        
    }
}
-(void) total
{
    int totalVal = 0;
    
    if (arrayofrow > 0) {
        for (int i =0 ; i< [arrayofrow count]; i++)
        {
           Charges *cls = [arrayofrow objectAtIndex:i];
            totalVal += [cls.subTotal intValue];
        }
    }
        totalVal += [overtotallbl.text intValue];
        Total.text = [NSString stringWithFormat:@"%d",totalVal];
        [ACTAPP_DELEGATE setUserDefault:ACT_PDRTOTAL setObject:Total.text];
}
-(void) requestWentWrong:(ASIFormDataRequest*)request
{
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];

}
-(void) home
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
-(void) Takepic
{
    CameraViewController *camera = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
    [self.navigationController pushViewController:camera animated:YES];
    [camera release];
}

-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame 
{
	UILabel *customLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
	customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = str;
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.font=[UIFont fontWithName:@"Gill Sans"size:24.0];
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
   // ACTReleaseNil(overarea);
  //  ACTReleaseNil(overdent);
    ACTReleaseNil(area);
    ACTReleaseNil(dent);
    ACTReleaseNil(size);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
