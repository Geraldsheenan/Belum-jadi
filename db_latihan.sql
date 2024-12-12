-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 12 Des 2024 pada 19.09
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_latihan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `jual`
--

CREATE TABLE `jual` (
  `idjual` int(11) NOT NULL,
  `tgljual` date NOT NULL,
  `idproduct` varchar(10) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `namaproduct`
--

CREATE TABLE `namaproduct` (
  `idproduct` varchar(10) NOT NULL,
  `product` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  `image` text NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `namaproduct`
--

INSERT INTO `namaproduct` (`idproduct`, `product`, `price`, `image`, `description`) VALUES
('P202409001', 'Macbook Air 13 inci M3', 20000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fa%2Fp%2Fapple_macbook_air_15_inci_m3_2024_midnight_1_2_1.jpg&w=1080&q=45', 'Performa meningkat dengan chip M3 berbasis 3nm. Ringan (1,24 kg), layar Liquid Retina tajam, baterai hingga 18 jam, dukungan dua layar eksternal, dan Wi-Fi 6E.'),
('P202409002', 'Macbook Air 15 inci M3', 24000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fa%2Fp%2Fapple_macbook_air_15_inci_m3_2024_midnight_1_2_1.jpg&w=1080&q=45', 'Layar 15 inci memberikan ruang kerja lebih luas. Chip M3 memberikan performa andal. Audio Spatial dan desain tipis untuk portabilitas tinggi.'),
('P202409003', 'Macbook Air 15 inci M2,2023', 27000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fa%2Fp%2Fapple_macbook_air_15_inci_m3_2024_space_gray_1_2_1.jpg&w=1080&q=45', 'Performa chip M2 tangguh, layar besar untuk multitasking, desain tipis dan ringan (1,51 kg), baterai hingga 18 jam.'),
('P202409004', 'Macbook Pro 14 inci M3', 35000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fm%2Fa%2Fmacbook_pro_14-inch_m3_space_grey_1_1.jpg&w=1080&q=45.jpg', 'Chip M3 Pro/Max untuk tugas berat, layar ProMotion 120Hz, masa pakai baterai hingga 18 jam, mendukung hingga 3 layar eksternal.'),
('P202409005', 'MacBook Pro 16 inci M3 Pro\r\n', 48000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fm%2Fa%2Fmacbook_pro_16-inch_m3_pro_max_silver_1_1_2.jpg&w=1080&q=45', 'Performa maksimal dengan chip M3 Pro, layar lebih besar untuk produktivitas, daya tahan baterai hingga 22 jam, dan fitur ProMotion.'),
('P202409006', 'MacBook Pro 13 inci M2, 2022\r\n', 22000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fm%2Fa%2Fmacbook_pro_14_inci_m2_2023_silver_1.jpg&w=1080&q=45', 'Chip M2 dengan efisiensi daya tinggi, Touch Bar modern, dan desain ringan.'),
('P202409007', 'MacBook Pro 16 inci M2 Pro\r\n', 48000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fm%2Fa%2Fmacbook_pro_16_inci_m2_2023_silver_1.jpg&w=1080&q=45', 'Chip M2 Pro untuk performa tinggi, layar besar dengan warna akurat, dan baterai hingga 22 jam.'),
('P202409008', 'MacBook Pro 14 inci M3 Pro 2023\r\n', 35000000, 'https://ibox.co.id/_next/image?url=https%3A%2F%2Fcdnpro.eraspace.com%2Fmedia%2Fcatalog%2Fproduct%2Fm%2Fa%2Fmacbook_pro_14-inch_m3_space_grey_1_1.jpg&w=1080&q=45', 'Ditenagai oleh chip M3 terbaru dengan peningkatan performa hingga 50% lebih cepat dibandingkan generasi sebelumnya, ideal untuk pengeditan video, desain grafis, dan aplikasi profesional.');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `nama` text NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `foto` text NOT NULL,
  `createdDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `nama`, `alamat`, `telepon`, `foto`, `createdDate`) VALUES
(1, 'sheenan@gmail.com', '$2y$10$QI.vJ1p/pQtmGFCd8.Bs6uDiqQ8bVbUdsM05o1Axsm.C5seBN0eC2', 'sheenan', 'sheenan', '111', 'taylor.jpg', '2024-12-01 15:40:48');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `jual`
--
ALTER TABLE `jual`
  ADD PRIMARY KEY (`idjual`);

--
-- Indeks untuk tabel `namaproduct`
--
ALTER TABLE `namaproduct`
  ADD PRIMARY KEY (`idproduct`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
