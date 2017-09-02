//
//  Comment+CoreDataProperties.m
//  
//
//  Created by Rafael Douglas on 28/08/17.
//
//

#import "Comment+CoreDataProperties.h"

@implementation Comment (CoreDataProperties)

+ (NSFetchRequest<Comment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Comment"];
}

@dynamic content;
@dynamic content_picture;
@dynamic date;
@dynamic user;

@end
