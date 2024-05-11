-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 11 Bulan Mei 2024 pada 18.02
-- Versi server: 10.4.14-MariaDB
-- Versi PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kebudayaan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `budaya`
--

CREATE TABLE `budaya` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `budaya`
--

INSERT INTO `budaya` (`id`, `title`, `content`, `image`) VALUES
(1, 'Tarian', 'Tari Minangkabau tidak hanya dimainkan oleh kaum perempuan tapi juga oleh laki-laki. Ciri khas tari Minangkabau adalah cepat, keras, menghentak, dan dinamis. Adapula tarian yang memasukkan gerakan silat ke dalamnya, yang disebut randai. Tari-tarian Minangkabau lahir dari kehidupan masyarakat Minangkabau yang egaliter dan saling menghormati. Dalam pesta adat ataupun perkawinan, masyarakat Minangkabau memberikan persembahan dan hormat kepada para tamu dan menyambutnya dengan tarian galombang.', 'tari_piring.jpg'),
(2, 'Tabuik', 'Festival Tabuik merupakan bagian dari cara masyarakat merayakan tradisi Tabuik secara tahunan. Ketika upacara adat ini sudah diakui oleh pemerintah sebagai bagian berharga dari kehidupan berbangsa, maka festival Tabuik pun menjadi bagian dari bangsa Indonesia. Festival Tabuik sudah berlangsung sejak puluhan tahun, disebutkan bahwa festival ini sudah berlangsung sejak abad ke-19 Masehi. Festival Tabuik ini kini tidak hanya menjadi bagian dari adat masyarakat setempat semata melainkan juga menjadi salah satu bagian dari komoditas pariwisata daerah. Festival Tabuik dilaksanakan dalam satu rangkaian untuk menghormati atau sebagai hari perayaan peringatan wafatnya cucu Nabi Muhammad SAW, yang bernama Husain bin Ali. Peringatan ini selalu dilaksanakan pada tanggal 10 Muharram sesuai dengan hari wafatnya cucu nabi Muhammad SAW Husain Bin Ali yang meninggal dalam perang di padang Karbala\r\nFestival Tabuik sendiri merujuk pada penggunaan bahasa arab ‘tabut’ yang berarti peti kayu. Nama tersebut mengacu kepada legenda paska kematian cucu nabi, muncul makhluk seekor kuda bersayap dengan kepa manusia. Makhluk itu disebut Buraq. Dalam legenda itu dikisahkan bahwa peti kayu yang dibawa oleh kuda berkepala manusia itu berisi potongan jenazah Hussein. Berdasarkan legenda tersebutlah, maka dalam festival Tabuik selalu muncul makhluk tiruan buraq untuk mengusung peti kayu ‘tabut’ di atas punggungnya. Ritual ini sendiri baru muncul sekitar tahun 1826-1828 Masehi. ', 'tabuik.jpg'),
(3, 'Rendang', 'hidangan berbahan dasar daging yang dihasilkan dari proses memasak suhu rendah dalam waktu lama dengan menggunakan aneka rempah-rempah dan santan. Proses memasaknya memakan waktu berjam-jam (biasanya sekitar empat jam) hingga yang tinggal hanyalah potongan daging berwarna hitam pekat dan dedak. Dalam suhu ruangan, rendang dapat bertahan hingga berminggu-minggu. Rendang yang dimasak dalam waktu yang lebih singkat dan santannya belum mengering disebut kalio, berwarna cokelat terang keemasan.\r\n\r\nRendang dapat dijumpai di rumah makan Padang di seluruh dunia. [butuh rujukan] Masakan ini populer di Indonesia dan negara-negara Asia Tenggara lainnya, seperti Malaysia, Singapura, Brunei, Filipina, dan Thailand. Di daerah asalnya, Minangkabau, rendang disajikan di berbagai upacara adat dan perhelatan istimewa. Meskipun rendang merupakan masakan tradisional Minangkabau, teknik memasak serta pilihan dan penggunaan bumbu rendang berbeda-beda menurut daerah.\r\n\r\nPada 2011, rendang pernah dinobatkan sebagai hidangan yang menduduki peringkat pertama daftar World\'s 50 Most Delicious Foods (50 Hidangan Terlezat Dunia) versi CNN International.[1] Pada 2018, rendang secara resmi ditetapkan sebagai salah satu dari lima hidangan nasional Indonesia.[2]', 'rendang.jpg'),
(4, 'Rumah Gadang', 'Rumah Gadang adalah nama untuk rumah adat Minangkabau yang merupakan rumah tradisional dan banyak jumpai di Sumatera Barat, Indonesia. Rumah ini juga disebut dengan nama lain oleh masyarakat setempat dengan nama Rumah Bagonjong atau ada juga yang menyebut dengan nama Rumah Baanjuang.[1]\r\n\r\nRumah dengan model ini juga banyak dijumpai di Sumatera Barat. Namun tidak semua kawasan di Minangkabau (darek) yang boleh didirikan rumah adat ini, hanya pada kawasan yang sudah memiliki status sebagai nagari saja Rumah Gadang ini boleh didirikan. Begitu juga pada kawasan yang disebut dengan rantau, rumah adat ini juga dahulunya tidak ada yang didirikan oleh para perantau Minangkabau.', 'rumahgadang.jpg'),
(5, 'Pacu Jawi', 'Pacu jawi (dari bahasa Minangkabau: \"balapan sapi\") adalah perlombaan olahraga tradisional di Kabupaten Tanah Datar, Sumatera Barat, Indonesia. Dalam acara ini, sepasang sapi berlari di lintasan sawah berlumpur dengan panjang sekitar 60–250 meter, sementara seorang joki berdiri di belakangnya dengan memegang kedua sapi. Walaupun namanya mengandung arti \"balapan\", sapi-sapi hanya dilepas sepasang tanpa lawan tanding, dan tidak ada pemenang secara resmi. Tiap pasang sapi berlari secara bergiliran, sementara penonton menilai sapi-sapi tersebut (terutama berdasarkan kecepatan dan kemampuan berjalan lurus), dan kadang membeli sapi-sapi unggulan dengan harga jauh di atas harga normal. Penduduk Tanah Datar (terutama dari empat kecamatan yaitu Sungai Tarab, Pariangan, Lima Kaum, dan Rambatan) telah menyelenggarakan acara ini selama berabad-abad untuk merayakan masa panen padi. Acara ini juga diiringi pesta desa dan budaya yang disebut alek pacu jawi. Belakangan, acara ini menjadi atraksi wisata yang didukung pemerintah, dan menjadi objek fotografi yang mendapatkan berbagai penghargaan di bidang fotografi. Sejak 2020, pacu jawi diakui secara resmi oleh pemerintah Republik Indonesia sebagai salah satu Warisan Budaya Tak Benda khas Indonesia dalam bidang Seni Pertunjukan yang berasal dari Sumatera Barat', 'pacujawi.jpg'),
(6, 'Makan Bajamba', 'Makan Bajamba adalah tradisi makan bersama dari satu pinggan besar, duduk bersama makan di satu ruangan. Tujuannya adalah untuk mempererat tali persaudaraan antara sesama manusia dan juga sebagai bukti keakraban suku Minang. Setiap daerah memiliki gaya makan bajamba masing-masing. Yang membedakannya pada umumnya adalah jenis hidangan makanannya. Untuk daerah Bukittinggi yang dipengaruhi oleh adat Kurai Limo Jorong, hidangannya terdiri dari samba nan salapan. Yaitu ada delapan jenis makanan yang wajib dihidangkan, gulai ayam, rendang, asam padeh daging atau yang lebih dikenal dengan gulai anyang, gulai babat atau dikenal sebagai paruik lauak, karupuk tunjuk balado, terung buat digoreng pakai cabe, pergedel dan ikan pang. Deretan makanan tersebut merupakan yang wajib disajikan dalam makan bajamba.', 'makan.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tokoh`
--

CREATE TABLE `tokoh` (
  `id` int(11) NOT NULL,
  `nama` varchar(250) NOT NULL,
  `asal` varchar(250) NOT NULL,
  `foto` varchar(250) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `jenis_kelamin` varchar(250) NOT NULL,
  `deskripsi` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tokoh`
--

INSERT INTO `tokoh` (`id`, `nama`, `asal`, `foto`, `tgl_lahir`, `jenis_kelamin`, `deskripsi`) VALUES
(6, 'Kamardi Rais', 'Payakumbuh', 'rais.jpg', '1993-03-12', 'Laki-laki', 'Kamardi merupakan putra Minangkabau asal Aie Tabik, Payakumbuh. Ayahnya Rais Dt. Maudun adalah seorang wali nagari di kampungnya. Setelah menyelesaikan pendidikan di Payakumbuh, tahun 1954 ia memulai kariernya sebagai wartawan di Harian Penerangan. Kamardi juga pernah menjadi Pemimpin Redaksi Harian Semangat di Padang. Puncak kariernya di dunia kewartawanan diraih ketika ia menjabat sebagai Ketua Persatuan Wartawan Indonesia (PWI) Cabang Sumatera Barat. Pada tahun 1987 ia terpilih menjadi anggota DPRD Provinsi Sumatera Barat. Dan sejak tahun 1999 hingga akhir hayatnya, ia memimpin Lembaga Kerapatan Adat Alam Minangkabau'),
(7, 'Dr. Edwar Djamaris', 'Cingkariang, Agam, Sumatera Barat', 'edwar.jpg', '1941-07-07', 'Laki-laki', 'Edwar Djamaris yang lahir pada tanggal 7 Juli 1941 di Cingkariang, Agam, Sumatera Barat ini merupakan anak kedua dari tiga bersaudara. Ia menikah dengan seorang wanita bernama Derwita dan telah dikaruniai empat orang anak, yaitu 2 laki-laki dan 2 perempuan, serta dianugerahi enam orang cucu.\r\n\r\nEdwar Djamaris meninggal dunia dalam perawatan di Rumah Sakit Persahabatan, Rawamangun, Jakarta Timur pada hari Minggu 21 Oktober 2012 dalam usia 71 tahun. Jenazahnya dimakamkan di Tempat Pemakaman Umum (TPU) Perwira, Bekasi, Jawa Barat.'),
(8, 'Tuanku Imam Bonjol', 'Bonjol, Luhak Agam, Pagaruyung', 'imambonjol.jpg', '1903-07-11', 'Laki-laki', 'Nama asli dari Tuanku Imam Bonjol adalah Muhammad Syahab, yang lahir di Bonjol pada 1 Januari 1772.[4] Ia merupakan putra dari pasangan Khatib Bayanuddin dan Hamatun.[4] Ayahnya, Khatib Bayanuddin merupakan seorang alim ulama yang berasal dari Sungai Rimbang, Suliki, Lima Puluh Kota.[4][5] Ibunya Hamatun dan pamannya Syekh Usman adalah perantau bangsa Arab yang datang ke Alai Ganggo Mudik, dan diterima masuk ke dalam tatanan adat Minangkabau.[6] Syekh Usman menjadi penghulu kaum keturunannya, sebagai bagian klan suku Koto.[6]\r\n\r\nSetelah dewasa dan menjadi ulama dan pemimpin, Muhammad Syahab mendapat beberapa gelar dari masyarakat setempat, yaitu Peto Syarif, Malin Basa, Datuk Bagindo Suman,[6] dan terakhir Tuanku Imam.[4][7]\r\n\r\nTuanku Imam Bonjol tidak terlibat sejak awal dalam Perang Padri. Ia baru terlibat setelah Tuanku nan Renceh dari Kamang, Agam sebagai salah seorang pemimpin Harimau Nan Salapan menunjuknya sebagai imam (pemimpin) bagi kaum Padri di Bonjol.[4] Ia akhirnya lebih dikenal dengan sebutan Tuanku Imam Bonjol.[4]');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(250) NOT NULL,
  `name` varchar(250) NOT NULL,
  `phone` int(15) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `name`, `phone`, `email`, `password`) VALUES
(1, '', 'ilfiza', 812345678, 'ilfiza@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(3, 'mutia', 'mutia', 2147483647, 'mutiara@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(4, '', 'hjhj', 0, 'hj@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(5, 'rahmi', 'rahmi', 2147483647, 'rahmi@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(6, 'dini', 'dini', 2147483647, 'dini@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(8, 'dina', 'dina', 867565454, 'dina@gmail.com', '$2y$10$04B.ri./5zJjI931GXD4e.swcV5Fmkl7hue9X1g5hBhtK1wsBaEhG'),
(9, 'indah', 'indah', 2147483647, 'indah@gmail.com', '$2y$10$AargRtxwqgM2OGsD2pJsKOyxFW.7lgbL8ax39ui8rktiEp.Jvpu9C'),
(10, '1', '1', 12323, '12@gmail.com', '$2y$10$L1V2LjzDfoYCdRSwQEJEAOAbs/qNl2cjuWrXZ75SPy.Xwk1rpm4ly'),
(12, 'admin', 'admin', 2147483647, 'admin@gmail.com', '$2y$10$1tHfPwezDw6hOFISZS0aVeKSNuzXzqwJpbG./yaXjvLsaR4lQzx2i'),
(14, 'iin', 'iin', 2147483647, 'iin@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(17, 'diaa', 'diaa', 83673673, 'diaa@gmail.com', '25d55ad283aa400af464c76d713c07ad'),
(18, 'fiza', 'fiza', 812345262, 'fiza@gmail.com', '25d55ad283aa400af464c76d713c07ad');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `budaya`
--
ALTER TABLE `budaya`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `tokoh`
--
ALTER TABLE `tokoh`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `budaya`
--
ALTER TABLE `budaya`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `tokoh`
--
ALTER TABLE `tokoh`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
