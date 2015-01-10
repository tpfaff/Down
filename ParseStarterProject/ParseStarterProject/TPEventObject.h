//
//  TPInviteObject.h
//  Down
//
//  Created by Tyler Pfaff on 1/2/15.
//
//

#import <Foundation/Foundation.h>
#import "TPLocation.h"


@interface TPEventObject : NSObject

@property (strong,nonatomic) TPLocation* where;
@property (strong,nonatomic) NSString* when;
@property (strong,nonatomic) NSMutableArray* who;
@property (strong,nonatomic) NSString* why;
@property (strong,nonatomic) NSString* from;

@end
