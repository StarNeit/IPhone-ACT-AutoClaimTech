//
//  CreatePDF.m
//  ACT
//
//  Created by Innoppl Technologies on 26/07/12.
//  Copyright (c) 2012 Innoppl. All rights reserved.
//

#import "CreatePDF.h"
#import "JSON.h"
#import "SaveData.h"
#import "VINDB.h"


@interface CreatePDF (Private)
- (void) generatePdfWithFilePath: (NSString *)thefilePath;
- (void)drawPageNumber:(NSInteger)pageNum;
- (void) drawBorder;
- (void) drawText;
- (void) drawLine;
- (void) drawHeader;
- (void) drawImage;
@end


@implementation CreatePDF

-(id) init
{
    pageSize = CGSizeMake(612, 792);
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [[NSString alloc] initWithFormat:@"%@",[[arrayPaths objectAtIndex:0] stringByAppendingPathComponent:@"test.pdf"]];
    [self generatePdfWithFilePath:path];
}


#pragma mark - Private Methods
- (void) drawBorder
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor darkGrayColor];    
    CGRect rectFrame = CGRectMake(kBorderInset, kBorderInset, pageSize.width-kBorderInset*2, pageSize.height-kBorderInset*2);
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
}

- (void)drawPageNumber:(NSInteger)pageNumber
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 52.0/256.0, 112.0/256.0, 168.0/256.0, 1.0);
    NSString* pageNumberString = [NSString stringWithFormat:@"Page %d", pageNumber];
    UIFont* theFont = [UIFont systemFontOfSize:12];
    
    CGSize pageNumberStringSize = [pageNumberString sizeWithFont:theFont
                                               constrainedToSize:pageSize
                                                   lineBreakMode:UILineBreakModeWordWrap];

    CGRect stringRenderingRect = CGRectMake(kBorderInset,
                                            pageSize.height - 40.0,
                                            pageSize.width - 2*kBorderInset,
                                            pageNumberStringSize.height);
    
   // stringRenderingRect = CGRectMake(70, 100, 200, 50);
    
    [pageNumberString drawInRect:stringRenderingRect withFont:theFont lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (void) drawHeader
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 52.0/256.0, 112.0/256.0, 168.0/256.0, 1.0);
    
    NSString *textToDraw = @"SUMMARY";
    
   // UIFont *font = [UIFont systemFontOfSize:24.0];
    UIFont *font = [UIFont fontWithName:@"Bodoni 72" size:26.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset) lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (void) drawLine
{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, kLineWidth);
    
    CGContextSetStrokeColorWithColor(currentContext, [UIColor darkGrayColor].CGColor);
    
    CGPoint startPoint = CGPointMake(kMarginInset + kBorderInset, kMarginInset + kBorderInset + 40.0);
    CGPoint endPoint = CGPointMake(pageSize.width - 2*kMarginInset -2*kBorderInset, kMarginInset + kBorderInset + 40.0);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawImage
{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotSignaturefull];
    UIImage * demoImage = [UIImage imageWithContentsOfFile:path];
    [demoImage drawInRect:CGRectMake(50,410, 300, 50)];
    
    NSString *car1 = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotRightViewFull];
    UIImage * carimage1 = [UIImage imageWithContentsOfFile:car1];
    [carimage1 drawInRect:CGRectMake(50,510, 150, 100)];
    
    NSString *car2 = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotLeftViewFull];
    UIImage * carimage2 = [UIImage imageWithContentsOfFile:car2];
    [carimage2 drawInRect:CGRectMake(220,510, 150, 100)];

    NSString *car3 = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotFrontViewFull];
    UIImage * carimage3 = [UIImage imageWithContentsOfFile:car3];
    [carimage3 drawInRect:CGRectMake(390,510, 150, 100)];

    NSString *car4 = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotRearViewFull];
    UIImage * carimage4 = [UIImage imageWithContentsOfFile:car4];
    [carimage4 drawInRect:CGRectMake(50,630, 150, 100)];

    NSString *car5 = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotTopViewFull];
    UIImage * carimage5 = [UIImage imageWithContentsOfFile:car5];
    [carimage5 drawInRect:CGRectMake(220,630, 150, 100)];

}

