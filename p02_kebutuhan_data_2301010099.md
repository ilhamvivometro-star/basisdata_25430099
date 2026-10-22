# Dokumen Kebutuhan Data - Proyek Toko Daring (toko_099)
**NIM:** 25430099 
**Pengembang:** M Ilham A Hakim_099

---

## 1. Proses Bisnis Utama
1. **PB-01 (Pendaftaran & Profil Pelanggan):** Pengelolaan akun pelanggan daring.
2. **PB-02 (Manajemen Katalog Produk):** Pengelolaan data produk, stok, dan harga oleh admin.
3. **PB-03 (Pemrosesan Pesanan & Transaksi):** Alur pemesanan produk oleh pelanggan hingga konfirmasi pembayaran.
4. **PB-04 (Pengiriman & Pelacakan):** Pengelolaan resi dan status pengiriman barang via kurir.

---

## 2. Entitas Kandidat
1. `Pelanggan` (Entitas Utama)
2. `Produk` (Entitas Utama)
3. `Kategori` (Entitas Pendukung)
4. `Pesanan` (Entitas Transaksi Utama)
5. `Detail_Pesanan` (Entitas Transaksi Detail)
6. `Pembayaran` (Entitas Transaksi Finansial)

---

## 3. Aturan Bisnis (Business Rules)
* **AB-01:** Setiap pelanggan wajib mendaftarkan alamat email unik yang valid.
* **AB-02:** Setiap produk harus terikat pada minimal satu kategori produk.
* **AB-03:** Harga produk tidak boleh bernilai negatif ($> 0$).
* **AB-04:** Stok produk berkurang otomatis saat pesanan dikonfirmasi.
* **AB-05:** Satu pesanan dapat berisi lebih dari satu jenis produk (`Detail_Pesanan`).
* **AB-06:** Pembayaran dianggap sah jika jumlah bayar sama dengan total tagihan pesanan.
* **AB-07:** Setiap kelipatan belanja Rp10.000 bernilai 1 poin loyalitas bagi pelanggan.
* **AB-08:** Status pesanan secara berurutan adalah: *Pending*, *Paid*, *Shipped*, *Completed*, atau *Cancelled*.

---

## 4. Kebutuhan Informasi (Information Requirements)
* **KI-01:** Laporan rekapitulasi penjualan bulanan per kategori produk.
* **KI-02:** Daftar produk dengan jumlah stok di bawah batas minimum (peringatan stok tipis).
* **KI-03:** Riwayat transaksi dan status pengiriman pesanan per pelanggan.
* **KI-04:** Laporan omset bersih dan metode pembayaran terpopuler.
* **KI-05:** Daftar 10 pelanggan paling aktif berdasarkan total belanja dan poin loyalitas.

---

## 5. Matriks CRUD

| Entitas | PB-01 (Profil) | PB-02 (Katalog) | PB-03 (Pesanan) | PB-04 (Pengiriman) |
| :--- | :---: | :---: | :---: | :---: |
| `Pelanggan` | **CRU** | - | **R** | **R** |
| `Produk` | - | **CRUD** | **RU** | - |
| `Kategori` | - | **CRUD** | **R** | - |
| `Pesanan` | - | - | **CRU** | **RU** |
| `Detail_Pesanan` | - | - | **CR** | **R** |
| `Pembayaran` | - | - | **CRU** | - |

---

## 6. Kamus Data Awal (20 Elemen)

| No | Elemen Data | Entitas | Tipe Data | Keterangan / Aturan | Penanggung Jawab |
| :---: | :--- | :--- | :--- | :--- | :--- |
| 1 | `id_pelanggan` | Pelanggan | INT (PK) | Auto-increment, Unik | DB Administrator |
| 2 | `nama_lengkap` | Pelanggan | VARCHAR(100) | Tidak boleh kosong | Data Analyst |
| 3 | `email` | Pelanggan | VARCHAR(100) | Format email unik | System Admin |
| 4 | `kata_sandi` | Pelanggan | VARCHAR(255) | Hash bcrypt | Security Officer |
| 5 | `no_telepon` | Pelanggan | VARCHAR(15) | Nomor aktif | Customer Support |
| 6 | `poin_loyalitas` | Pelanggan | INT | Default = 0 | Finance |
| 7 | `id_produk` | Produk | INT (PK) | Auto-increment, Unik | Inventory Admin |
| 8 | `nama_produk` | Produk | VARCHAR(150) | Tidak boleh kosong | Product Manager |
| 9 | `harga` | Produk | DECIMAL(10,2) | Value $> 0$ | Finance |
| 10 | `stok` | Produk | INT | Default = 0 | Warehouse Manager |
| 11 | `id_kategori` | Kategori | INT (PK) | Auto-increment | Product Manager |
| 12 | `nama_kategori` | Kategori | VARCHAR(50) | Unik | Product Manager |
| 13 | `id_pesanan` | Pesanan | INT (PK) | Auto-increment, Unik | Order Manager |
| 14 | `tgl_pesanan` | Pesanan | DATETIME | Timestamp saat checkout | Order Manager |
| 15 | `total_harga` | Pesanan | DECIMAL(12,2) | Total belanja + ongkir | Finance |
| 16 | `status_pesanan` | Pesanan | ENUM | Pending/Paid/Shipped | Order Manager |
| 17 | `jumlah` | Detail_Pesanan | INT | Minimal 1 | Order Manager |
| 18 | `subtotal` | Detail_Pesanan | DECIMAL(12,2) | `harga` x `jumlah` | Finance |
| 19 | `metode_bayar` | Pembayaran | VARCHAR(50) | Transfer/E-Wallet/CC | Finance |
| 20 | `status_bayar` | Pembayaran | VARCHAR(20) | Success/Pending/Failed | Finance |

---

## 7. Kebutuhan Non-Fungsional & Keamanan Data Pribadi

1. **Identifikasi Data Pribadi (PII):**
   * Data Pribadi Sensitif: `nama_lengkap`, `email`, `kata_sandi`, `no_telepon`, `alamat_pengiriman`.
2. **Hak Akses & Otorisasi:**
   * **Pelanggan:** Hanya dapat melihat dan mengubah data pribadi milik sendiri.
   * **Kurir / Tim Logistik:** Hanya dapat membaca `nama_lengkap`, `no_telepon`, dan `alamat_pengiriman` untuk keperluan pengantaran barang.
   * **Admin System:** Dilarang melihat `kata_sandi` dalam teks asli (*plaintext*).

---

## 8. Dokumen Sumber Fiktif & Bedah Data

### **Dokumen Sumber: Nota Penjualan Daring (Invoice)**
```text
============================================================
                     TOKO DARING 099
                Nota Pemesanan / Invoice
============================================================
No. Invoice : INV/20261023/099
Tanggal     : 23 Oktober 2026
Pelanggan   : M Ilham A Hakim (ID: 099)
Alamat      : Jl. Merdeka No. 12, Metro, Lampung

------------------------------------------------------------
No  Nama Produk           Harga Satuan   Qty   Subtotal
------------------------------------------------------------
1   Mouse Wireless        Rp  150.000     2    Rp  300.000
2   Keyboard Mechanical   Rp  450.000     1    Rp  450.000
------------------------------------------------------------
                                Total Belanja : Rp  750.000
                                Ongkos Kirim  : Rp   20.000
                                Diskon Poin   : Rp  (10.000)
                                GRAND TOTAL   : Rp  760.000
                                Poin Diperoleh: 76 Poin
============================================================