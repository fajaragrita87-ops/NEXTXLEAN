# 🧺 NEXTCLEAN — PRODUCT REQUIREMENTS DOCUMENT

> **Versi**: 2.0.0 (FIREBASE ONLY + LOW-END OPTIMIZED)
> **Tanggal**: 26 Mei 2026
> **Author**: Founder
> **Status**: FINAL ✅
> **Tools**: Flutter + Firebase + GetX + Trae AI

---

## 📋 DAFTAR ISI

| # | Section |
|---|---------|
| 1 | 🎯 Project Overview |
| 2 | 🛠️ Tech Stack |
| 3 | 📱 Low-End Device Optimization |
| 4 | 📸 Absen: Geolocation + Photo |
| 5 | 🎨 Design System |
| 6 | 👥 User Roles & Permissions |
| 7 | 🏪 Setting Module |
| 8 | 📦 Order & POS Module |
| 9 | 🧺 Laundry Tracking Module |
| 10 | 🏍️ Kurir Module |
| 11 | 👤 Staff Absen Module |
| 12 | ⚡ Smart Process |
| 13 | 🔔 Notification Module |
| 14 | 🔌 API Specifications (Cloud Functions) |
| 15 | 🔄 Flow: Login → Logout (Per Role) |
| 16 | 📱 Screen List |
| 17 | 📊 KPI & Metrics |
| 18 | ✅ Ringkasan Final |

## 1. 🎯 PROJECT OVERVIEW

| Item | Detail |
|------|--------|
| **Nama App** | NEXTCLEAN |
| **Tagline** | "Bersih Pasti, Cepat Pasti" |
| **Platform** | Android & iOS (Flutter) |
| **Backend** | Firebase (Auth + Firestore + Storage + Cloud Functions + Messaging) |

## 2. 🛠️ TECH STACK

| Layer | Technology | Alasan |
|-------|-----------|--------|
| 🔐 **Auth** | Firebase Auth (Email/Phone/Google) | Gratis, cepat, aman |
| 🧩 **Backend Logic** | Cloud Functions + Firestore | Realtime, mudah di-scale |
| 📁 **File Storage** | Firebase Storage | Foto before/after, profil, logo |
| 🔔 **Push Notif** | Firebase Cloud Messaging (FCM) | Gratis, realtime |
| 📱 **Frontend** | Flutter + GetX | Clean, ringan, cepat |
| 🧠 **State Management** | GetX | Ringan, cocok HP kentang |
| 📊 **Analytics** | Firebase Analytics | Gratis |
| 🧪 **Crash Report** | Firebase Crashlytics | Gratis |

## 3. 📱 LOW-END DEVICE OPTIMIZATION (HP KENTANG)

| # | Optimasi | Detail |
|---|----------|--------|
| 1 | 🪶 **APK Size < 25MB** | Tanpa library berat, lazy loading |
| 2 | 🧠 **RAM Usage < 300MB** | GetX (bukan BLoC), minimal rebuild |
| 3 | ⚡ **Cold Start < 2 detik** | Splash screen langsung masuk |
| 4 | 📶 **Offline First** | Firestore cache → bisa jalan tanpa internet |
| 5 | 🖼️ **Image Compression** | Max 800px, WebP format, auto compress |
| 6 | 🔄 **Lazy Loading** | Screen load sesuai kebutuhan, bukan semua sekaligus |
| 7 | 🗑️ **No Heavy Animation** | Cuma fade + slide, gak ada particle/3D |
| 8 | 📦 **Min SDK: Android 6.0 (API 23)** | Support HP 5 tahun ke atas |
| 9 | 🔋 **Battery Saver Mode** | Detect battery saver → kurangi sync frequency |
| 10 | 📊 **Firestore Query Optimized** | Index semua field yang sering di-query |

### 📋 MINIMUM REQUIREMENTS

