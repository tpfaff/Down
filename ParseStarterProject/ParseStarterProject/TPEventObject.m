//
//  TPInviteObject.m
//  Down
//
//  Created by Tyler Pfaff on 1/2/15.
//
//

#import "TPEventObject.h"


@implementation TPEventObject

-(id)init{
    if(self=[super init]){
        self.location=[[TPLocation alloc]init];
        self.when=[[NSString alloc]init];
        self.who=[[NSMutableArray alloc]init];
        self.why=[[NSString alloc]init];
        self.from=[[NSString alloc]init];
    }
    return self;
}

-(NSString*)description{
    NSString* description=[NSString stringWithFormat:@"Where:%@ \n When:%@ \n Who:%@ \n Why:%@ \n From:%@",self.location,self.when,self.who,self.why,self.from];
    
    return description;
}

@end
