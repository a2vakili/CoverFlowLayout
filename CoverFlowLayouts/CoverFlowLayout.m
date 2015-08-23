//
//  CoverFlowLayout.m
//  CoverFlowLayouts
//
//  Created by Arsalan Vakili on 2015-08-23.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "CoverFlowLayout.h"

@implementation CoverFlowLayout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRegion;
    visibleRegion.origin = self.collectionView.contentOffset;
    visibleRegion.size   = self.collectionView.bounds.size;
    
    CGPoint visiblecenterOfTheRegion = CGPointMake(CGRectGetMidX(visibleRegion), CGRectGetMidY(visibleRegion));
    
    for (int i = 0; i < attributes.count; i++) {
        UICollectionViewLayoutAttributes *attr = attributes[i];
        if ((visiblecenterOfTheRegion.x - attr.center.x > 100)|| (visiblecenterOfTheRegion.x - attr.center.x) < -100) {
            CATransform3D transform = CATransform3DIdentity;
            
            // setting up scale
            attr.transform3D = CATransform3DScale(transform, 0.6, 0.6, 0);
            
            // setting up rotation
            if ((visiblecenterOfTheRegion.x - attr.center.x)  // for right cover
                > 100) {
                transform.m34 = - 1.0 /300.0;
                
                attr.transform3D = CATransform3DRotate(transform, 45.0f * M_PI/180.0f, 0, 1, 0);
            }
            else {
                transform.m34 = 1.0 / 300.0;
                attr.transform3D = CATransform3DRotate(transform, 45.0f *M_PI/180.0, 0, 1, 0);
            }
            attr.alpha = 0.6;
        }
        
    }
    return attributes;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