| Spec | Minimum |
|------|---------|
| RAM | 2 GB |
| Storage | 100 MB free |
| Android | 6.0 (Marshmallow) |
| iOS | 13.0 |
| Camera | 5 MP (buram pun bisa) |
| Internet | 2G (offline mode tersedia) |

---

## 4. 📸 ABSEN: GEOLOCATION + PHOTO

### 🔄 ALUR ABSEN (LOW-END OPTIMIZED)

```text
STAFF BUKA APP → KLIK "ABSEN MASUK"
│
│ ┌──────────────────────────────────────┐
│ │ STEP 1: BUKA KAMERA DEPAN            │
│ │ • Resolusi: 480p (bukan 1080p)       │
│ │ • FPS: 15 (hemat RAM)                │
│ │ • Preview: kecil (200x200px)         │
│ └──────────────┬───────────────────────┘
│                │
│                ▼
│ ┌──────────────────────────────────────┐
│ │ STEP 2: AMBIL FOTO                   │
│ │ • Deteksi wajah di frame (bonus)     │
│ │ • Jika gagal → tetap lanjut (geotag) │
│ └──────────────┬───────────────────────┘
│                │
│                ▼
│ ┌──────────────────────────────────────┐
│ │ STEP 3: GEOTAG CHECK                 │
│ │ • Ambil GPS → cek radius 100m        │
│ │ ✅ Dalam radius → LULUS ✅            │
│ │ ❌ Di luar → "Gak di cabang"          │
│ └──────────────────────────────────────┘
```

> 💡 **Intinya: Geotag SELALU jadi backup utama. Face detection = bonus verifikasi.**

---

## 5. 🎨 DESIGN SYSTEM

### 5.1 Color Palette — Magenta × White (Bright Mode Only)

| Nama | Hex | RGB | Usage |
|------|-----|-----|-------|
| 🟣 Magenta Primary | `#D81B9A` | 216, 27, 154 | Button, Header, CTA |
| 🟣 Magenta Dark | `#AD1457` | 173, 20, 87 | Hover, Active |
| 🟣 Magenta Light | `#F8BBD0` | 248, 187, 208 | Badge, Pill |
| 🟣 Gradient Start | `#E91E63` | 233, 30, 99 | Gradient Awal |
| 🟣 Gradient End | `#9C27B0` | 156, 39, 176 | Gradient Akhir |
| ⚪ White Pure | `#FFFFFF` | 255, 255, 255 | Background |
| ⚪ White Smoke | `#FAFAFA` | 250, 250, 250 | Background Secondary |
| ⬛ Dark Text | `#1A1A2E` | 26, 26, 46 | Heading, Body |
| 🩶 Gray Text | `#6B7280` | 107, 114, 128 | Secondary Text |
| 🩶 Gray Light | `#E5E7EB` | 229, 231, 235 | Border, Divider |
| Komponen | Warna |
|----------|
| App Bar | `#D81B9A` + `#FFFFFF` |
| Bottom Nav Active | `#D81B9A` |
| Bottom Nav Inactive | `#E5E7EB` |
| FAB | Gradient `#E91E63 → #9C27B0` |
| Button Primary | `#D81B9A` |
| Button Secondary | `#FFFFFF` + Border `#D81B9A` |
| Card BG | `#FFFFFF` |
| Card Border | `#E5E7EB` |
| Input BG | `#FAFAFA` |

### 5.2 Typography (Ringan, Cepat Render)

| Element | Font | Size | Weight |
|---------|------|------|--------|
| Heading 1 | Poppins | 24px | Bold |
| Heading 2 | Poppins | 20px | SemiBold |
| Body | Poppins | 14px | Regular |
| Caption | Poppins | 12px | Regular |
| Button | Poppins | 16px | Bold |
| Price | Poppins | 22px | ExtraBold |

> ⚡ **Poppins = render cepat di HP kentang, gak lag**

## 6. 👥 USER ROLES & PERMISSIONS

