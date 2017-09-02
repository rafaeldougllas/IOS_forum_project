//
//  Comment+CoreDataProperties.h
//  
//
//  Created by Rafael Douglas on 28/08/17.
//
//

#import "Comment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Comment (CoreDataProperties)

+ (NSFetchRequest<Comment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, retain) NSData *content_picture;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *user;

@end

NS_ASSUME_NONNULL_END
