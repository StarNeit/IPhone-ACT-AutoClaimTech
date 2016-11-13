//
//  LANetworkConnect.h
//  ACT
//
//  Created by Lakshmanan V on 8/19/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface LANetworkConnect : NSObject
{
    
    
    
}

+ (NSString *) getIPAddress;
+ (NSDictionary*) checkNetworkStatus;
+ (NSDictionary*) checkHostServer:(NSString*)str;

@end