| # | Role | Icon | Hak Akses |
|---|------|------|-----------|
| 1 | 👑 Super Admin (Owner) | 👑 | SEMUA |
| 2 | 🏢 Manager Cabang | 🏢 | Laporan cabang, kelola staff cabang |
| 3 | 🖥️ Kasir | 🖥️ | POS, terima bayar, pickup, struk |
| 4 | 🧺 Staff Laundry | 🧺 | Scan QR, ubah status, foto before/after |
| 5 | 🏍️ Kurir | 🏍️ | Jemput, antar, absen jemput/antar |
| 6 | 👤 Customer | 👤 | Track order, bayar, poin, ajak temen |

| Fitur | Owner | Manager | Kasir | Staff | Kurir | Customer |
|-------|:-----:|:-------:|:-----:|:-----:|:-----:|
| Dashboard | ✅ | ✅ (cabang) | ❌ | ❌ | ❌ | ✅ |
| POS / Order | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ |
| Tracking | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Laporan Keuangan | ✅ | ✅ (cabang) | ❌ | ❌ | ❌ | ❌ |
| Edit Harga | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Edit Profil Toko | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Manajemen Role | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Inventory | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Absen Staff | ✅ | ✅ (cabang) | ❌ | ✅ | ✅ | ❌ |
| Export PDF | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
## 7. 🏪 SETTING MODULE (Owner Only)

### 7.1 Profil Toko

| Field | Type | Required |
|-------|------|----------|
| Nama Toko | Text | ✅ |
| Tagline | Text | ❌ |
| Alamat | Text | ✅ |
| Google Maps Link | URL | ❌ |
| No. Telepon | Text | ✅ |
| Email | Email | ❌ |
| WhatsApp | Text | ✅ |
| Instagram | Text | ❌ |
| TikTok | Text | ❌ |
| Website | URL | ❌ |
| Jam Operasional | TimeRange | ✅ |
| Hari Libur | MultiSelect | ❌ |
| Logo | Image | ✅ |
| Banner | Image | ❌ |
| Tema Warna | ColorPicker | ✅ |
| Font | Dropdown | ✅ |

### 7.2 Harga Jasa (EDITABLE OWNER)

#### Paket Utama (Per PCS)

| Paket | Waktu | Harga | Min Order |
|-------|-------|-------|-----------|
| 🟢 REGULER | 3 Hari | Rp 10.000 | 1 PCS |
| 🔵 CEPAT | 1 Hari | Rp 15.000 | 1 PCS |
| 🟡 KILAT | 5 Jam | Rp 22.000 | 1 PCS |

#### Layanan Khusus (Per PCS)

| Layanan | Harga |
|---------|-------|
| 👔 Setrika | Rp 8.000 |
| 🧥 Dry Clean | Rp 45.000 |
| 👟 Cuci Sepatu | Rp 35.000 |
| 👜 Cuci Tas | Rp 75.000 |
| 🧸 Cuci Boneka | Rp 25.000 |
| 🪟 Cuci Gorden | Rp 30.000/meter |

#### Paket Bundle

| Paket | Isi | Harga Normal | Harga Bundle |
|-------|-----|-------------|--------------|
| 🧺 PAKET HARIAN | 5 PCS Reguler | Rp 50.000 | **Rp 42.000** |
| 👔 PAKET KERJA | 3 PCS Cepat + Setrika | Rp 53.000 | **Rp 45.000** |
| 🏠 PAKET KELUARGA | 10 PCS Reguler | Rp 100.000 | **Rp 85.000** |
| ⚡ PAKET KILAT | 3 PCS Kilat | Rp 66.000 | **Rp 55.000** |

#### Add-Ons (Per PCS)

| Add-On | Harga |
|--------|-------|
| 🌸 Parfum (Fresh/Floral/Woody) | Rp 2.000 |
| 🦠 Anti Bakteri | Rp 3.000 |
| 💧 Pelembut Kain | Rp 1.500 |
| ✨ Whitening Boost | Rp 4.000 |
| 🪶 Down Jacket Special | Rp 10.000 |

