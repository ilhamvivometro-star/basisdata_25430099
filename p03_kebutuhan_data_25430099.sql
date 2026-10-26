-- Buat Basis Data
CREATE DATABASE IF NOT EXISTS toko_099;
USE toko_099;

-- 1. Tabel Kategori Produk
CREATE TABLE Kategori (
    id_kategori INT AUTO_INCREMENT PRIMARY KEY,
    nama_kategori VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Tabel Produk
CREATE TABLE Produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    id_kategori INT NOT NULL,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(10,2) NOT NULL CHECK (harga > 0),
    stok INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_kategori) REFERENCES Kategori(id_kategori) ON DELETE CASCADE
);

-- 3. Tabel Pelanggan (dengan atribut Poin Loyalitas)
CREATE TABLE Pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    kata_sandi VARCHAR(255) NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT NOT NULL,
    poin_loyalitas INT NOT NULL DEFAULT 0
);

-- 4. Tabel Pesanan (Transaksi Utama)
CREATE TABLE Pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    tgl_pesanan DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(12,2) NOT NULL,
    poin_diperoleh INT DEFAULT 0,
    poin_ditukar INT DEFAULT 0,
    status_pesanan ENUM('Pending', 'Paid', 'Shipped', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (id_pelanggan) REFERENCES Pelanggan(id_pelanggan) ON DELETE CASCADE
);

-- 5. Tabel Detail_Pesanan (Entitas Asosiatif Many-to-Many Pesanan & Produk)
CREATE TABLE Detail_Pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_produk INT NOT NULL,
    jumlah INT NOT NULL CHECK (jumlah > 0),
    harga_satuan_saat_beli DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_pesanan) REFERENCES Pesanan(id_pesanan) ON DELETE CASCADE,
    FOREIGN KEY (id_produk) REFERENCES Produk(id_produk) ON DELETE CASCADE
);

-- 6. Tabel Pembayaran
CREATE TABLE Pembayaran (
    id_pembayaran INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL UNIQUE,
    tgl_bayar DATETIME DEFAULT CURRENT_TIMESTAMP,
    metode_bayar VARCHAR(50) NOT NULL,
    jumlah_bayar DECIMAL(12,2) NOT NULL,
    status_bayar VARCHAR(20) NOT NULL DEFAULT 'Success',
    FOREIGN KEY (id_pesanan) REFERENCES Pesanan(id_pesanan) ON DELETE CASCADE
);