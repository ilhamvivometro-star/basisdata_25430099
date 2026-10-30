# Laporan Normalisasi Basis Data - Pertemuan 04
**Nama:** M Ilham A Hakim  **NPM:** 25430099  **Kelas:** Basis Data  **Tanggal:** 26 Oktober 2026

---

## 1. Titik Awal UNF hingga 3NF
Dokumen nota penjualan daring (`toko_099`) diuraikan dari bentuk tidak normal (UNF) hingga mencapai bentuk normal ketiga (3NF) guna menghindari redudansi data dan anomali pembaruan.

## 2. Skema Relasi 3NF Final
1. **Pelanggan** (`id_pelanggan`, `nama_lengkap`, `email`, `alamat`, `poin_loyalitas`)
2. **Kategori** (`id_kategori`, `nama_kategori`)
3. **Produk** (`id_produk`, `id_kategori`, `nama_produk`, `harga`, `stok`)
4. **Pesanan** (`id_pesanan`, `id_pelanggan`, `tgl_pesanan`, `total_harga`, `status_pesanan`)
5. **Detail_Pesanan** (`id_detail`, `id_pesanan`, `id_produk`, `jumlah`, `subtotal`)
6. **Pembayaran** (`id_pembayaran`, `id_pesanan`, `metode_bayar`, `jumlah_bayar`, `status_bayar`)

## 3. Catatan Perubahan ERD
Tidak ada perubahan entitas utama dari Pertemuan 3, namun batasan (*constraints*) integritas kolom diperketat sesuai hasil analisis dependensi fungsional 3NF untuk dipersiapkan ke skrip DDL Pertemuan 5.