### 7.3 Kategori & Produk (CRUD Owner)

| # | Kategori | Icon |
|---|----------|------|
| 1 | 👕 Atasan | 👕 |
| 2 | 👖 Bawahan | 👖 |
| 3 | 🧥 Outer | 🧥 |
| 4 | 👗 Dress / Gaun | 👗 |
| 5 | 🩲 Dalaman | 🩲 |
| 6 | 🧣 Aksesoris | 🧣 |
| 7 | 🛏️ Bed Cover / Selimut | 🛏️ |
| 8 | 🪟 Gorden / Tirai | 🪟 |
| 9 | 👟 Sepatu | 👟 |
| 10 | 👜 Tas | 👜 |

### 7.4 Inventory Settings

| Setting | Contoh |
|---------|--------|
| Alert Stok Minimum | 5 Liter |
| Auto Restock | ✅ On |
| Supplier Utama | CV. Bersih Jaya |
| Konsumsi Sabun/KG | 100ml/KG |
| Konsumsi Pewangi/KG | 5ml/KG |

### 7.5 Notifikasi Settings

| Notifikasi | Ke Siapa | On/Off |
|-----------|----------|--------|
| Order Baru Masuk | Kasir + Manager | ✅ |
| Status Berubah | Customer | ✅ |
| Baju Siap Ambil | Customer | ✅ |
| Stok Minimum | Manager | ✅ |
| Absen Staff | Manager | ✅ |
| Pembayaran Masuk | Kasir + Owner | ✅ |
| Laporan Harian | Owner | ✅ |
| Promo / Diskon | Semua Customer | ✅ |

---

## 8. 📦 ORDER & POS MODULE

### 8.1 Alur POS (Walk-In)

Customer datang ke cabang
Kasir input order di App:
Kategori (Atasan/Bawahan/dll)
Paket (Reguler/Cepat/Kilat)
Layanan (Setrika/Dry Clean/dll)
Add-on (Parfum/Anti Bakteri/dll)
Jumlah PCS
Timbang → catat berat/PCS
Sistem HITUNG OTOMATIS:
→ 4 PCS × Reguler (Rp 10.000) = Rp 40.000
→ 2 PCS × Setrika (Rp 8.000) = Rp 16.000
→ TOTAL = Rp 56.000
→ ATAU Bundle: Rp 45.000 ✅
Generate QR Code → Print / Tempel di baju
Customer bayar (Cash/QRIS/E-Wallet/Poin)
Sistem +Poin, +Laporan Keuangan, +Clean Streak
Staff terima baju → Scan QR → Foto BEFORE

### 8.2 Alur POS (Kurir Order)

Customer order via App → "Kurir Jemput"
Pilih jadwal: Pagi/Siang/Sore
Alamat jemput + alamat antar
Bayar di app (QRIS/E-Wallet) ATAU COD
Sistem ASSIGN kurir terdekat
Notifikasi ke kurir + customer

## 9. 🧺 LAUNDRY TRACKING MODULE

### 9.1 Status Tracking (9 Status)

| # | Status | Icon | Notif? | Scan By |
|---|--------|------|--------|---------|
| 1 | 📦 ORDER MASUK | 📦 | ✅ | Kasir |
| 2 | 🧺 SORTIR | 🧺 | ✅ | Staff |
| 3 | 🫧 PROSES CUCI | 🫧 | ✅ | Staff |
| 4 | 💨 PROSES KERING | 💨 | ✅ | Staff |
| 5 | 👔 PROSES SETRIKA | 👔 | ✅ | Staff |
| 6 | 🔍 QC | 🔍 | ✅ | Staff |
| 7 | ✅ SIAP AMBIL / SIAP ANTAR | ✅ | ✅ | Staff |
| 8 | 🚚 DIANTAR (kurir) | 🚚 | ✅ | Kurir |
| 9 | 🏠 SELESAI | 🏠 | ✅ | Customer |

### 9.2 Wardrobe Cloud ⭐

