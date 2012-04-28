//
//  SpringLinkArray.m
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpringLinkArray.h"
#import "SpringLink.h"

@implementation SpringLinkArray {
    NSArray* dataSource;
    //cache of the links created in objectAtIndex.
    NSMutableDictionary* linkCache;
}

-(id) initWithArray:(NSArray *)array {
    if(self = [super init]){
        dataSource = array;
        linkCache = [NSMutableDictionary dictionary];
    }
    return self;
}

-(NSUInteger) count {
    return [dataSource count];
}

-(id) objectAtIndex:(NSUInteger)index {
    id result = [linkCache objectForKey:[NSNumber numberWithUnsignedInteger:index]];
    
    if(!result){
        SpringLink* newLink = [[SpringLink alloc] initFromIndex:index inArray:dataSource];
        [linkCache setObject:newLink forKey:[NSNumber numberWithUnsignedInteger:index]];
        result = newLink;
    }
    return result;
}

@end
