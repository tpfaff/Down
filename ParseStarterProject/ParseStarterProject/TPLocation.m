//
//  TPLocation.m
//  Down
//
//  Created by Tyler Pfaff on 1/9/15.
//
//

#import "TPLocation.h"

@implementation TPLocation

-(id)init{
    if(self=[super init]){
      
    }
    
return self;
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@" Name:%@ \n Phone Number:%@ \n Address:%@ \n URL:%@ \n Coordinates:%f,%f",self.name,self.phoneNumber,self.address,self.url,self.coordinate->latitude,self.coordinate->longitude];
}
@end