Staff foto BEFORE → Upload Firebase Storage → Customer lihat di App
Staff foto AFTER → Upload → Digital Wardrobe terbentuk
Customer bisa share → "Liat baju gue kinclong!"

## 10. 🏍️ KURIR MODULE

### 10.1 Alur Jemput

Kurir sampai alamat customer
ABSEN: ML Kit Face Detection (on-device) + Geotag
✅ Face detected + dalam radius → LULUS
❌ Gagal → FALLBACK: Geotag aja
SCAN QR → Status: "DIJEMPUT"
Foto BEFORE → Upload
Bawa ke cabang → Absen lagi (Face + Geotag cabang)
Serahin ke staff → Staff SCAN QR → "DITERIMA"

### 10.2 Alur Antar

Baju siap → Status: "SIAP ANTAR"
Foto AFTER → Upload → Notif customer
Sistem ASSIGN kurir terdekat
Kurir ambil → SCAN QR → "DIANTAR"
Absen: Face + Geotag (jalan)
Sampai → Absen: Face + Geotag (tujuan)
Serahin → Customer SCAN QR → "SELESAI" ✅
Rating kurir (1-5 bintang)

---

## 11. 👤 STAFF ABSEN MODULE

### 11.1 Absen Masuk

Klik "ABSEN MASUK"
STEP 1: ML Kit foto + geotag (480p, 15fps, on-device)
❌ Gagal → geotag aja
STEP 2: Blur Detection
✅ Jelas → foto diambil
⚠️ Buram → tetap ambil (ML Kit toleran)
→ geotag aja
STEP 3: Geotag Check (radius 100m)
✅ Dalam radius → lanjut
❌ Di luar → "Gak di cabang"
STEP 4: Cek Pos Tersedia?
✅ Ada → Auto assign → ON_POS
❌ Gak ada → Antrian no.X

### 11.2 Absen Pulang

Klik "ABSEN PULANG"
foto → Match
Geotag → Masih di cabang?
✅ Ya → lanjut
❌ Tidak → "Udah keluar cabang"
Semua order selesai?
✅ Ya → OFF_DUTY
❌ Belum → "Selesaikan dulu"

### 11.3 Status

| Status Pos | Artinya |
|------------|---------|
| 🟢 AVAILABLE | Kosong |
| 🔴 OCCUPIED | Dipakai staff |
| 🟡 MAINTENANCE | Rusak |

| Status Staff | Artinya |
|--------------|---------|
| 🟢 AVAILABLE | Belum absen |
| 🔵 ON_POS | Absen, pegang pos |
| 🔴 OFF_DUTY | Pulang |
| 🟠 ANTRIAN | Semua pos penuh |

### 11.4 Rule: 1 Orang = 1 Pos

✅ 1 staff = 1 pos = 1 kerjaan
❌ Gak boleh numpuk
✅ Auto assign pos kosong
✅ Penuh → ANTRIAN

---

## 12. ⚡ SMART PROCESS

| Fitur | Cara Kerja |
|-------|-----------|
| 🪑 Auto Assign Pos | Order masuk → cari pos kosong → auto assign |
| ⏰ Prediksi Selesai | "Order #1234 → estimasi 14:30" |
| 🚨 Bottleneck | "Pos 3 kelebihan kerjaan!" → alert manager |
| 📊 Staff Performance | Order selesai, rata-rata waktu, rating QC |

## 13. 🔔 NOTIFICATION MODULE (FCM)

| # | Notifikasi | Ke Siapa | Trigger |
|---|-----------|----------|---------|
| 1 | Order Baru Masuk | Kasir + Manager | Cloud Functions → FCM |
| 2 | Status Berubah | Customer | Firestore onSnapshot → FCM |
| 3 | Baju Siap Ambil | Customer | Cloud Functions → FCM |
| 4 | Stok Minimum | Manager | Cloud Functions (scheduled) → FCM |
| 5 | Absen Staff | Manager | Firestore onWrite → FCM |
| 6 | Pembayaran Masuk | Kasir + Owner | Cloud Functions → FCM |
| 7 | Laporan Harian | Owner | Cloud Functions (scheduled) → FCM |
| 8 | Promo / Diskon | Semua | Cloud Functions → FCM |
| 9 | Review Baru | Owner | Firestore onWrite → FCM |

