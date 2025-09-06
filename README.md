# expense_tracker

A new Flutter project.

## Getting Started

/\*_context object/ value meta data yang ada di setiap widget '
_ context dipakai untuk menghubungkan widget dengan widget lain di dalam widget tree.
_ Makanya di builder function hampir selalu ada parameter ctx (atau kadang ditulis juga context kalau nggak takut bentrok).'
_ Context itu “alamat” widget
_ context (dari parent) dipakai waktu mau buka modal → karena modal harus tau mau ditempel di layar mana.
_ ctx (dari builder) dipakai kalau mau akses widget di dalam modal itu sendiri (misalnya Navigator.pop(ctx) buat nutup modal).
_ dimana ada builder function, disitu ada build context baru (ctx) yang spesifik buat widget yang dibangun didalam builder function itu.
_ untuk apa ctx itu? ctx itu dipakai kalau kita mau akses widget di dalam modal itu sendiri (misalnya Navigator.pop(ctx) buat nutup modal).
_ jadi intinya, context itu “alamat” widget, dan kita butuh context yang tepat buat interaksi yang tepat juga.
_/
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