- (void) generatePdfWithFilePath: (NSString *)thefilePath
{
    UIGraphicsBeginPDFContextToFile(thefilePath, CGRectZero, nil);
    
    NSInteger currentPage = 0;
    BOOL done = NO;
    /*  page 1  */
    do 
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        [self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
        
        //Draw text fo our header.
        [self drawHeader];
        
        //Draw a line below the header.
        [self drawLine];
        
        [self drawPage1];
        done = YES;
    } 
    while (!done);
    do 
    {
        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        [self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
              
        [self drawPage2];
        done = YES;
    } 
    while (!done);
    do 
    {
        int Page = [[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey] intValue];
        if(Page == 0)
        {

        //Start a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        //Draw a page number at the bottom of each page.
        currentPage++;
        [self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
        [self drawPage3];
        done = YES;
        }
    } 
    while (!done);
       // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}
-(BOOL) isFilePath:(NSString*)path
{
    NSFileManager *filemng = [NSFileManager defaultManager];
    BOOL isDir = YES;
    // NSError *error;
    if([filemng fileExistsAtPath:path isDirectory:&isDir]) return YES;
    else return NO;
}

-(void) drawPage1
{
    UIView *pdfview = [[UIView alloc] initWithFrame:CGRectMake(25, 80, 550, 670)];
    pdfview.backgroundColor = [UIColor whiteColor];
    UILabel *lbl1 = [self customLabel:@"Vehicle Info" initFrame:CGRectMake(45, 10, 250, 60)];
    [pdfview addSubview:lbl1];
    UILabel *lbl2 = [self customLabel:@"Customer Info" initFrame:CGRectMake(350, 10, 250, 60)];
    [pdfview addSubview:lbl2];
    
    VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    
     /**********************Vehicle Info Details*******************************/
    
    NSMutableString *velobj = [[NSMutableString alloc] init];
    NSArray *arrobj = [[NSArray alloc] initWithObjects:@"Claim Number", @"Make",@"Model",@"Year",@"Color",@"Mileage",@"VIN",@"Cont.Material",@"W/S Pitted", nil];
    for (int i =0; i<arrobj.count; i++) {
        
        [velobj appendFormat:@"%@\n", [arrobj objectAtIndex:i]];
    }
    float height = arrobj.count*20;
    UILabel *vehiclelbls = [self customLabel:velobj  initFrame:CGRectMake(10, 50, 90, height)];
    vehiclelbls.numberOfLines = arrobj.count;
    vehiclelbls.backgroundColor = [UIColor clearColor];
    vehiclelbls.font=[UIFont fontWithName:@"Arial"size:14.0];
    [pdfview addSubview:vehiclelbls];
    
    NSMutableString *velstr = [[NSMutableString alloc] init];
    NSString *jsonStr = updatedimg.vehicleJson;
    //NSLog(@"jsonStr %@",jsonStr);
    NSDictionary *dict = [jsonStr JSONValue];
    NSArray *arr;
    if (dict) {
        arr = [[NSArray alloc] initWithObjects:[ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"claim_num"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"make"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"model"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"year"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"color"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"mileage"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"vin_num"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"contaminant"]],
               [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"windshield"]], nil];
    }
    for (int i =0; i<arr.count; i++) {
        [velstr appendFormat:@"%@\n", [arr objectAtIndex:i]];
    }
    float hei = arr.count*20;
    UILabel *vehileobjs = [self customLabel:velstr initFrame:CGRectMake(120, 50, 175, hei)];
    vehileobjs.font=[UIFont fontWithName:@"Arial"size:14.0];
    vehileobjs.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
    vehileobjs.numberOfLines = arr.count;
    vehileobjs.backgroundColor = [UIColor clearColor];
    [pdfview addSubview:vehileobjs];
    
     /**********************Customer Info Details*******************************/
    
    NSMutableString *custobj = [[NSMutableString alloc] init];
    NSArray *custarrobj = [[NSArray alloc] initWithObjects:@"Customer",@"Date",@"Project",@"Technician",@"Address1",@"Address2",@"City",@"State",@"Zipcode",@"License",@"Phone", nil];
    for (int i =0; i<custarrobj.count; i++) {
        
        [custobj appendFormat:@"%@\n", [custarrobj objectAtIndex:i]];
    }
    float heightcust = custarrobj.count*20;
    UILabel *customer = [self customLabel:custobj initFrame:CGRectMake(300, 50, 100, heightcust)];
    customer.numberOfLines = custarrobj.count;
    customer.font=[UIFont fontWithName:@"Arial"size:14.0];
    [pdfview addSubview:customer];
    
    NSMutableString *custstr = [[NSMutableString alloc] init];
    NSString *jsonStr1 = updatedimg.customerJson;
    NSDictionary *dict1 = [jsonStr1 JSONValue];
    NSArray *custarr;
    if (dict1) {
        custarr = [[NSArray alloc] initWithObjects:[ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"cust_name"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"date"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"project"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"tech_id"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"address_one"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"address_two"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"city"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"state"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"zip_code"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"license_num"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"phone_num"]], nil];
    }
    NSLog(@"DICT1 %@",dict1);
    for (int i =0; i<custarr.count; i++) {
        
        [custstr appendFormat:@"%@\n", [custarr objectAtIndex:i]];
    }
    float heightcustobj = custarr.count*20;
    UILabel *customerobj = [self customLabel:custstr initFrame:CGRectMake(430, 50, 150, heightcustobj)];
    customerobj.numberOfLines = custarr.count;
    customerobj.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
    customerobj.font=[UIFont fontWithName:@"Arial"size:14.0];
    [pdfview addSubview:customerobj];
    
    int heightAdd = 50;
    
           /**********************Signature Labels and Images*******************************/
    
    int isPage = [[ACTAPP_DELEGATE getUserDefault:ACTPageSign] intValue];
    if(isPage ==1)
    {   
        NSString *signauthor = @"Pre-existing damages inspection was authorized by client";
        UILabel *sign1 = [self customLabel:signauthor initFrame:CGRectMake(10, 200+heightAdd, 600, 50)];
        [pdfview addSubview:sign1];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *val;
        
        if (standardUserDefaults) 
            val = [standardUserDefaults objectForKey:ACTLoginDetails];
        int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
        
        NSString *accept;
        if(org == 1)
        {
            accept =  @"I hereby authorize Auto Claim Technology to make repairs to my vehicle. I have been notified of pre-existing damages as stated in this app and hold no liability against Auto Claim Technology for pre-existing damages. In the case of disagreement, Auto Claim Technology may exercise the right to use an independent adjustment firm.";
        }
        else
        {
            accept =  @"I hereby authorize Dent Zone Companies, Inc. to make repairs to my vehicle. I have been notified of pre-existing damages as stated in this app and hold no liability against Dent Zone Companies, Inc. for pre-existing damages. In the case of disagreement, Dent Zone Companies, Inc. may exercise the right to use an independent adjustment firm.";
        }

        UILabel *acc = [self customLabel:accept initFrame:CGRectMake(10, 250+heightAdd, 550, 70)];
        acc.backgroundColor = [UIColor clearColor];
        acc.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        acc.numberOfLines = 4;
        acc.font = [UIFont fontWithName:@"Arial"size:14.0]; 
        [pdfview addSubview:acc];
        
      /*  NSString *date1 = [ACTAPP_DELEGATE emptyStr:updatedimg.presigndate];
        UILabel *date1lbl = [self customLabel:date1 initFrame:CGRectMake(460, 330, 100, 50)];
        date1lbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        date1lbl.font = [UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:date1lbl]; */

    }
    else
    {
        NSString *signdeny = @"Pre-existing damages inspection was denied by client";
        UILabel *sign2 = [self customLabel:signdeny initFrame:CGRectMake(10, 200+heightAdd, 600, 50)];
        [pdfview addSubview:sign2];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *val;
        
        if (standardUserDefaults) 
            val = [standardUserDefaults objectForKey:ACTLoginDetails];
        int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
        NSString *deny;
        if(org == 1)
        {
            deny = @"I have chosen not to inspect my vehicle with an Auto Claim Technology representative and therefore, will not hold Auto Claim Technology responsible for any pre-existing damages(scratches, rock chips, door dings, etc.)";

        }
        else
        {
            deny = @"I have chosen not to inspect my vehicle with an Dent Zone Companies, Inc. representative and therefore, will not hold Dent Zone Companies, Inc. responsible for any pre-existing damages(scratches, rock chips, door dings, etc.)";
        }
        UILabel *denylbl = [self customLabel:deny initFrame:CGRectMake(10, 250+heightAdd, 550, 50)];
        denylbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        denylbl.font = [UIFont fontWithName:@"Arial"size:14.0]; 
        denylbl.numberOfLines = 4;
        [pdfview addSubview:denylbl];
        
       /* NSString *date2 = [ACTAPP_DELEGATE emptyStr:updatedimg.presigndate];
        UILabel *date2lbl = [self customLabel:date2 initFrame:CGRectMake(460, 330, 100, 50)];
        date2lbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        date2lbl.font = [UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:date2lbl];*/

    }
    NSString *Date = @"Date";
    UILabel *datelbl = [self customLabel:Date initFrame:CGRectMake(400, 330+heightAdd, 50, 50)];
    [pdfview addSubview:datelbl];
    
    NSString *date1 = updatedimg.presigndate;
    UILabel *date1lbl = [self customLabel:date1 initFrame:CGRectMake(460, 330+heightAdd, 100, 50)];
    date1lbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
    date1lbl.font = [UIFont fontWithName:@"Arial"size:14.0];
    [pdfview addSubview:date1lbl];
    
    UIImageView *signature = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:updatedimg.signatureview]];
    signature.frame = CGRectMake(20, 330+heightAdd, 300, 70);
    [pdfview addSubview:signature];
    
    /******************************Damage Images********************************************/
    
    NSString *damage = @"Damage Illustration";
    UILabel *damagelbl = [self customLabel:damage initFrame:CGRectMake(10, 405+heightAdd, 600, 50)];
    [pdfview addSubview:damagelbl];
   
    NSMutableArray *imagearray = [[NSMutableArray alloc] init];   
    
    NSString *carimage1 = [NSString stringWithFormat:@"%@",updatedimg.leftCarView];
    if([self isFilePath:carimage1])
        [imagearray addObject:carimage1];
    
    NSString *carimage2 = [NSString stringWithFormat:@"%@",updatedimg.rearCarView];
    if([self isFilePath:carimage2])
        [imagearray addObject:carimage2];
    
    NSString *carimage3 = [NSString stringWithFormat:@"%@",updatedimg.rightCarView];
    if([self isFilePath:carimage3])
        [imagearray addObject:carimage3];
    
    NSString *carimage4 = [NSString stringWithFormat:@"%@",updatedimg.frontCarView];
    if([self isFilePath:carimage4])
        [imagearray addObject:carimage4];
    
    NSString *carimage5 = [NSString stringWithFormat:@"%@",updatedimg.topCarView];
    if([self isFilePath:carimage5])
        [imagearray addObject:carimage5];
    
    
    for (int i = 0; i<[imagearray count]; i++) {
        
        UIImageView *carimage1 = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[imagearray objectAtIndex:i]]];

        if (i<3) {
            carimage1.frame = CGRectMake(20+150*i, 455+heightAdd, 100, 65);
        }else
        {
            int j = i-3;
            carimage1.frame = CGRectMake(20+150*j, 555 +heightAdd, 100, 65);
        }
        [pdfview addSubview:carimage1];
    }
    
    UIGraphicsBeginImageContextWithOptions(pdfview.bounds.size, pdfview.opaque, 0.0);
    [pdfview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawInRect:pdfview.frame];
    
    //ACTReleaseNil(pdfview);
}
-(void)drawPage2
{
    UIView *pdfview = [[UIView alloc] initWithFrame:CGRectMake(30, 25, 550, 725)];
    pdfview.backgroundColor = [UIColor whiteColor];
    
    /************************Car Photographs***************************************/
    
    NSString *textphoto = @"Car Photographs";
    UILabel *photolbl = [self customLabel:textphoto initFrame:CGRectMake(10, 10, 600, 50)];
    [pdfview addSubview:photolbl];
   
    VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    
   // NSArray *photoarr = [ACTAPP_DELEGATE getCameraArray:ACTScreenShotCamera];
    for (int i=1; i<updatedimg.damageCarImgCount+1; i++)
    {
        NSString  *path = [NSString stringWithFormat:@"%@/custom_pic_%d.jpg",updatedimg.baseImgPath,i];
        
        CGFloat x=50, y;
        if(i<=4)
        {
            x = i*110;
            y = 70.00;
        }
        if(i>=5 && i<=8)
        {
            int j = i-4;
            x = j*110;
            y = 190.00;
        }
        if(i>=9)
        {
            int k = i-8;
            x = k*110;
            y = 310.00;
        }
        UIImageView *photo = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:path]];
        photo.frame = CGRectMake(x, y, 100, 100);
        [pdfview addSubview:photo];
    }
    /*******************************PDR Estimate********************************/
    int Page = [[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey] intValue];
    if(Page == 0)
    {
        NSString *textpdr = @"PDR Estimate";
        UILabel *pdrlbl = [self customLabel:textpdr initFrame:CGRectMake(10, 410, 600, 50)];
        [pdfview addSubview:pdrlbl];
        
        UIImageView *pdrimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pagebg_pdr(1).png"]];
        pdrimage.frame = CGRectMake(10, 470, 500, 30);
        [pdfview addSubview:pdrimage];
        
        NSString *pdrstr = updatedimg.releasePdr;
        NSArray *pdrdict1 = [[pdrstr JSONValue] objectForKey:@"releasePdr"];
        int i = 0;
        
        if(pdrdict1 )
        {
            NSMutableString *areaName = [[NSMutableString alloc] init];
            NSMutableString *sizeRange = [[NSMutableString alloc] init];
            NSMutableString *dentName = [[NSMutableString alloc] init];
            NSMutableString *sub_total = [[NSMutableString alloc] init];
            
            for (NSDictionary *dic in pdrdict1 ) {
                if (i < 10) {
                    [areaName appendFormat:@"%@\n",[dic objectForKey:@"area_name"]];
                    [sizeRange appendFormat:@"%@\n",[dic objectForKey:@"dent_range_name"]];
                    [dentName appendFormat:@"%@\n",[dic objectForKey:@"dent_size_name"]];
                    [sub_total appendFormat:@"%@\n",[dic objectForKey:@"dent_charges"]];
                }
                i++;
            }
            float height = pdrdict1.count*20;
            UILabel *arealbl = [self customLabel:areaName initFrame:CGRectMake(20, 510, 150, height)];
            arealbl.numberOfLines = pdrdict1.count;
            arealbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
            arealbl.font=[UIFont fontWithName:@"Arial"size:14.0];
            [pdfview addSubview:arealbl];
           
            UILabel *sizelbl = [self customLabel:sizeRange initFrame:CGRectMake(150, 510, 150, height)];
            sizelbl.numberOfLines = pdrdict1.count;
            sizelbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
            sizelbl.font=[UIFont fontWithName:@"Arial"size:14.0];
            [pdfview addSubview:sizelbl];
           
            UILabel *dentlbl = [self customLabel:dentName initFrame:CGRectMake(290, 510, 150, height)];
            dentlbl.numberOfLines = pdrdict1.count;
            dentlbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
            dentlbl.font=[UIFont fontWithName:@"Arial"size:14.0];
            [pdfview addSubview:dentlbl];
            
            UILabel *totallbl = [self customLabel:sub_total initFrame:CGRectMake(400, 510, 150, height)];
            totallbl.numberOfLines = pdrdict1.count;
            totallbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
            totallbl.font=[UIFont fontWithName:@"Arial"size:14.0];
            [pdfview addSubview:totallbl];
        }
    }
    else
    {
        NSString *reciptsign = @"Receipt of Satisfaction";
        UILabel *signlbl = [self customLabel:reciptsign initFrame:CGRectMake(10, 420, 600, 50)];
        [pdfview addSubview:signlbl];
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *val;
        
        if (standardUserDefaults) 
            val = [standardUserDefaults objectForKey:ACTLoginDetails];
        int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
        NSString *final;
        if(org == 1)
        {
            final = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Auto Claim Technology. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Auto Claim Technology. If paid by another party, I hereby authorize payment to be made directly to Auto Claim Technology, of a sum representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
        }
        else
        {
            final = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Dent Zone Companies, Inc. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Dent Zone Companies, Inc. If paid by another party, I hereby authorize payment to be made directly to Dent Zone Companies, Inc., of a sum representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
        }

        UILabel *finallbl = [self customLabel:final initFrame:CGRectMake(10, 460, 540, 130)];
        finallbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        finallbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        finallbl.backgroundColor = [UIColor clearColor];
        finallbl.numberOfLines = 6;
        [pdfview addSubview:finallbl];
        
        VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
        
        UIImageView *signimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:updatedimg.finalsignature]];
        signimage.frame = CGRectMake(20, 600, 300, 80);
        [pdfview addSubview:signimage];
        
        NSString *reciptdate = @"Date";
        UILabel *datelbl = [self customLabel:reciptdate initFrame:CGRectMake(400, 600, 50, 50)];
        [pdfview addSubview:datelbl];
        
        NSString *pdfdate = [ACTAPP_DELEGATE emptyStr:updatedimg.finaldate];
        UILabel *date = [self customLabel:pdfdate initFrame:CGRectMake(450, 600, 100, 50)];
        date.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        date.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:date];

    }
       
    UIGraphicsBeginImageContextWithOptions(pdfview.bounds.size, pdfview.opaque, 0.0);
    [pdfview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawInRect:pdfview.frame];
    
   // ACTReleaseNil(pdfview);
}
-(void) drawPage3
{
    VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",[ACTAPP_DELEGATE getUserDefault:ACTVIN]]];
    UIView *pdfview = [[UIView alloc] initWithFrame:CGRectMake(30, 80, 550, 670)];
    pdfview.backgroundColor = [UIColor whiteColor];
    
     NSString *str1 = [ACTAPP_DELEGATE getdate:ACT_OverPdr];
   
    NSDictionary *dic = [str1 JSONValue];
  //  NSLog(@"dic %@",dic);
    
    BOOL isEmpty = NO;
    for(id key in [dic allKeys])
    {
      //  NSLog(@"key %@ val %@",key,[dic objectForKey:key]);
        if ([[dic objectForKey:key] length] == 0) {
            
            isEmpty = YES;
        }        
    }
    
    if(!isEmpty)
    {
        
        NSString *overstr = updatedimg.releaseoverpdr;
        NSMutableString *areastr = [[NSMutableString alloc] init];
        NSMutableString *dentstr = [[NSMutableString alloc] init];
        NSMutableString *totalstr = [[NSMutableString alloc] init];
        NSDictionary *dic = [overstr JSONValue];
        if(dic)
        {
            [areastr appendFormat:@"%@",[dic objectForKey:@"car_area_name"]];
            [dentstr appendFormat:@"%@",[dic objectForKey:@"dent_range_id"]];
            [totalstr appendFormat:@"%@",[dic objectForKey:@"dent_charges"]];
        }
        UILabel *arealbl = [self customLabel:areastr initFrame:CGRectMake(20, 55, 150, 20)];
        arealbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        arealbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:arealbl];
        
        UILabel *sizelbl = [self customLabel:dentstr initFrame:CGRectMake(150, 55, 150, 20)];
        sizelbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        sizelbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:sizelbl];
        
        UILabel *overlbl = [self customLabel:@"Oversize" initFrame:CGRectMake(290, 55, 150, 20)];
        overlbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        overlbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        [pdfview addSubview:overlbl];
                
        UILabel *totallbl = [self customLabel:totalstr initFrame:CGRectMake(400, 55, 150, 20)];
        totallbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        totallbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:totallbl];
        
        NSMutableString *pdrobj = [[NSMutableString alloc] init];
        NSMutableString *parts = [[NSMutableString alloc] init];
        
        NSString *jsonstr2 = updatedimg.releaseEstimate;
        NSDictionary *dictionary = [jsonstr2 JSONValue];
        NSArray *arr;
        if (dictionary)
        {
            
            arr = [[NSArray alloc] initWithObjects:[dictionary objectForKey:@"parts"],[dictionary objectForKey:@"r_n_i"],[dictionary objectForKey:@"grand_total"], nil];
        }
        
        NSArray *arrobj = [[NSArray alloc] initWithObjects:@"Parts($)",@"R&I($)",@"Grand Total($)", nil];
        for (int i =0; i<arrobj.count; i++) 
        {
            [pdrobj appendFormat:@"%@\n", [arrobj objectAtIndex:i]];
            [parts appendFormat:@"%@\n", [arr objectAtIndex:i]];
            
        }
        float height1 = arrobj.count*20;
        UILabel *pdrlbl = [self customLabel:pdrobj initFrame:CGRectMake(20, 100, 150, height1)];
        pdrlbl.numberOfLines = arrobj.count;
        pdrlbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        pdrlbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:pdrlbl];
        
        UILabel *pdr = [self customLabel:parts initFrame:CGRectMake(400, 100, 150, height1)];
        pdr.numberOfLines = arrobj.count;
        pdr.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        pdr.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:pdr];
        
    }
    else{
        NSMutableString *pdrobj = [[NSMutableString alloc] init];
        NSMutableString *parts = [[NSMutableString alloc] init];
        
        NSString *jsonstr2 = updatedimg.releaseEstimate;
        NSDictionary *dictionary = [jsonstr2 JSONValue];
        NSArray *arr;
        if (dictionary)
        {
            
            arr = [[NSArray alloc] initWithObjects:[dictionary objectForKey:@"parts"],[dictionary objectForKey:@"r_n_i"],[dictionary objectForKey:@"grand_total"], nil];
        }
        
        NSArray *arrobj = [[NSArray alloc] initWithObjects:@"Parts($)",@"R&I($)",@"Grand Total($)", nil];
        for (int i =0; i<arrobj.count; i++) 
        {
            [pdrobj appendFormat:@"%@\n", [arrobj objectAtIndex:i]];
            [parts appendFormat:@"%@\n", [arr objectAtIndex:i]];
            
        }
        float height1 = arrobj.count*20;
        UILabel *pdrlbl = [self customLabel:pdrobj initFrame:CGRectMake(20, 20, 150, height1)];
        pdrlbl.numberOfLines = arrobj.count;
        pdrlbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        pdrlbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:pdrlbl];
        
        UILabel *pdr = [self customLabel:parts initFrame:CGRectMake(400, 20, 150, height1)];
        pdr.numberOfLines = arrobj.count;
        pdr.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        pdr.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:pdr];

    }
    
        
        NSString *reciptsign = @"Receipt of Satisfaction";
        UILabel *signlbl = [self customLabel:reciptsign initFrame:CGRectMake(10, 400, 610, 50)];
        [pdfview addSubview:signlbl];
    
       NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
       NSArray *val;

       if (standardUserDefaults) 
        val = [standardUserDefaults objectForKey:ACTLoginDetails];
       int org = [[[val objectAtIndex:0] objectForKey:@"org_id"] intValue];
       NSString *final;
       if(org == 1)
        {
          final = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Auto Claim Technology. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Auto Claim Technology. If paid by another party, I hereby authorize payment to be made directly to Auto Claim Technology, of a sum  representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
        }
       else
       {
          final = @"Repairs which I have authorized to vehicle have been repaired satisfactorily by Dent Zone Companies, Inc. Futhermore, I have inspected my vehicle thoroughly and no physical damages have occurred as a result of the cleaning and/or repair by Dent Zone Companies, Inc. If paid by another party, I hereby authorize payment to be made directly to Dent Zone Companies, Inc., of a sum representing the repair cost, which payment fully discharges all claims I have on account of the damages to my vehicle.";
       }
        UILabel *finallbl = [self customLabel:final initFrame:CGRectMake(10, 440, 540, 130)];
        finallbl.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        finallbl.font=[UIFont fontWithName:@"Arial"size:14.0];
        finallbl.backgroundColor = [UIColor clearColor];
        finallbl.numberOfLines = 6;
        [pdfview addSubview:finallbl];
        
        UIImageView *signimage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:updatedimg.finalsignature]];
        signimage.frame = CGRectMake(20, 580, 300, 80);
        [pdfview addSubview:signimage];
        
        NSString *reciptdate = @"Date";
        UILabel *datelbl = [self customLabel:reciptdate initFrame:CGRectMake(400, 580, 50, 50)];
        [pdfview addSubview:datelbl];
        
        NSString *pdfdate = [ACTAPP_DELEGATE emptyStr:updatedimg.finaldate];
        UILabel *date = [self customLabel:pdfdate initFrame:CGRectMake(450, 580, 100, 50)];
        date.textColor = [UIColor colorWithRed:67.0/256 green:119.0/256.0 blue:0127.0/256.0 alpha:1.0];
        date.font=[UIFont fontWithName:@"Arial"size:14.0];
        [pdfview addSubview:date];

    UIGraphicsBeginImageContextWithOptions(pdfview.bounds.size, pdfview.opaque, 0.0);
    [pdfview.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [img drawInRect:pdfview.frame];
    //ACTReleaseNil(pdfview);
}

-(UILabel*) customLabel:(NSString*)str initFrame:(CGRect)frame
{
	UILabel *customLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
	customLabel.adjustsFontSizeToFitWidth = YES;
    customLabel.text = str;
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.font=[UIFont fontWithName:@"Arial"size:18.0];
    customLabel.textColor = [UIColor colorWithRed:52.0/256.0 green:112.0/256.0 blue:168.0/256.0 alpha: 1.0];
    return customLabel;
}
@end
