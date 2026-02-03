//
//  SceneDelegate.swift
//  MoviaAppTest
//
//  Created by Yudha Pratama Putra on 2/4/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // --- TAMBAHKAN BARIS INI (Ini yang hilang) ---
    var window: UIWindow?
    // ---------------------------------------------

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 1. Inisialisasi Window
        window = UIWindow(windowScene: windowScene)
        
        // 2. Panggil XIB MovieViewController
        // Pastikan nama file XIB bapak benar "MovieViewController"
        let rootVC = MovieViewController(nibName: "MovieViewController", bundle: nil)
        
        // 3. Bungkus dengan Navigation Controller (supaya ada Title Bar)
        let navVC = UINavigationController(rootViewController: rootVC)
        
        // 4. Set sebagai Root & Tampilkan
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }

    // Fungsi lifecycle lain di bawahnya biarkan saja (sceneDidDisconnect, dll)
}
