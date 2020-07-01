# Resto Finder

[![Fork](https://img.shields.io/github/forks/yusriltakeuchi/restofinder?style=social)](https://github.com/yusriltakeuchi/restofinder/fork)&nbsp; [![Star](https://img.shields.io/github/stars/yusriltakeuchi/restofinder?style=social)](https://github.com/yusriltakeuchi/restofinder/star)&nbsp; [![Watches](https://img.shields.io/github/watchers/yusriltakeuchi/restofinder?style=social)](https://github.com/yusriltakeuchi/restofinder/)&nbsp;


<p><img  src="https://i.ibb.co/59cLNmp/cover.png"/>
<img  src="https://i.ibb.co/Pzyb9h2/cover2.png"/></p>

Restofinder adalah sebuah aplikasi sederhana yang menampilkan daftar restoran terdekat dari lokasi kita dengan beberapa spesifik jenis dan menu yang dihidangkan. Project ini menggunakan API Zoomato untuk mencari restoran, jadi kita harus membuat apikey Zoomato terlebih dahulu


### Tools Feature:

- Get Nearby Restaurant 
- Get Collections
- Get Restaurant By Collection
- Restaurant Details
- Search Restaurant
- Geocoding & GPS System
 

  ### Setup
  1. Anda harus membuat API Key Zoomato pada situs <a href="https://developers.zomato.com/api?lang=id">Zoomato Developer</a>
  2. Masukkan Api Key yang sudah dibuat pada auth utils seperti berikut:
	 **lib/core/utils/auth_utils.dart**
```dart
class AuthUtils {
  static AuthUtils instance = AuthUtils();

  //* Insert with your Zoomato API KEY
  Future getToken() async {
    return "<YOUR ZOOMATO API KEY>";
  }
}
```
