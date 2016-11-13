//
//  SaveData.m
//  ACT
//
//  Created by Lakshmanan V on 8/3/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "SaveData.h"
#import "VINDB.h"

@implementation SaveData

+ (BOOL) saveDatainArray:(NSString*)str forKey:(NSString*)key
{
    if (!str) 
        return NO;
    
    if(![self ChkVIN:str])
    {
        VINDB *addvin = [[VINDB alloc] init];
        addvin.vinNumber = str;
        addvin.isSaved = 0;
        addvin.isSubmit = 0;
        [addvin save];
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSArray*) getDatainArray:(NSString*)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    NSArray *array;
    
    if (standardUserDefaults) 
       array  = [standardUserDefaults objectForKey:key];
    
    return array;
}

+ (void) saveCarImg:(UIImage*)img forKey:(NSString*)key filename:(NSString*)name
{
    NSString *vinNumber = [ACTAPP_DELEGATE getUserDefault:ACTVIN];
    VINDB *updatedimg = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",vinNumber]];
    NSString *filepath = @"";
    
    NSString *folderPath = [self createPath:vinNumber];
    if ([key isEqualToString:ACTScreenShotCamera]) {
        filepath = [self saveimages:img folderpath:folderPath filename:[NSString stringWithFormat:@"custom_pic_%@.jpg",name]];
    }else
    {
        filepath = [self saveimages:img folderpath:folderPath filename:name];  
    }
   
    if(!updatedimg.baseImgPath)
    {
        updatedimg.baseImgPath = folderPath;
    }
    if([key isEqualToString:ACTScreenShotRightView])
    {
        updatedimg.rightCarView = filepath;
    }
    else if([key isEqualToString:ACTScreenShotLeftView])
    {
        updatedimg.leftCarView = filepath;
    }
    else if([key isEqualToString:ACTScreenShotFrontView])
    {
        updatedimg.frontCarView = filepath;
    }
    else if([key isEqualToString:ACTScreenShotRearView])
    {
        updatedimg.rearCarView = filepath;
    }
    else if([key isEqualToString:ACTScreenShotTopView])
    {
        updatedimg.topCarView = filepath;
    }
    else if([key isEqualToString:ACTScreenShotSignature])
    {
        updatedimg.signatureview = filepath;
    }
    else if([key isEqualToString:ACTScreenShotSignature1])
    {
        updatedimg.signatureview = filepath;
    }
    else if([key isEqualToString:ACTScreenShotSign])
    {
        updatedimg.finalsignature = filepath;
    }else if([key isEqualToString:ACTScreenShotCamera])
    {
        updatedimg.damageCarImgCount = [name intValue];
    }
    [updatedimg save];
   // NSLog(@"folderPath %@",folderPath);
}

+(NSString*) createPath:(NSString*)str
{
    NSFileManager *NSFm= [NSFileManager defaultManager]; 
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/Photo/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],str];
    BOOL isDir = YES;
    NSError *error;
    
    if(![NSFm fileExistsAtPath:dirToCreate isDirectory:&isDir])
        if(![NSFm createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error])
            NSLog(@"Error: Create folder failed");
    return dirToCreate;
}

+(NSString*) saveimages:(UIImage*)img folderpath:(NSString*)path filename:(NSString*)name
{    
    NSData *pngData = UIImageJPEGRepresentation(img, 0.5 );      
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,name];
  //  NSLog(@"path file %@",filePath);
    [pngData writeToFile:filePath atomically:YES];
    return filePath;
}

+ (void) clearVIN:(NSString*)key
{
    NSArray *clrvin = [VINDB allObjects];
     for(VINDB *removedata in clrvin)
     {
         [removedata deleteObject];
     }
}


+ (void) removeVINByKey:(NSString*)key
{
    VINDB *vinDB = (VINDB*)[VINDB findFirstByCriteria:[NSString stringWithFormat:@"Where vin_number like '%@'",key]];

    NSFileManager *fileMg = [NSFileManager defaultManager];
    
    NSString *imgPath = vinDB.baseImgPath;
  //  NSLog(@"before list %@",[fileMg contentsOfDirectoryAtPath:vinDB.baseImgPath error:nil]);

    if ([fileMg fileExistsAtPath:imgPath]) {
        NSError *error;
        [fileMg removeItemAtPath:imgPath error:&error];
    }
    
  //  NSLog(@"after list %@",[fileMg contentsOfDirectoryAtPath:vinDB.baseImgPath error:nil]);
    
    
    [vinDB deleteObject];

}


+(BOOL) checkVINDB:(NSArray*)arr checkVIN:(NSString*)str
{
    if([arr containsObject:str])  return YES;
    else  return NO;
}

+(BOOL)ChkVIN:(NSString*)str
{
    NSArray *arr = [VINDB allObjects];
    for(VINDB *vin in arr)
    {
        if([vin.vinNumber isEqualToString:str])
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL) isSubmitEnable
{
    for(VINDB *vinDB in [VINDB allObjects])
    {
        if (vinDB.isSaved == 0) {
            return NO;
        }
        if(vinDB.isSaved == 1)
        {
            return NO;
        }
        
    }
    return YES;
}

@end
