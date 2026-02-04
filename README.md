# MovieApp - Panin Bank Technical Test

Aplikasi iOS untuk menampilkan daftar film populer menggunakan TMDB API dengan arsitektur MVVM.

### Cara Menjalankan Aplikasi
1. Clone repository ini.
2. Buka file `MoviaAppTest.xcodeproj` di Xcode.
3. Pastikan sudah terinstall library **SwiftyJSON** dan **SDWebImage** melalui Swift Package Manager.
4. Masukkan API Key TMDB Anda di file `APIService.swift`.
5. Build dan Run di Simulator (iOS 14.0+).

### Pendekatan & Arsitektur
- **MVVM (Model-View-ViewModel)**: Memisahkan logika bisnis dengan tampilan.
- **Cache-First Approach**: Aplikasi akan menampilkan data dari `UserDefaults` terlebih dahulu sebelum melakukan fetch ke API.
- **Programmatic XIB**: UI dibangun menggunakan XIB untuk modularitas dan performa.

### Fitur Utama
- **Real-time Search**: Mencari film berdasarkan judul.
- **Offline Support**: Data tetap muncul meski tanpa koneksi internet (Caching).
- **Optimized Image Loading**: Menggunakan SDWebImage untuk caching gambar.
