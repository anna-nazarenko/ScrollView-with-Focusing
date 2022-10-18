//
//  ViewController.swift
//  HotTask
//
//  Created by Dream Store on 18.10.2022.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK: Properties
  
  private var targetOffsetY: Int = 0
  private var lastContentOffsetY: CGFloat = 0
  
  //MARK: UI Elements
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.decelerationRate = UIScrollView.DecelerationRate.fast
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private lazy var contentView: UIView = {
      let contentView = UIView()
      contentView.translatesAutoresizingMaskIntoConstraints = false
      return contentView
  }()
  
  private lazy var subview1: UILabel = {
    let subview1 = UILabel()
    subview1.text = "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"
    subview1.font = UIFont.systemFont(ofSize: 22)
    subview1.numberOfLines = 0
    subview1.lineBreakMode = .byWordWrapping
    subview1.translatesAutoresizingMaskIntoConstraints = false
    return subview1
  }()
  
  private lazy var subview2: UIImageView = {
    let subview2 = UIImageView()
    subview2.backgroundColor = .yellow
    subview2.contentMode = .scaleAspectFit
    subview2.image = UIImage(named: "icon")
    subview2.translatesAutoresizingMaskIntoConstraints = false
    return subview2
  }()
  
  //MARK: View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.delegate = self
    
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(subview1)
    contentView.addSubview(subview2)
    
    setScrollViewConstraints()
    setContentViewConstraints()
    setTextViewConstraints()
    setGreenViewConstraints()
  }
  
  //MARK: Constraints
  
  private func setScrollViewConstraints() {
      NSLayoutConstraint.activate([
          scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
          scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
          scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
          scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      ])
  }
  
  private func setContentViewConstraints() {
      NSLayoutConstraint.activate([
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
          contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
          contentView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
          contentView.heightAnchor.constraint(equalToConstant: 1600)
      ])
  }
  
  private func setTextViewConstraints() {
      NSLayoutConstraint.activate([
        subview1.topAnchor.constraint(equalTo: contentView.topAnchor),
        subview1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        subview1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        subview1.heightAnchor.constraint(equalToConstant: 800),
      ])
  }
  
  private func setGreenViewConstraints() {
      NSLayoutConstraint.activate([
        subview2.topAnchor.constraint(equalTo: subview1.bottomAnchor),
        subview2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        subview2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        subview2.heightAnchor.constraint(equalToConstant: 800),
      ])
  }
}

//MARK: - ScrollView Delegate

extension ViewController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let contentOffsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let scrollHeight = scrollView.frame.size.height
    
    if lastContentOffsetY < contentOffsetY { targetOffsetY = Int(contentHeight - scrollHeight)}
    else { targetOffsetY = 0 }
    
    lastContentOffsetY = contentOffsetY
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    targetContentOffset.pointee = CGPoint(x: 0, y: self.targetOffsetY)
  }
}
