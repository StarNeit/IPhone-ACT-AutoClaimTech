//
//  config.h
//  ACT
//
//  Created by Sathish Kumar Mariappan on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

/*  VIN BARCODE SCANNER  */
#define ACT_VINCONFIG_URL            @"http://itunes.apple.com/us/app/vin-barcode-scanner/id497948900?mt=8"
#define ACT_VINCONFIG                @""


#define ACTPageEngingKey             @"DENT"
#define ACTPageSign                  @"SIGN"
#define ACTLoginDetails              @"LOGINDETAILS"
#define ACTVINDETAILS                @"VINDETAILS"
#define ACTVIN                       @"VIN"
#define ACTScreenShotRightView       @"SCREENSHOTRightView"
#define ACTScreenShotRightViewFull   @"SCREENSHOTRightViewFull.jpg"

#define ACTScreenShotLeftView        @"SCREENSHOTLeftView"
#define ACTScreenShotLeftViewFull    @"SCREENSHOTLeftViewFull.jpg"

#define ACTScreenShotFrontView       @"SCREENSHOTFrontView"
#define ACTScreenShotFrontViewFull   @"SCREENSHOTFrontViewFull.jpg"

#define ACTScreenShotRearView        @"SCREENSHOTRearView"
#define ACTScreenShotRearViewFull    @"SCREENSHOTRearViewFull.jpg"

#define ACTScreenShotTopView         @"SCREENSHOTTopView"
#define ACTScreenShotTopViewFull     @"SCREENSHOTTopViewFull.jpg"

#define ACTScreenShotSignature       @"SCREENSHOTSignature"
#define ACTScreenShotSignaturefull   @"SCREENSHOTSignature.jpg"
#define ACTScreenShotSignaturenil    @"SCREENSHOTSignaturenil"

#define ACTScreenShotSignature1      @"SCREENSHOTSignature1"
#define ACTScreenShotSignature1nil   @"SCREENSHOTSignature1nil"
#define ACTScreenShotSignature1full  @"SCREENSHOTSignature1.jpg"

#define ACTScreenShotSign            @"SCREENSHOTSign"
#define ACTScreenShotSignfull        @"SCREENSHOTSign.jpg"
#define ACTPDFDate                   @"SCREENSHOTDATE"

#define ACTScreenShotCamera          @"FROMCAMERA"
#define ACTScreenShotDate            @"SCREENSHOTDate1"
#define ACTScreenShotDate1           @"SCREENSHOTDate2"

#define ACTCUSTOMERINFOCustomer             @"CUSTOMERNAME"
#define ACTCUSTOMERINFODate                 @"CUSTOMERDATE"
#define ACTCUSTOMERINFOProject              @"CUSTOMERPROJECT"
#define ACTCUSTOMERINFOTechinician          @"CUSTOMERTECH"
#define ACTCUSTOMERINFOAddress1             @"CUSTOMERADDRESS1"
#define ACTCUSTOMERINFOAddress2             @"CUSTOMERADDRESS2"
#define ACTCUSTOMERINFOScense               @"CUTOMERSCENSE"
#define ACTCUSTOMERINFOPhone                @"CUSTOMERPHONE"

#define ACTPinNumber                        @"PINNUMBER"

#define ACTVEHICLEINFOMake                   @"VEHICLEMake"
#define ACTVEHICLEINFOModel                  @"VEHICLEModel"
#define ACTVEHICLEINFOYear                   @"VEHICLEYear"
#define ACTVEHICLEINFOColor                  @"VEHICLEColor"
#define ACTVEHICLEINFOMiliage                @"VEHICLEMiliage"
#define ACTVEHICLEINFOClaim                  @"VEHICLEClaim"
#define ACTVEHICLEINFOMake                   @"VEHICLEMake"
#define ACTVEHICLEINFOContaminant            @"VEHICLEContaminant"
#define ACTVEHICLEINFOWindShield             @"VEHICLEWindShield"

#define ACT_RELEASEFORM_VECHICLE             @"RELEASEFORM_VECHICLE"
#define ACT_RELEASEFORM_CUSTOMER             @"RELEASEFORM_CUSTOMER"
#define ACT_PDREstimate                      @"PDRESTIMATE"
#define ACT_PDRCONTID                        @"PDRESTIMATECONTID"

#define ACT_Notes                             @"NOTES"
#define ACT_PDRTOTAL                          @"PDRTOTAL"
#define ACT_SelectRow                         @"SELECT ROW"

