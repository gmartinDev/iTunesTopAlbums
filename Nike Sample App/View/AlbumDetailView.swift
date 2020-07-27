//
//  AlbumDetailView.swift
//  Nike Sample App
//
//  Created by Greg Martin on 7/24/20.
//  Copyright © 2020 Greg Martin. All rights reserved.
//

import UIKit

class AlbumDetailView: UIViewController {
    public var albumInfo: AlbumModel? {
        didSet {
            //make sure albumInfo isnt nil
            guard let album = self.albumInfo else { return }
            
            if let albumArtUrl = album.artworkUrl {
                albumArt.loadRemoteImage(fromUrl: albumArtUrl)
            }
            
            albumLabel.text = album.name
            artistLabel.text = album.artistName
            genreLabel.text = album.genres?.first?.name
            releaseDateLabel.text = attemptToFormatDate(fromString: album.releaseDateString)
            copyrightLabel.text = album.copyright
        }
    }
    /// Stackview to hold all detail info for album
    let albumDetailsStackView = UIStackView()
    /// Scrollview - Scrollable view incase all details dont fit within screen
    let albumDetailScrollView = UIScrollView()
    /// View that holds scrollview - used to keep scrollview to be same width as view
    let albumDetailContainer = UIView()
    
    /// Image to hold album artwork
    let albumArt: UIImageView = createAlbumImage()
    /// Album name label
    let albumLabel: UILabel = createLabel(withFontSize: 26, numberOfLines: 0)
    /// Artist name label
    let artistLabel: UILabel = createLabel(withFontSize: 24, numberOfLines: 0)
    /// Album genre name label
    let genreLabel: UILabel = createLabel(withFontSize: 16, numberOfLines: 0)
    /// Album release date label
    let releaseDateLabel: UILabel = createLabel(withFontSize: 16, numberOfLines: 0)
    /// Album copyright label
    let copyrightLabel: UILabel = createLabel(withFontSize: 16, numberOfLines: 0)
    /// Button to redirect user to apple music page of album
    let albumStoreButton: UIButton = createStoreButton(buttonTitle: "Visit Album on Store")
    
    /// Initializer for detail view - sets up all views
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        //Set up stackview attributes
        albumDetailsStackView.axis = .vertical
        albumDetailsStackView.distribution = .fill
        albumDetailsStackView.alignment = .leading
        albumDetailsStackView.spacing = 10
        albumDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Set up scrollview attributes
        albumDetailScrollView.isDirectionalLockEnabled = true
        albumDetailScrollView.translatesAutoresizingMaskIntoConstraints = false
    
        albumDetailContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //Add views into stackview
        albumDetailsStackView.addArrangedSubview(albumLabel)
        albumDetailsStackView.addArrangedSubview(artistLabel)
        albumDetailsStackView.addArrangedSubview(genreLabel)
        albumDetailsStackView.addArrangedSubview(releaseDateLabel)
        albumDetailsStackView.addArrangedSubview(copyrightLabel)
        
        view.addSubview(albumArt)
        
        albumDetailScrollView.addSubview(albumDetailsStackView)
        albumDetailContainer.addSubview(albumDetailScrollView)
        
        view.addSubview(albumDetailContainer)
        view.addSubview(albumStoreButton)
        
        layoutViewConstraints()
        setAccessibilityIdForTesting()
    }
    
    required init?(coder: NSCoder) {
        albumInfo = nil
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
        albumStoreButton.addTarget(self, action: #selector(self.handleStoreButtonPress), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Lock orientation to portrait mode for detail view
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 'Unlock' orientation to be any orientation
        AppUtility.lockOrientation(.all)
    }
    
    /// Button press handler - opens apple music to selected albums page
    @objc private func handleStoreButtonPress() {
        guard let albumStoreUrl = albumInfo?.url else {
            print("Error no url for the album")
            return
        }
        
        ///This will redirect the user to Apple Music instead of the Itunes Store
        /*if UIApplication.shared.canOpenURL(albumStoreUrl) {
            UIApplication.shared.open(albumStoreUrl, options: [:]) { (success) in
                print("Opened itunes store: \(success ? "true" : "false")")
            }
        }*/
        
        //This is the url to open the iTunes store app
        let itunesStoreUrlStr = "itms://itunes.apple.com"
        guard var itunesStoreUrl = URL(string: itunesStoreUrlStr) else {
            print("unable to make url to itunes store")
            return
        }
        for pathComponent in albumStoreUrl.pathComponents {
            itunesStoreUrl = itunesStoreUrl.appendingPathComponent(pathComponent)
        }
        var urlComponent = URLComponents(url: itunesStoreUrl, resolvingAgainstBaseURL: false)
        //Need to add a query component to open the app
        let queryItemArr = [URLQueryItem(name: "app", value: "itunes")]
        urlComponent?.queryItems = queryItemArr
        print("\(String(describing: urlComponent?.url?.absoluteString))")
        
        guard let storeURL = urlComponent?.url else {
            print("unable to make url to album in itunes store")
            return
        }
        
        if UIApplication.shared.canOpenURL(storeURL) {
            UIApplication.shared.open(storeURL, options: [:]) { success in
                print("Opened itunes store: \(success ? "true" : "false")")
            }
        }
    }
    
    private func attemptToFormatDate(fromString dateStr: String?) -> String {
        guard let date = dateStr else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            let toDateFormat = DateFormatter()
            toDateFormat.dateFormat = "MMM dd, YYYY"
            return toDateFormat.string(from: date)
        } else {
            return date
        }
    }
    
    /// Layout all the view constraints
    private func layoutViewConstraints() {
        NSLayoutConstraint.activate([
            //Album Artwork Image
            albumArt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            albumArt.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumArt.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            albumArt.heightAnchor.constraint(equalTo: albumArt.widthAnchor),
            
            //Album Store Button
            albumStoreButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            albumStoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumStoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            albumStoreButton.heightAnchor.constraint(equalToConstant: albumStoreButton.frame.height),
            
            //Album stackview
            albumDetailsStackView.topAnchor.constraint(equalTo: albumDetailScrollView.topAnchor),
            albumDetailsStackView.leadingAnchor.constraint(equalTo: albumDetailContainer.leadingAnchor),
            albumDetailsStackView.trailingAnchor.constraint(equalTo: albumDetailContainer.trailingAnchor),
            albumDetailsStackView.bottomAnchor.constraint(equalTo: albumDetailScrollView.bottomAnchor),
            
            //Album Scrollview
            albumDetailScrollView.leadingAnchor.constraint(equalTo: albumDetailContainer.leadingAnchor),
            albumDetailScrollView.topAnchor.constraint(equalTo: albumDetailContainer.topAnchor),
            albumDetailScrollView.trailingAnchor.constraint(equalTo: albumDetailContainer.trailingAnchor),
            albumDetailScrollView.bottomAnchor.constraint(equalTo: albumDetailContainer.bottomAnchor),
            
            //Album detail container
            albumDetailContainer.topAnchor.constraint(equalTo: albumArt.bottomAnchor, constant: 20),
            albumDetailContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            albumDetailContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            albumDetailContainer.bottomAnchor.constraint(equalTo: albumStoreButton.topAnchor, constant: -20)
        ])
    }
    
    private func setAccessibilityIdForTesting() {
        albumLabel.accessibilityIdentifier = "albumName"
        artistLabel.accessibilityIdentifier = "artistLabel"
        genreLabel.accessibilityIdentifier = "genreLabel"
        releaseDateLabel.accessibilityIdentifier = "releaseDateLabel"
        copyrightLabel.accessibilityIdentifier = "copyrightLabel"
    }
}
