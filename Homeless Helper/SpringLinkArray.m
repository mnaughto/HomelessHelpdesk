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
    NSMutableArray* linkCache;
}

-(id) initWithArray:(NSArray *)array {
    if(self = [super init]){
        dataSource = array;
        linkCache = [[NSMutableArray alloc] initWithCapacity:[self count]];
    }
    return self;
}

-(NSUInteger) count {
    return [dataSource count];
}

-(id) objectAtIndex:(NSUInteger)index {
    id result = [linkCache objectAtIndex:index];
    if(!result){
        SpringLink* newLink = [[SpringLink alloc] initFromIndex:index inArray:dataSource];
        [linkCache replaceObjectAtIndex:index withObject:newLink];
        result = newLink;
    }
    return result;
}

@end