#define ACTBasicFontBold(Y)				[UIFont fontWithName:@"Arial-BoldMT"size:Y]
#define ACTTitleColor                    [UIColor whiteColor]
#define ACTLabelColor                    [UIColor blackColor]

#define ACTMAXLimits                   17
#define ACT_OverPdr                         @"OVERPDR"
#define ACT_OVERSize                         @"OVERSIZE"

/* Save Data */

#define ACT_SAVEVIN                         @"SAVEVIN"
#define ACTVIN                              @"VIN"
/**************URL******************/

//#define ACT_BaseURL                 @"http://actdashboard.vndsupport.com/act/actws/api/webcall"
#define ACT_BaseURL                 @"http://autoclaimtechnology.com/act/actws/api/webcall"
#define ACT_Login                   ACT_BaseURL @"/tech_details/format/json"
#define ACT_VINDetails              ACT_BaseURL @"/vin_details/format/json"
#define ACT_CarDent                 ACT_BaseURL @"/car_dent_details/format/json/"
#define ACT_DentCharges             ACT_BaseURL @"/car_dent_charges/format/json/"
#define ACT_Sumbit                  ACT_BaseURL @"/job_details/format/json"
#define ACT_LOCATIONDETAIL          ACT_BaseURL @"/location_details/format/json"
#define ACT_ZIPCODE          @"http://autoclaimtechnology.com/zipcode.php"
/* User Authentication */

#define ACT_USERNAME                @"developer"
#define ACT_PASSWORD                @"39c3180bb3aef37356cb0dfa00d2bd79"
/* Submit Form */
#define ACT_LOGSTEP1                @"Testing network connectivity."
#define ACT_LOGSTEP2(X)             [NSString stringWithFormat:@"scheduling %d transaction in a queue",X]
#define ACT_LOGSTEPS2(X)            [NSString stringWithFormat:@"scheduling %d transactions in a queue",X]


/* Network status */
#define ACT_NWNotReachable          @"Please check your network connection and try again"
#define ACT_NWReachableViaWiFi      @"Connecting via WIFI"
#define ACT_NWReachableViaWWAN      @"Connecting via WWAN"
#define ACT_NWERROR_Reschedule      @"You might want to reschedule this transaction later"
#define ACT_NWStart_Reschedule      @"Do you want to submit previous transaction?"
#define ACT_NWJOBDONE_MSG           @"All jobs were successfully submitted."


#define ACT_RESCHEDULE              @"RESCHEDULE_LATER"
#define ACT_LOGOK_ICON              [UIImage imageNamed:@"done.png"];
#define ACT_LOGERROR_ICON           [UIImage imageNamed:@"close.png"]

typedef enum {
	ACTVEHICLEMake = 10,
	ACTVEHICLEModel = 11,
    ACTVEHICLEYear = 12,
    ACTVEHICLEColor = 13,
    ACTVEHICLEMiliage = 14,
    ACTVEHICLEClaim = 15,
    ACTVEHICLEContaminant = 16,
    ACTVEHICLEWindShield = 17,
     ACTZIPCODE = 18,
    ACTVEHICLEClaimNumber = 19
    
} ACTVEHICLE;

typedef enum {
    ACTCUSTOMERCustomer = 20,
    ACTCUSTOMERDate = 21,
    ACTCUSTOMERProject = 22,
    ACTCUSTOMERTechinician = 23,
    ACTCUSTOMERAddress1 = 24,
    ACTCUSTOMERAddress2 = 25,
    ACTCUSTOMERScense = 26,
    ACTCUSTOMERPhone = 27,
    ACTCUSTOMERCITY = 34,
    ACTCUSTOMERSTATE = 35,
    ACTCUSTOMERXIP = 36
}ACTCUSTOMER;

typedef enum{
    ACTPDRCONTTotal = 30,
    ACTPDRCONTParts = 31,
    ACTPDRCONTRI = 32,
    ACTPDRCONTGrand = 33,
    
}ACTPDRCONT;

#define ACTReleaseNil(x)         if ( nil != x ) { [x release], x = nil; }

/* PDF   */

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0


#define ACTScreenShotCount           @"SCREENSHOTCOUNT"
#define ACT_LOGFONT(x)              [UIFont fontWithName:@"American Typewriter" size:x]
#define ACTAPP_DELEGATE				((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define ACTUSER_DEFAULTS			[NSUserDefaults standardUserDefaults]
#define ACTVIEW_FRAME				[[UIScreen mainScreen] applicationFrame]
