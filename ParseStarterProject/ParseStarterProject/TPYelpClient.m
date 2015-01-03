//
//  TPYelpClient.m
//  Down
//
//  Created by Tyler Pfaff on 12/29/14.
//
//

//TODO Get all these out of here!
//Consumer Key	WFJNxOHlSiNMmYOmbB7i1g
//Consumer Secret	HMQzSAT7GqWKanmOLENrhP3nKK0
//Token	La-hzIcfDuTXsb4e4-3sYe8MoXBvXZAJ
//Token Secret	xvSU2vvxkTjlbKz8Ywr6VbTCXFs


#import "TPYelpClient.h"
#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Manager/AFOAuth2Manager.h>

static NSString* clientID=@"WFJNxOHlSiNMmYOmbB7i1g";
static NSString* clientSecret=@"HMQzSAT7GqWKanmOLENrhP3nKK0";

@implementation TPYelpClient

-(void)authenticateMe{
    NSURL* baseURL=[NSURL URLWithString:@"http://yelp.com/"];
    AFOAuth2Manager* manager=[[AFOAuth2Manager alloc]initWithBaseURL:baseURL clientID:clientID secret:clientSecret];
}
@end
