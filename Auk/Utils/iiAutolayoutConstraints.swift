//
//  Collection of shortcuts to create autolayout constraints.
//

import UIKit

class iiAutolayoutConstraints {
  class func fillParent(_ view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""

    if margin != 0 {
      marginFormat = "-(\(margin))-"
    }

    var format = "|\(marginFormat)[view]\(marginFormat)|"

    if vertically {
      format = "V:" + format
    }

    let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
      options: [], metrics: nil,
      views: ["view": view])

    parentView.addConstraints(constraints)
  }
  
  @discardableResult
  class func alignSameAttributes(_ item: AnyObject, toItem: AnyObject,
    constraintContainer: UIView, attribute: NSLayoutAttribute, margin: CGFloat = 0) -> [NSLayoutConstraint] {
      
    let constraint = NSLayoutConstraint(
      item: item,
      attribute: attribute,
      relatedBy: NSLayoutRelation.equal,
      toItem: toItem,
      attribute: attribute,
      multiplier: 1,
      constant: margin)
    
    constraintContainer.addConstraint(constraint)
    
    return [constraint]
  }

  class func equalWidth(_ viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    return equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: false)
  }
  
  // MARK: - Equal height and width
  
  class func equalHeight(_ viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    return equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: true)
  }
  
  @discardableResult
  class func equalSize(_ viewOne: UIView, viewTwo: UIView, constraintContainer: UIView) -> [NSLayoutConstraint] {
    
    var constraints = equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: false)
    
    constraints += equalWidthOrHeight(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, isHeight: true)
    
    return constraints
  }
  
  class func equalWidthOrHeight(_ viewOne: UIView, viewTwo: UIView, constraintContainer: UIView,
    isHeight: Bool) -> [NSLayoutConstraint] {
    
    var prefix = ""
    
    if isHeight { prefix = "V:" }
    
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: "\(prefix)[viewOne(==viewTwo)]",
      options: [], metrics: nil,
      views: ["viewOne": viewOne, "viewTwo": viewTwo])
        
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  // MARK: - Align view next to each other
  
  @discardableResult
  class func viewsNextToEachOther(_ views: [UIView],
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {
      
    if views.count < 2 { return []  }
    
    var constraints = [NSLayoutConstraint]()
    
    for (index, view) in views.enumerated() {
      if index >= views.count - 1 { break }
      
      let viewTwo = views[index + 1]
      
      constraints += twoViewsNextToEachOther(view, viewTwo: viewTwo,
        constraintContainer: constraintContainer, margin: margin, vertically: vertically)
    }
    
    return constraints
  }
  
  class func twoViewsNextToEachOther(_ viewOne: UIView, viewTwo: UIView,
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
    
    let constraints = NSLayoutConstraint.constraints(withVisualFormat: format,
      options: [], metrics: nil,
      views: [ "viewOne": viewOne, "viewTwo": viewTwo ])
    
    constraintContainer.addConstraints(constraints)
    
    return constraints
  }
  
  @discardableResult
  class func height(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isHeight: true)
  }
  
  @discardableResult
  class func width(_ view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    return widthOrHeight(view, value: value, isHeight: false)
  }
  
  class func widthOrHeight(_ view: UIView, value: CGFloat, isHeight: Bool) -> [NSLayoutConstraint] {
    
    let layoutAttribute = isHeight ? NSLayoutAttribute.height : NSLayoutAttribute.width
    
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: layoutAttribute,
      relatedBy: NSLayoutRelation.equal,
      toItem: nil,
      attribute: NSLayoutAttribute.notAnAttribute,
      multiplier: 1,
      constant: value)
    
    view.addConstraint(constraint)
    
    return [constraint]
  }
}