## 14. 🔌 API SPECIFICATIONS (Cloud Functions)

| # | Function | Trigger | Deskripsi |
|---|----------|---------|-----------|
| 1 | `createOrder` | HTTPS (from App) | Buat order baru, generate QR, update stok |
| 2 | `updateOrderStatus` | HTTPS (from App) | Update status tracking, kirim FCM |
| 4 | `staffAttendance` | HTTPS (from App) | foto + geotag, update attendance |
| 5 | `assignKurir` | HTTPS (from App) | Auto assign kurir terdekat |
| 6 | `dailyReport` | Scheduled (00:00) | Generate laporan harian per cabang |
| 7 | `stockAlert` | Scheduled (every 6h) | Cek stok minimum, kirim FCM ke Manager |
| 8 | `cleanStreakCheck` | Scheduled (daily) | Cek streak customer, update poin |

## 15. 🔄 FLOW: LOGIN → LOGOUT (Per Role)

### 🔐 FLOW LOGIN (SEMUA ROLE)

┌─────────────────────────────────────────────┐
│ │
│ 1. BUKA APP │
│ → Splash Screen (1 detik) │
│ → "NEXTCLEAN" + Logo │
│ │
│ 2. HALAMAN LOGIN │
│ → Input: Email / No HP │
│ → Input: Password │
│ → ATAU: Login Google (1 tap) │
│ → ATAU: Login OTP (kirim ke HP) │
│ │
│ 3. FIREBASE AUTH VERIFY │
│ → Cek email/password di Firebase Auth │
│ → ATAU verify OTP │
│ → ATAU verify Google token │
│ │
│ 4. AMBIL DATA USER dari Firestore │
│ → GET /users/{userId} │
│ → Ambil: role, branchId, name, photo │
│ │
│ 5. REDIRECT ke Dashboard sesuai Role │
│ → Owner → Dashboard Owner │
│ → Manager → Dashboard Manager │
│ → Kasir → Dashboard Kasir │
│ → Staff → Dashboard Staff │
│ → Kurir → Dashboard Kurir │
│ → Customer → Dashboard Customer │
│ │
│ ✅ LOGIN BERHASIL │
│ │
└─────────────────────────────────────────────┘


### 🚪 FLOW LOGOUT (SEMUA ROLE)

┌─────────────────────────────────────────────┐
│ │
│ 1. KLIK "LOGOUT" (di Profile / Settings) │
│ │
│ 2. FIREBASE AUTH SIGN OUT │
│ → Hapus token lokal │
│ → Clear SharedPreferences │
│ │
│ 3. CLEAR LOCAL CACHE (opsional) │
│ → Hapus foto temporary │
│ → Reset state GetX │
│ │
│ 4. REDIRECT ke Halaman Login │
│ → Splash → Login Screen │
│ │
│ ✅ LOGOUT BERHASIL │
│ │
└─────────────────────────────────────────────┘


### 🔄 FLOW PER ROLE (Ringkas)

| Role | Login → Dashboard → Fitur Utama → Logout |
|------|------------------------------------------|
| 👑 **Owner** | Login → Dashboard Owner → Setting, Laporan, Edit Harga, Kelola Staff → Logout |
| 🏢 **Manager** | Login → Dashboard Manager → Laporan Cabang, Kelola Staff, Absen → Logout |
| 🖥️ **Kasir** | Login → Dashboard Kasir → POS, Terima Bayar, Pickup, Struk → Logout |
| 🧺 **Staff** | Login → Dashboard Staff → Absen → Scan QR → Ubah Status → Foto Before/After → Logout |
| 🏍️ **Kurir** | Login → Dashboard Kurir → Absen Jemput → Ambil Baju → Absen Antar → Serahin → Logout |
| 👤 **Customer** | Login → Dashboard Customer → Order → Track → Bayar → Poin → Ajak Temen → Logout |
---

