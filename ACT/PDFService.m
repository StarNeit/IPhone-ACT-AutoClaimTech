//
//  PDFService.m
//  ACT
//
//  Created by Sathish Kumar Mariappan on 03/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PDFService.h"
#import "JSON.h"
#import "config.h"

static PDFService *_instance;


void PDFService_defaultErrorHandler(HPDF_STATUS   error_no,
                                    HPDF_STATUS   detail_no,
                                    void         *user_data)
{
    PDFService_userData *userData = (PDFService_userData *)user_data;
    HPDF_Doc pdf = userData->pdf;
    PDFService *service = userData->service;
    NSString *filePath = userData->filePath;
    
    //  HPDF_ResetError(pdf)
    HPDF_Free(pdf);
    
    if (service.delegate) {
        [service.delegate service:service
         didFailedCreatingPDFFile:filePath
                          errorNo:error_no
                         detailNo:detail_no];
    }
}


@implementation PDFService

@synthesize delegate;

- (id) init
{
    self = [super init];
    if (self != nil) {
        //init code
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

+ (PDFService *)instance
{
    if (!_instance) {
        _instance = [[PDFService alloc] init];
    }
    return _instance;
}

-(BOOL) isFilePath:(NSString*)path
{
    NSFileManager *filemng = [NSFileManager defaultManager];
    BOOL isDir = YES;
   // NSError *error;
    if([filemng fileExistsAtPath:path isDirectory:&isDir]) return YES;
    else return NO;
}

- (void)createPDFFile:(NSString *)filePath fullDict:(NSMutableDictionary*)dictas
{
         /*-------------VehicleInfo---------------------*/
    NSArray *arrobj = [[NSArray alloc] initWithObjects:@"Claim Number",@"Make",@"Model",@"Year",@"Color",@"Mileage",@"VIN",@"Contaminant material",@"Windshield pitted", nil];
    NSString *jsonStr = [ACTAPP_DELEGATE getdate:ACT_RELEASEFORM_VECHICLE];
    NSDictionary *dict = [jsonStr JSONValue];
    
    NSArray *arr;
    if (dict) {
       arr = [[NSArray alloc] initWithObjects:[ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"claim_num"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"make"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"model"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"year"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"color"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"mileage"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"claim_number"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"contaminant_material"]],
              [ACTAPP_DELEGATE setTextLimits:[dict objectForKey:@"windshield"]], nil];
        
        
    }
  //  NSLog(@"arr %@",arr);
            /*-------------CustomerInfo---------------------*/
    NSArray *custarrobj = [[NSArray alloc] initWithObjects:@"Customer",@"Date",@"Project",@"Technician",@"Address1",@"Address2",@"License",@"Phone", nil];
    NSString *jsonStr1 = [ACTAPP_DELEGATE getdate:ACT_RELEASEFORM_CUSTOMER];
    NSDictionary *dict1 = [jsonStr1 JSONValue];
    NSArray *custarr;
    if (dict1) {
        custarr = [[NSArray alloc] initWithObjects:[ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"customer_name"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"date"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"project"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"technician_name"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"address_one"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"address_two"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"license_number"]],
                   [ACTAPP_DELEGATE setTextLimits:[dict1 objectForKey:@"phone_number"]], nil];
      
    }
    NSString *path = nil;
    const char *pathCString = NULL;
  //  NSLog( @"IN");
	PDFService_userData userData;
    HPDF_Doc pdf = HPDF_New(PDFService_defaultErrorHandler, &userData);
    userData.pdf = pdf;
    userData.service = self;
    userData.filePath = filePath;
    
	/*------------------ Creating Page 1----------------------*/
    HPDF_Page page1 = HPDF_AddPage(pdf);
    HPDF_Page_SetSize(page1, HPDF_PAGE_SIZE_A4, HPDF_PAGE_PORTRAIT);
	NSLog( @"IN");
     // HPDF_Page_Rectangle(page1, 15.00, 750.00, 500, 1);
   // HPDF_RGBColor c = HPDF_Page_GetRGBFill (page1);
    HPDF_Page_BeginText(page1);
   // HPDF_Page_SetRGBFill (page1, 0, 0, 5.0);
   // HPDF_Page_GetGrayStroke(page1);
    //HPDF_Page_SetTextRenderingMode (page1, HPDF_FILL);
    
    HPDF_UseJPFonts (pdf);
    HPDF_UseJPEncodings (pdf);
   
    HPDF_Font fontEnBold = HPDF_GetFont(pdf, "Helvetica-Bold", "StandardEncoding");
	HPDF_Font fontEn = HPDF_GetFont(pdf, "Helvetica", "StandardEncoding");
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 28.0);
   // HPDF_Page_SetGrayStroke(page1, HPDF_Page_GetGrayStroke(page1));
    HPDF_Page_TextOut(page1, 250.00, 800.00, [@"Summary" cStringUsingEncoding:NSShiftJISStringEncoding]);
  
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 18.0);
    HPDF_Page_TextOut(page1, 20.00, 750.00, [@"Vehicle Info" cStringUsingEncoding:NSShiftJISStringEncoding]);
    
        for (int i=0; i<arrobj.count; i++)
    {
        HPDF_Page_SetFontAndSize(page1, fontEnBold, 14.0);
        HPDF_Page_TextOut(page1, 20.00, 720.00-i*30, [[arrobj objectAtIndex:i] cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
        for (int i= 0; i<arr.count; i++) {
        
        HPDF_Page_SetFontAndSize(page1, fontEn, 12.0);
        HPDF_Page_TextOut(page1, 170.00, 720.00-i*30, [[arr objectAtIndex:i] cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 18.0);
    HPDF_Page_TextOut(page1, 320.00, 750.00, [@"Customer Info" cStringUsingEncoding:NSShiftJISStringEncoding]);
    
    for (int j=0; j<custarrobj.count; j++) {
        
        HPDF_Page_SetFontAndSize(page1, fontEnBold, 14.0);
        HPDF_Page_TextOut(page1, 320.00, 720.00-j*30, [[custarrobj objectAtIndex:j] cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    for (int j = 0; j<custarr.count; j++) {
        HPDF_Page_SetFontAndSize(page1, fontEn, 12.0);
        HPDF_Page_TextOut(page1, 420.00, 720.00-j*30, [[custarr objectAtIndex:j] cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 18.0);
    int isPage = [[ACTAPP_DELEGATE getUserDefault:ACTPageSign] intValue];
    NSLog(@"isPage %d" , isPage);
    if(isPage ==2)
    {
        HPDF_Page_TextOut(page1, 20.00, 470.00, [@"Pre-existing damages inspection was authorized by client" cStringUsingEncoding:NSShiftJISStringEncoding]);
        NSString *date1 = [ACTAPP_DELEGATE getdate:ACTScreenShotDate];
        HPDF_Page_SetFontAndSize(page1, fontEn, 13.0);
        HPDF_Page_TextOut(page1, 400.00, 400.00, [date1 cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    else 
    {
        NSLog(@"no page ");
        HPDF_Page_TextOut(page1, 20.00, 470.00, [@"Pre-existing damages inspection was denied by client" cStringUsingEncoding:NSShiftJISStringEncoding]);
        NSString *date2 = [ACTAPP_DELEGATE getdate:ACTScreenShotDate1];
        HPDF_Page_SetFontAndSize(page1, fontEn, 13.0);
        HPDF_Page_TextOut(page1, 400.00, 400.00, [date2 cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 18.0);
    HPDF_Page_TextOut(page1, 350.00, 400.00, [@"Date" cStringUsingEncoding:NSShiftJISStringEncoding]);
    HPDF_Page_TextOut(page1, 20.00, 350.00, [@"Damage Illustration" cStringUsingEncoding:NSShiftJISStringEncoding]);
    HPDF_Page_SetFontAndSize(page1, fontEnBold, 13.0);
    HPDF_Page_TextOut(page1, 250.00, 30.00, [@"page 1" cStringUsingEncoding:NSShiftJISStringEncoding]);
    HPDF_Page_EndText(page1);
   // HPDF_Page_Rectangle(page1, 15.00, 750.00, 500, 1);

    path = [[NSBundle mainBundle] pathForResource:@"line" ofType:@"png"];
    pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
    HPDF_Image lineimage = HPDF_LoadPngImageFromFile(pdf, pathCString);
    HPDF_Page_DrawImage(page1, lineimage, 15, 780.00, 530, 4);
    pathCString = [filePath cStringUsingEncoding:1];

    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotSignaturefull];
    NSLog(@"sign%@",path);
    pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
    HPDF_Image sign = HPDF_LoadJpegImageFromFile(pdf, pathCString);
    HPDF_Page_DrawImage(page1, sign, 60.00, 400.00, 250, 50);

        
    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotRightViewFull];
    NSLog(@"path %@",path);
    
    if ([self isFilePath:path])
    {
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
        HPDF_Image bgheader1 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
        HPDF_Page_DrawImage(page1, bgheader1, 35.00, 230.00, 150, 100);
    }
   
        
    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotLeftViewFull];
    if ([self isFilePath:path])
    {
         NSLog(@"path %@",path);
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
	    HPDF_Image bgheader = HPDF_LoadJpegImageFromFile(pdf, pathCString);
	    HPDF_Page_DrawImage(page1, bgheader, 200.00, 230.00, 150, 100);
    }
    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotFrontViewFull];
    if ([self isFilePath:path]) 
    {
        NSLog(@"path %@",path);
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
	    HPDF_Image bgheader2 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
	    HPDF_Page_DrawImage(page1, bgheader2, 365.00, 230.00, 150, 100);
    }   
    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotRearViewFull];
    if ([self isFilePath:path])
    {
         NSLog(@"path %@",path);
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
	    HPDF_Image bgheader3 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
	    HPDF_Page_DrawImage(page1, bgheader3, 35.00, 100.00, 150, 100);
    }  
    path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotTopViewFull];
    if ([self isFilePath:path])
    {
        NSLog(@"path %@",path);
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
	    HPDF_Image bgheader4 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
	    HPDF_Page_DrawImage(page1, bgheader4, 200.00, 100.00, 150, 100);   
    }
    pathCString = [filePath cStringUsingEncoding:1];
    
    /*-------------------Creating page 2----------------------*/
    HPDF_Page page_2;
    page_2 = HPDF_AddPage (pdf); 
   
    HPDF_Page_SetSize(page_2, HPDF_PAGE_SIZE_A4, HPDF_PAGE_PORTRAIT);
    HPDF_Page_BeginText(page_2);
    HPDF_Page_SetFontAndSize(page_2, fontEnBold, 18.0);
    
    int Page = [[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey] intValue];
    if(Page == 0)
    {
        HPDF_Page_TextOut(page_2, 20.00, 400.00, [@"PDR Estimate" cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    else{
        HPDF_Page_TextOut(page_2, 20.00, 200.00, [@"Receipt of Satisfaction" cStringUsingEncoding:NSShiftJISStringEncoding]);
        HPDF_Page_TextOut(page_2, 350.00, 100.00, [@"Date" cStringUsingEncoding:NSShiftJISStringEncoding]);
        NSString *pdfdate1 = [ACTAPP_DELEGATE getdate:ACTPDFDate];
        HPDF_Page_SetFontAndSize(page_2, fontEn, 13.0);
        HPDF_Page_TextOut(page_2, 400.00, 100.00, [pdfdate1 cStringUsingEncoding:NSShiftJISStringEncoding]);
    }
    HPDF_Page_SetFontAndSize(page_2, fontEnBold, 18.0);
    HPDF_Page_TextOut(page_2, 20.00, 800.00, [@"Car Photographs" cStringUsingEncoding:NSShiftJISStringEncoding]);
    HPDF_Page_SetFontAndSize(page_2, fontEnBold, 13.0);
    HPDF_Page_TextOut(page_2, 250.00, 30.00, [@"page 2" cStringUsingEncoding:NSShiftJISStringEncoding]);
    
      /*--------------------pdr estimate---------------------*/
    
    NSLog(@"isPage %d" , Page);
     int i = 0;
    if (Page == 0)
    {
        NSString *pdrstr = [ACTAPP_DELEGATE getdate:ACT_PDREstimate];
        NSArray *pdrdict1 = [[pdrstr JSONValue] objectForKey:@"PDR"];

        NSLog(@"dic %@",pdrdict1);
        if(pdrdict1 )
         {
            for (NSDictionary *dic in pdrdict1 ) {
                
                if (i < 5) {
                    HPDF_Page_SetFontAndSize(page_2, fontEn, 15.0);
                    HPDF_Page_TextOut(page_2, 40.00, 290.00-i*40, [[dic objectForKey:@"areaName"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_2, 190.00, 290.00-i*40, [[dic objectForKey:@"sizeRange"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_2, 330.00, 290.00-i*40, [[dic objectForKey:@"dentName"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_2, 470.00, 290.00-i*40, [[dic objectForKey:@"sub_total"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                }
                i++;
            }
        }
       
    }
    
    HPDF_Page_EndText(page_2); 

    
   NSArray *photoarr = [ACTAPP_DELEGATE getCameraArray:ACTScreenShotCamera];
    NSLog(@"photocount %d",photoarr.count);
    for (int i=1; i<photoarr.count+1; i++) {
       
         path = [NSString stringWithFormat:@"%@/image_%d.jpg",[ACTAPP_DELEGATE imageFolder],i];
         
         if ([self isFilePath:path])
         {
            NSLog(@"path %@",path);
            pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
            HPDF_Image photo1 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
             CGFloat x=5, y;
             if(i<=4)
             {
                 x = i*110;
                 y = 680.00;
             }
             if(i>=5 && i<=8)
             {
                 int j = i-4;
                 x = j*110;
                 y = 570.00;
               // HPDF_Page_DrawImage(page_2, photo1, 0.00+(i*80),580.00, 70, 70); 
             }
             if(i>=9)
             {
                 int k = i-8;
                 x = k*110;
                 y = 460.00;
             }
            HPDF_Page_DrawImage(page_2, photo1,x, y, 100, 100);  
         }
}
    if(Page == 1)
    {
        path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotSignfull];
         NSLog(@"sign%@",path);
         if([self isFilePath:path])
         {
         pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
         HPDF_Image finalsign1 = HPDF_LoadJpegImageFromFile(pdf, pathCString);
         HPDF_Page_DrawImage(page_2, finalsign1, 60.00, 100.00, 250, 70);
         }
        
    }
    
    if(Page == 0)
    {
        path = [[NSBundle mainBundle] pathForResource:@"pagebg_pdr" ofType:@"png"];
        pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
	    HPDF_Image bgheader = HPDF_LoadPngImageFromFile(pdf, pathCString);
	    HPDF_Page_DrawImage(page_2, bgheader, 35, 350.00, 520, 30);
        pathCString = [filePath cStringUsingEncoding:1];
    }
    else{
        NSLog(@"no page");
    }
           
    NSLog(@"loging");
    /*-------------------Creating page 3----------------------*/
    
    int Pageisthr = [[ACTAPP_DELEGATE getUserDefault:ACTPageEngingKey] intValue];
    if(Pageisthr == 0)
    {
   
    HPDF_Page page_3;
    page_3 = HPDF_AddPage (pdf); 
    
    HPDF_Page_SetSize(page_3, HPDF_PAGE_SIZE_A4, HPDF_PAGE_PORTRAIT);
    HPDF_Page_BeginText(page_3);
    HPDF_Page_SetFontAndSize(page_3, fontEn, 15.0);
        
            NSString *pdrstr = [ACTAPP_DELEGATE getdate:ACT_PDREstimate];
        if(i>= 5)
        {
            NSArray *pdrdict1 = [[pdrstr JSONValue] objectForKey:@"PDR"];
            
            NSLog(@"dic %@",pdrdict1);
            if(pdrdict1 )
            {
                    for (int i = 5; i<pdrdict1.count; i++) 
                    {
                        NSDictionary *dic = [pdrdict1 objectAtIndex:i];
                        NSLog(@"i %d",i);
                        HPDF_Page_SetFontAndSize(page_3, fontEn, 15.0);
                       // HPDF_Page_SetRGBStroke (page_3, 1.0, 0.0, 0.5);
                       // HPDF_Page_SetRGBStroke(page_3, 0.0, 5.0, 0.0);
                        HPDF_Page_TextOut(page_3, 40.00, 950.00-i*40, [[dic objectForKey:@"areaName"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                        HPDF_Page_TextOut(page_3, 190.00, 950.00-i*40, [[dic objectForKey:@"sizeRange"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                        HPDF_Page_TextOut(page_3, 330.00, 950.00-i*40, [[dic objectForKey:@"dentName"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                        HPDF_Page_TextOut(page_3, 470.00, 950.00-i*40, [[dic objectForKey:@"sub_total"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    }
                    HPDF_Page_SetFontAndSize(page_3, fontEnBold, 18.0);
                    NSString *jsonstr2 = [ACTAPP_DELEGATE getdate:ACT_PDRCONTID];
                    NSDictionary *dictionary = [jsonstr2 JSONValue];
                    HPDF_Page_TextOut(page_3, 35.00, 500.00, [@"Parts" cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_3, 35.00, 450.00, [@"R&I" cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_3, 35.00, 400.00, [@"GrandTotal" cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_SetFontAndSize(page_3, fontEn, 15.0);
                    HPDF_Page_TextOut(page_3, 470.00, 500.00, [[dictionary objectForKey:@"Parts"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_TextOut(page_3, 470.00, 450.00, [[dictionary objectForKey:@"R_I"] cStringUsingEncoding:NSShiftJISStringEncoding]);
                    HPDF_Page_SetFontAndSize(page_3, fontEnBold, 18.0);
                    HPDF_Page_TextOut(page_3, 470.00, 400.00, [[dictionary objectForKey:@"GrandTotal"] cStringUsingEncoding:NSShiftJISStringEncoding]);
       
            }
        }
          else
          {
              HPDF_Page_SetFontAndSize(page_3, fontEnBold, 18.0);
              NSString *jsonstr2 = [ACTAPP_DELEGATE getdate:ACT_PDRCONTID];
              NSDictionary *dictionary = [jsonstr2 JSONValue];
              HPDF_Page_TextOut(page_3, 35.00, 750.00, [@"Parts" cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_TextOut(page_3, 35.00, 700.00, [@"R&I" cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_TextOut(page_3, 35.00, 650.00, [@"GrandTotal" cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_SetFontAndSize(page_3, fontEn, 15.0);
              HPDF_Page_TextOut(page_3, 470.00, 750.00, [[dictionary objectForKey:@"Parts"] cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_TextOut(page_3, 470.00, 700.00, [[dictionary objectForKey:@"R_I"] cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_SetFontAndSize(page_3, fontEnBold, 18.0);
              HPDF_Page_TextOut(page_3, 470.00, 650.00, [[dictionary objectForKey:@"GrandTotal"] cStringUsingEncoding:NSShiftJISStringEncoding]);
          }
              
              HPDF_Page_SetFontAndSize(page_3, fontEnBold, 18.0);
              HPDF_Page_TextOut(page_3, 35.00, 200.00, [@"Receipt of Satisfaction" cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_TextOut(page_3, 350.00, 100.00, [@"Date" cStringUsingEncoding:NSShiftJISStringEncoding]);
              NSString *pdfdate = [ACTAPP_DELEGATE getdate:ACTPDFDate];
              HPDF_Page_SetFontAndSize(page_3, fontEn, 13.0);
              HPDF_Page_TextOut(page_3, 400.00, 100.00, [pdfdate cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_SetFontAndSize(page_3, fontEnBold, 13.0);
              HPDF_Page_TextOut(page_3, 240.00, 30.00, [@"page 3" cStringUsingEncoding:NSShiftJISStringEncoding]);
              HPDF_Page_EndText(page_3); 
              
              path = [NSString stringWithFormat:@"%@/%@",[ACTAPP_DELEGATE imageFolder],ACTScreenShotSignfull];
              
              if([self isFilePath:path])
              {
                  pathCString = [path cStringUsingEncoding:NSASCIIStringEncoding];
                  HPDF_Image finalsign = HPDF_LoadJpegImageFromFile(pdf, pathCString);
                  HPDF_Page_DrawImage(page_3, finalsign, 60.00, 100.00, 250, 80);
              }
 }
   
     pathCString = [filePath cStringUsingEncoding:1];

	 NSLog(@"loging 43");

    HPDF_SaveToFile(pdf, pathCString);
    
    if (HPDF_HasDoc(pdf)) {
        HPDF_Free(pdf);
    }
    
}

@end
