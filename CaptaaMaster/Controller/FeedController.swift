//
//  TestFeedController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/8/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import ActiveLabel
import Instructions




private let reuseIdentifier = "CaptionCell"

protocol FeedControllerDelegate: class {
    func handleMenuToggle()
}

class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    
    let coachMarksController =  CoachMarksController()
    
    
    private let filterBar = HomeFilterView()
    
    
    var user: User? {
        didSet {configureLeftBarButton()}
    }
    
    private var captions = [Caption]() {
        didSet { collectionView.reloadData()}
    }
    
    private let underineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    weak var delegate: FeedControllerDelegate?
    
    private var actionSheetLauncher: ActionSheetLauncher! = nil
    
    private var caption: Caption! = nil
    
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.grabWatchedStatus(for: .watchedHomeFeedInstructions) != true {
            coachMarksController.start(in: .window(over: self))
        }
    }
    
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterBar.delegate = self
        
        configureUI()
        configureRightBarButton()
        fetchCaptions()
      //  prepareCoachMarks()
        
             //MARK: DELETE AFTER DONE TESTING INSTRUCTION
             UserDefaults.standard.setUnwatchedInstructions(for: .watchedHomeFeedInstructions)
                
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = false
        
        
    }
    
    
    
    // MARK: - API
    
    func fetchCaptions() {
        captions.shuffle()
        collectionView.refreshControl?.beginRefreshing()
        CaptionService.shared.fetchCaptions { (captions) in
            self.captions = captions
            self.checkIfUserLikedCaption()
            self.captions.shuffle()
            self.collectionView.refreshControl?.endRefreshing()
            
        }
    }
    
    
    func checkIfUserLikedCaption() {
        self.captions.forEach { (caption) in
            CaptionService.shared.checkIfUserLikedCaption(caption) { (didLike) in
                guard didLike == true else { return}
                
                if let index = self.captions.firstIndex(where: {$0.captionID == caption.captionID}) {
                    self.captions[index].didLike = true
                }
            }
        }
        
    }
    
    
    // MARK: - Selectors
    
    func handleHashtagFeedTapped(forCell cell: CaptionCell) {
//        cell.hashtagLabel.handleHashtagTap { (hashtag) in
//
//        }
        let controller = HashtagController(collectionViewLayout: UICollectionViewFlowLayout())
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func handleProfileImageTap() {
        delegate?.handleMenuToggle()
    }
    
    @objc func handleMessageTap() {
        print("DEBUG: message button was tapped")
    }
    
    @objc func handleRefresh() {
        fetchCaptions()
        
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        collectionView.register(CaptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView(image: UIImage(named: "captaalogo"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(height: 28, width: 28)
        navigationItem.titleView = imageView
        
        view.addSubview(filterBar)
        filterBar.anchor(top: view.bottomAnchor,left: view.leftAnchor, bottom: view.bottomAnchor,right:  view.rightAnchor,paddingBottom: UIScreen.main.bounds.height - 143, height: 60)
        
        view.addSubview(underineView)
        underineView.anchor(top: filterBar.bottomAnchor,left: view.leftAnchor , width: view.frame.width / 3, height: 2)
        
        
        // MARK: - THIS IS HOW YOU CREATE A REFRESH
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        profileImageView.addGestureRecognizer(tap)
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
        
    }
    
    func configureRightBarButton() {
        
        let profileImageView = UIButton()
        profileImageView.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        profileImageView.setDimensions(height: 32, width: 32)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMessageTap))
        profileImageView.addGestureRecognizer(tap)
        
        
        
        profileImageView.layer.masksToBounds = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
    }
}

// MARK: UICollectionViewDataSource/Delegate

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return captions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CaptionCell
        
        
        cell.delegate = self
        cell.caption = captions[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            let cell = cell as! CaptionCell
//            handleHashtagFeedTapped(forCell: cell)
//            return
//        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout


extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    // THIS IS WHERE YOU MOVE DOWN THE CELLS TO ADJUST AND MAKE ROOM FOR THE FILTER BAR
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
}

extension FeedController: CaptionCellDelegate {
    
    func handleHastagTapped(_ cell: CaptionCell) {
        handleHashtagFeedTapped(forCell: cell)
    }
    
    func handleLikeTapped(_ cell: CaptionCell) {
        guard let caption = cell.caption else { return}
        
        CaptionService.shared.likeCaption(caption: caption) { (err, ref) in
            cell.caption?.didLike.toggle()
            let likes = caption.didLike ? caption.likes - 1 : caption.likes + 1
            cell.caption?.likes = likes
            
            // only upload notification if tweet is being liked
            guard !caption.didLike else { return}
            NotificationService.shared.uploadNotification(type: .like, caption: caption)
        }
        
    }
    
    func handleProfileImageTapped(_ cell: CaptionCell) {
        guard let user = cell.caption?.user else { return }
        let controller = MusicProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

// MARK: - HomeFilterViewDelegate

extension FeedController: HomeFilterViewDelegate {
    func filterView(_ view: HomeFilterView, didSelect indexpath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexpath) as? HomeFilterCell else { return}
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underineView.frame.origin.x = xPosition
        }
    }
    
}




extension FeedController: CoachMarksControllerDelegate, CoachMarksControllerDataSource {
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: (UIView & CoachMarkBodyView), arrowView: (UIView & CoachMarkArrowView)?) {
        
    prepareCoachMarks()
    

        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        
        switch index {
        case 0:
            let titleText = NSMutableAttributedString(string: CoachMarks.HomeFeed.Feed.title, attributes: [NSAttributedString.Key.foregroundColor :  UIColor(displayP3Red: 17/255, green: 154/255, blue: 237/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            let instructionText = NSMutableAttributedString(string: "\n\n\(CoachMarks.HomeFeed.Feed.instructions)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
            
            titleText.append(instructionText)
            
            coachViews.bodyView.hintLabel.attributedText = titleText
            coachViews.bodyView.hintLabel.textContainer.lineBreakMode = .byWordWrapping
            coachViews.bodyView.nextControl?.addTarget(self, action: #selector(showExportInstructions), for: .touchUpInside)
            coachViews.bodyView.nextLabel.text = "Next"
        case 1:
            let titleText = NSMutableAttributedString(string: CoachMarks.HomeFeed.CopyExport.title, attributes: [NSAttributedString.Key.foregroundColor :  UIColor(displayP3Red: 17/255, green: 154/255, blue: 237/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            let instructionText = NSMutableAttributedString(string: "\n\n\(CoachMarks.HomeFeed.CopyExport.instructions)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
            
            titleText.append(instructionText)
            
            coachViews.bodyView.hintLabel.attributedText = titleText
            coachViews.bodyView.hintLabel.textContainer.lineBreakMode = .byWordWrapping
            coachViews.bodyView.nextControl?.addTarget(self, action: #selector(likeAndDislike), for: .touchUpInside)
            coachViews.bodyView.nextLabel.text = "Got it!"
        case 2:
            let titleText = NSMutableAttributedString(string: CoachMarks.HomeFeed.Like.title, attributes: [NSAttributedString.Key.foregroundColor : UIColor(displayP3Red: 17/255, green: 154/255, blue: 237/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            let instructionText = NSMutableAttributedString(string: "\n\n\(CoachMarks.HomeFeed.Like.instructions)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
            
            titleText.append(instructionText)
            coachViews.bodyView.hintLabel.textContainer.lineBreakMode = .byWordWrapping
            
            coachViews.bodyView.hintLabel.attributedText = titleText
            coachViews.bodyView.nextControl?.addTarget(self, action: #selector(showMoodInstruction), for: .touchUpInside)
            
            coachViews.bodyView.nextLabel.text = "Got it!"
            
        case 3:
            let titleText = NSMutableAttributedString(string: CoachMarks.HomeFeed.mood.title, attributes: [NSAttributedString.Key.foregroundColor :  UIColor(displayP3Red: 17/255, green: 154/255, blue: 237/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
            let instructionText = NSMutableAttributedString(string: "\n\n\(CoachMarks.HomeFeed.mood.instructions)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)])
            
            titleText.append(instructionText)
            
            coachViews.bodyView.hintLabel.attributedText = titleText
            coachViews.bodyView.hintLabel.textContainer.lineBreakMode = .byWordWrapping
            coachViews.bodyView.nextControl?.addTarget(self, action: #selector(setWatchedDefault), for: .touchUpInside)
            coachViews.bodyView.nextLabel.text = "Got it!"
        default: break
        }
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: self.collectionView, pointOfInterest: nil, cutoutPathMaker: { (rect) -> UIBezierPath in
            let width = self.view.frame.width
            let height = width + 8 + 4 + 8
            return UIBezierPath(rect: CGRect(x: self.collectionView.frame.minX, y: self.collectionView.frame.minY, width: width, height: height))
        })
            
        case 1:
            
            guard let cell = collectionView.cellForItem(at: (IndexPath(item: 0, section: 0))) as? CaptionCell else {
                return coachMarksController.helper.makeCoachMark()
            }
            
            return coachMarksController.helper.makeCoachMark(for: cell.exportToInstagram, pointOfInterest: nil, cutoutPathMaker: { (rect) -> UIBezierPath in
                return UIBezierPath(roundedRect: rect.insetBy(dx: 0, dy: 0), cornerRadius: 14.5)
            })
        case 2:
            
            guard let cell = collectionView.cellForItem(at: (IndexPath(item: 0, section: 0))) as? CaptionCell else {
                return coachMarksController.helper.makeCoachMark()
            }
            
            return coachMarksController.helper.makeCoachMark(for: cell.likeButton, pointOfInterest: nil, cutoutPathMaker: { (rect) -> UIBezierPath in
                return UIBezierPath(roundedRect: rect.insetBy(dx: 0, dy: 0), cornerRadius: 14.5)
            })
        case 3:
            
            
            return coachMarksController.helper.makeCoachMark(for: self.collectionView, pointOfInterest: nil, cutoutPathMaker: { (rect) -> UIBezierPath in
                return UIBezierPath(roundedRect: rect.insetBy(dx: 0, dy: 0), cornerRadius: 0)
            })
            
        default: return coachMarksController.helper.makeCoachMark()
            
            
        }
    }
    
    @objc func likeAndDislike() {
        
        let secondsToDelay = 0.5
        perform(#selector(pulseLikeButton), with: nil, afterDelay: secondsToDelay)
    }
    
    @objc func pulseLikeButton() {
        guard let cell = collectionView.cellForItem(at: (IndexPath(item: 0, section: 0))) as? CaptionCell else {
            return
        }
        
        //   self.handleLikeTapped(for: cell, isDoubleTap: false)
        
        cell.likeButton.pulse(withIntensity: 1.3, withDuration: 0.15, loop: false)
        
        let secondsToDelay = 0.7
        perform(#selector(pulseUnlike), with: nil, afterDelay: secondsToDelay)
        
    }
    
    @objc func showExportInstructions() {
        let secondsToDelay = 0.7
        perform(#selector(bounceCopyExport), with: nil, afterDelay: secondsToDelay)
    }
    
    @objc func bounceCopyExport() {
        guard let cell = collectionView.cellForItem(at: (IndexPath(item: 0, section: 0))) as? CaptionCell else {
            return
        }
        
        //     cell.exportToInstagram.pulse(withIntensity: 1.7, withDuration: 0.15, loop: false)
    }
    
    @objc func pulseUnlike() {
        guard let cell = collectionView.cellForItem(at: (IndexPath(item: 0, section: 0))) as? CaptionCell else {
            return
        }
        
        //     self.handleLikeTapped(for: cell, isDoubleTap: false)
        
        cell.likeButton.pulse(withIntensity: 1.3, withDuration: 0.15, loop: false)
    }
    
    @objc func showMoodInstruction() {
        self.collectionView.scrollToItem(at: IndexPath(item: 9, section: 0), at: .centeredHorizontally, animated: true)
        let secondsToDelay = 0.7
        perform(#selector(scrollMoodBack), with: nil, afterDelay: secondsToDelay)
    }
    
    @objc func scrollMoodBack() {
        self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func setWatchedDefault() {
        UserDefaults.standard.setWatchedInstructions(for: .watchedHomeFeedInstructions)
    }
    
    
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        4
    }
    
    
    
    func prepareCoachMarks() {
        self.coachMarksController.delegate = self
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.backgroundColor = UIColor.darkGray.withAlphaComponent(0.9)
    }
    
}













