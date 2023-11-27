# BookBuddies (Kelompok PBP - B02)

## Anggota Kelompok
- Farah Dhiya Ramadhina (2206082934)
- Fikri Massaid Wahab (2206083395)
- Marchelina Anjani S (2206082770)
- Nabil Nazir Ahmad (2206082663)
- Syarna Savitri (2206083565)

[Tautan Berita Acara](https://docs.google.com/spreadsheets/d/13ZaBtzo56iSxqGXi13WsE4dDRgZ_6BKtExHsz-Es0MM/edit?usp=sharing)

# Deskripsi Aplikasi
BookBuddies hadir sebagai aplikasi yang menjembatani komunitas pecinta buku yang inin saling berbagi dan meminjamkan koleksi buku satu sama lain. Tujuan aplikasi ini selain untuk meningkatkan literasi, adalah memberikan manfaat lebih untuk buku-buku yang sudah kita miliki dan kita baca dengan meminjamkannya ke pengguna lain yang ingin membaca buku yang kita miliki. Aplikasi ini memiliki manfaat untuk memudahkan akses membaca buku, misalnya meminjam buku antik yang tidak lagi dicetak, juga memungkinkan pengguna untuk meminjamkan buku yang telah mereka baca dan tidak lagi digunakan secara gratis. Selain itu, aplikasi ini juga menyediakan fitur review serta ulasan buku antar pengguna.
Berikut penjabaran manfaat dari aplikasi yang ingin kami buat:

**1. Meningkatkan Akses ke Dunia Buku:**<br>
Aplikasi ini memungkinkan pengguna untuk meminjam buku tanpa harus membelinya secara fisik, yang lebih praktis dibandingkan dengan pergi ke perpustakaan.

**2. Meningkatkan Literasi**<br>
Pengguna dapat berinteraksi dengan anggota komunitas lainnya untuk membahas buku, memberikan ulasan, dan berbagi pengalaman membaca, sehingga meningkatkan pemahaman dan minat literasi.

**3. Pengurangan Pembelian Buku Bajakan:**<br>
Dengan adanya aplikasi ini, pengguna dapat menghindari pembelian buku bajakan dan lebih memilih untuk meminjam buku yang masih dalam kondisi asli.

# Daftar Modul yang akan Diimplementasikan serta Kontak Kerja Anggota Kelompok
**1. Homepage - Fikri Massaid Wahab (2206083395)**<br>
Halaman ini menampilkan katalog buku-buku terbaru yang ready di pinjam dalam bentuk kartu (cards). Akan ada tampilan pop up card, untuk user/guest yang ingin melakukan sign in atau register.

**2. Halaman Informasi Buku - Marchelina Anjani S (2206082770)**<br>
Halaman ini berisi informasi rinci tentang buku, termasuk deskripsi, ulasan, dan informasi peminjaman.

**3. Halaman Bookmarks - Syarna Savitri (2206083565)**<br>
Halaman ini digunakan bagi member untuk menyimpan buku yang sedang dipinjam oleh orang lain ke dalam daftar tunggu (waiting list) mereka. Untuk membookmark suatu buku member harus memasukkan data seperti nama dan kapan mereka ingin meminjam buku tersebut. 

**4. Halaman Review Buku - Farah Dhiya Ramadhina (2206082934)**<br>
Halaman khusus bagi anggota untuk mereview tentang buku yang mereka baca, memberikan ulasan dan rating.

**5. Halaman Dashboard - Nabil Nazir Ahmad (2206082663)**<br>
Halaman ini adalah dashboard pribadi bagi anggota yang telah melakukan login. Mereka dapat melihat aktivitas peminjaman mereka, buku-buku yang mereka pinjam, dan lain-lain.

# Alur Pengintegrasian dengan Web Service Proyek Tengah Semester
- Integrasi aplikasi mobile dan web service dapat dilakukan dengan cara melakukan pengambilan data berformat JSON atau *Javascript Object Notation* di aplikasi mobile pada web service dengan menggunakan URL yang sesuai.
- Proses fetch dapat dilakukan dengan menggunakan `Uri.parse` dan `Dart` pada link yang sesuai, lalu mengambilnya menggunakan `GET` dengan tipe `application/json`.
- Selanjutnya, data yang telah diambil dapat dapat di-*decode* menggunakan `jsonDecode()` yang nantinya akan di-*convert* melalui model yang telah dibuat dan ditampilkan secara asinkronus menggunakan *widget* `FutureBuilder`.
- Data-data dari JSON tadi dapat digunakan secara CRUD pada kedua media secara ainkronus.

# Peran atau aktor pengguna aplikasi


