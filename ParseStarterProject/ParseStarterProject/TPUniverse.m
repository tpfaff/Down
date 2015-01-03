//
//  TPUniverse.m
//  ParseStarterProject
//
//  Created by Tyler Pfaff on 12/22/14.
//
//

#import <Foundation/Foundation.h>
#import "TPUniverse.h"
static UINavigationController* navigationController;
@implementation TPUniverse

+(void)setNavigationController:(UINavigationController*)controller{
    navigationController=controller;
}

+(UINavigationController*)navigationController{
    return navigationController;
}
@end