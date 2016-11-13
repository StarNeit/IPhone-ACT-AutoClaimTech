//
//  VINDB.m
//  ACT
//
//  Created by Lakshmanan V on 8/6/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "VINDB.h"

@implementation VINDB

@synthesize vinNumber,jsondata,pdfpath;
@synthesize isSaved;
@synthesize baseImgPath,rightCarView,leftCarView,topCarView,frontCarView,rearCarView,signatureview,finalsignature;
@synthesize damageCarImgCount;
@synthesize vehicleJson,customerJson,releasePdr,presigndate,finaldate,releaseEstimate,releaseoverpdr;
@synthesize isSubmit;
@synthesize isInspection;


-(void) dealloc
{
    for (NSString *one in [[self class] propertiesWithEncodedTypes]) {
        [self removeObserver:self forKeyPath:one];
    }
    
    ACTReleaseNil(vinNumber);
    ACTReleaseNil(jsondata);
    ACTReleaseNil(pdfpath);
    ACTReleaseNil(baseImgPath);
    ACTReleaseNil(rightCarView);
    ACTReleaseNil(leftCarView);
    ACTReleaseNil(topCarView);
    ACTReleaseNil(frontCarView);
    ACTReleaseNil(rearCarView);
    ACTReleaseNil(signatureview);
    ACTReleaseNil(finalsignature);
    ACTReleaseNil(vehicleJson);
    ACTReleaseNil(customerJson);
    ACTReleaseNil(releasePdr);
    ACTReleaseNil(presigndate);
    ACTReleaseNil(finaldate);
    ACTReleaseNil(releaseEstimate);
    ACTReleaseNil(releaseoverpdr);
}

@end
