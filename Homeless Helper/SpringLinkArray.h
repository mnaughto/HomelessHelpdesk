//
//  SpringLinkArray.h
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//represents an array of java spring MVC links. For this, we are simply using the JSON array
//as our source and returning an instance of springlink for valid objects. 
@interface SpringLinkArray : NSArray

//initialize with array containing data scraped from spring json response.
-(id) initWithArray:(NSArray *)array;
-(NSUInteger) count;
-(id) objectAtIndex:(NSUInteger)index;
@end
