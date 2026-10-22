-- 1. Membuat basis data khusus proyek toko daring
CREATE DATABASE IF NOT EXISTS toko_099 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Membuat akun pengembang khusus untuk proyek ini
CREATE USER IF NOT EXISTS 'dev_099'@'localhost' IDENTIFIED BY 'PasswordDev#099';

-- 3. Memberikan seluruh hak akses (privileges) pada basis data toko_099 ke akun dev_099
GRANT ALL PRIVILEGES ON toko_099.* TO 'dev_099'@'localhost';

-- 4. Terapkan perubahan hak akses
FLUSH PRIVILEGES;

-- 5. Masuk ke dalam basis data toko_099 untuk mulai membuat tabel
USE toko_099;

-- 6. Contoh pembuatan tabel awal (Pelanggan)
CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email_pelanggan VARCHAR(100) NOT NULL UNIQUE,
    no_hp VARCHAR(15) NOT NULL,
    alamat TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 7. Contoh pembuatan tabel produk/katalog
CREATE TABLE IF NOT EXISTS produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(150) NOT NULL,
    harga DECIMAL(12,2) NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    deskripsi TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 8. Contoh pembuatan tabel transaksi pesanan
CREATE TABLE IF NOT EXISTS pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    no_invoice VARCHAR(30) NOT NULL UNIQUE,
    id_pelanggan INT NOT NULL,
    tgl_pesanan DATETIME NOT NULL,
    total_bayar DECIMAL(12,2) NOT NULL,
    status_pesanan ENUM('pending', 'dibayar', 'dikirim', 'selesai', 'batal') DEFAULT 'pending',
    CONSTRAINT fk_pesanan_pelanggan FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
) ENGINE=InnoDB;