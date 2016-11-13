//
//  LANetworkConnect.m
//  ACT
//
//  Created by Lakshmanan V on 8/19/12.
//  Copyright (c) 2012 Innoppl Technologies. All rights reserved.
//

#import "LANetworkConnect.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation LANetworkConnect


+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
} 


+ (NSDictionary*) checkNetworkStatus
{	
    //Check Network Connection
	Reachability *internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
    
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    
    NSDictionary *dict;
	switch (internetStatus)
	{
		case NotReachable:
		{
            dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:ACT_NWNotReachable,@"0", nil] forKeys:[NSArray arrayWithObjects:@"msg",@"code", nil]];
			NSLog(@"The internet is down.");
			break;
		}
		case ReachableViaWiFi:
		{ 
            dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:ACT_NWReachableViaWiFi,@"1", nil] forKeys:[NSArray arrayWithObjects:@"msg",@"code", nil]];
			NSLog(@"connecting via WIFI.");
			break;
		}
		case ReachableViaWWAN:
		{
            dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:ACT_NWReachableViaWWAN,@"1", nil] forKeys:[NSArray arrayWithObjects:@"msg",@"code", nil]];
			NSLog(@"connecting via WWAN.");
			break;
		}
	}
    return dict;
} 


+ (NSDictionary*) checkHostServer:(NSString*)str
{    
    // check if a pathway to a random host exists
    Reachability *hostReachable = [[Reachability reachabilityWithHostName:@"www.apple.com"] retain];
	[hostReachable startNotifier];
}


@end
