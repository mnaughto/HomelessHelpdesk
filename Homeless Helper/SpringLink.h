//
//  SpringLink.h
//  Homeless Helper
//
//  Created by Mac User on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpringObject.h"


//represents a spring link. each link has a "rel" and "href" attribute. "rel" is a string
//with a vague description of the object, while "href" is a url which can be used to navigate
//to the detail record. For convenience, there is also a function that will return the linked data.
@interface SpringLink : NSObject
-(id)initFromIndex: (NSUInteger) index inArray: (NSArray *) array
-(NSURL*) url;
-(NSString*) rel;
-(SpringObject*) child;
@end
