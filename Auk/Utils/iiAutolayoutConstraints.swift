//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class iiAutolayoutConstraints {
  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""

    if margin != 0 {
      marginFormat = "-(\(margin))-"
    }

    var format = "|\(marginFormat)[view]\(marginFormat)|"

    if vertically {
      format = "V:" + format
    }

    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: ["view": view])

    parentView.addConstraints(constraints)
  }
  
  class func alignSameAttributes(item: AnyObject, toItem: AnyObject,
    constraintContainer: UIView, attribute: NSLayoutAttribute, margin: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let constraint = NSLayoutConstraint(
      item: item,
      attribute: attribute,
      relatedBy: NSLayoutRelation.Equal,
      toItem: toItem,
      attribute: attribute,
      multiplier: 1,
      constant: margin)
    
    constraintContainer.addConstraint(constraint)
    
    return [constraint]
  }

  class func equalWidth(viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    return equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: false)
  }
  
  // MARK: - Equal height and width
  
  class func equalHeight(viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    return equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: true)
  }
  
  class func equalSize(viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    var constraints = equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: false)
    
    constraints += equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: true)
    
    return constraints
  }
  
  class func equalWidthOrHeight(viewOne: UIView, viewTwo: UIView, constraintContainer: UIView,
    isHeight: Bool) -> [NSLayoutConstraint] {
    
    var prefix = ""
    
    if isHeight { prefix = "V:" }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat("\(prefix)[viewOne(==viewTwo)]",
      options: [], metrics: nil,
      views: ["viewOne": viewOne, "viewTwo": viewTwo])
        
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  // MARK: - Align view next to each other
  
  class func viewsNextToEachOther(views: [UIView],
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    if views.count < 2 { return []  }
    
    var constraints = [NSLayoutConstraint]()
    
    for (index, view) in views.enumerate() {
      if index >= views.count - 1 { break }
      
      let viewTwo = views[index + 1]
      
      constraints += twoViewsNextToEachOther(view, viewTwo: viewTwo,
        constraintContainer: constraintContainer, margin: margin, vertically: vertically)
    }
    
    return constraints
  }
  
  class func twoViewsNextToEachOther(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    var marginFormat = ""
    
    if margin != 0 {
      marginFormat = "-\(margin)-"
    }
    
    var format = "[viewOne]\(marginFormat)[viewTwo]"
    
    if vertically {
      format = "V:" + format
    }
    
    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: [], metrics: nil,
      views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
    
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  class func height(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isHeight: true)
  }
  
  class func width(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isHeight: false)
  }
  
  class func widthOrHeight(view: UIView, value: CGFloat, isHeight: Bool) -> [NSLayoutConstraint] {
    
    let layoutAttribute = isHeight ? NSLayoutAttribute.Height : NSLayoutAttribute.Width
    
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: layoutAttribute,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1,
      constant: value)
    
    view.addConstraint(constraint)
    
    return [constraint]
  }
}