## 16. 📱 SCREEN LIST

| # | Screen | Role |
|---|--------|------|
| 1 | 🎬 Splash Screen | Semua |
| 2 | 🔐 Login / Register | Semua |
| 3 | 🏠 Dashboard Owner | Owner |
| 4 | 🏪 Setting Toko | Owner |
| 5 | 💰 Setting Harga | Owner |
| 6 | 📂 Kategori & Produk | Owner |
| 7 | 👥 Manajemen Staff | Owner |
| 8 | 📊 Laporan Keuangan | Owner |
| 9 | 📈 Laporan Cabang | Manager |
| 10 | 👤 Kelola Staff Cabang | Manager |
| 11 | 🧾 POS / Order Baru | Kasir |
| 12 | 💳 Proses Pembayaran | Kasir |
| 13 | 📦 Pickup / Ambil | Kasir |
| 14 | 🖨️ Cetak Struk | Kasir |
| 15 | 📸 Absen Masuk | Staff |
| 16 | 📸 Absen Pulang | Staff |
| 17 | 🧺 Scan QR → Ubah Status | Staff |
| 18 | 📷 Foto Before / After | Staff |
| 19 | 👤 Absen Jemput | Kurir |
| 20 | 👤 Absen Antar | Kurir |
| 21 | 📦 Order Saya (Customer) | Customer |
| 22 | 🧺 Track Order | Customer |
| 23 | 💳 Bayar Order | Customer |
| 24 | 🎁 Poin & Loyalty | Customer |
| 25 | 👤 Profile | Semua |
| 26 | 🔔 Notifikasi | Semua |

---

## 17. 📊 KPI & METRICS

| KPI | Target | Cara Ukur |
|-----|--------|-----------|
| 📦 Order per Hari | 50+ | Firestore count |
| ⏱️ Rata-rata Waktu Proses | < 4 jam | Firestore timestamp diff |
| 💰 Revenue per Bulan | Rp 50jt+ | Firestore aggregate |
| 📈 Profit Margin | > 40% | Revenue - Cost |
| ⭐ Customer Rating | > 4.5 | Reviews collection |
| 🔄 Repeat Customer | > 30% | Loyalty data |
| 👤 Staff Attendance Rate | > 95% | Attendance collection |
| 📊 Stock Alert Response | < 1 jam | Alert → Restock time |

---

## 18. ✅ RINGKASAN FINAL

┌──────────────────────────────────────────────────┐
│ │
│ 🛠️ BACKEND → Firebase ONLY (Auth + Firestore     │
│ + Cloud Functions + Storage + FCM)               │
│ │
│ 🤖 FACE → ML Kit ON-DEVICE (offline,             │
│ HP kentang, kamera buram OK)                     │
│ │
│ 📱 HP KENTANG → APK < 25MB, RAM < 300MB,         │
│ Offline First, Lazy Loading                      │
│ │
│ 📸 KAMERA → 480p, 15fps, Blur Detection,         │
│ BURAM → Fallback Geotag                          │
│ │
│ 🎨 DESIGN → Magenta × White (Bright)             │
│ │
│ 💰 HARGA → 3 Paket + Layanan + Bundle            │
│ │
│ 👥 ROLE → 6 Role, Full Permission Matrix         │
│ │
│ 🧺 TRACKING → 9 Status, Realtime, Foto B/A       │
│ │
│ 🏍️ KURIR → Jemput + Antar                         │
│ │
│ 🧠 INVENTORY → Realtime, Alert, Prediksi         │
│ ⚡ PROCESS → Auto Assign, Prediksi, Bottleneck   │
│ = NEXTCLEAN 2.0 ✅                               │
└──────────────────────────────────────────────────┘
