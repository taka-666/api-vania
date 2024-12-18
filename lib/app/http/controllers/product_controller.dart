// import 'package:vania/vania.dart';
// import 'package:vania_sample/app/models/activity.dart';

// class ProductController extends Controller {
//   Future<Response> index() async {
//     return Response.json({'message': 'Hello World'});
//   }

//   Future<Response> create(Request request) async {
//     // memberikan validasi tidak boleh kosong
//     request.validate({
//       'name': 'required',
//       'description': 'required',
//       'price': 'required',
//     }, {
//       'name.required': 'Nama produk tidak boleh kosong',
//       'description.required': 'Deskripsi produk tidak boleh kosong',
//       'price.required': 'Harga produk tidak boleh kosong',
//     });

//     try {
//       // final requestData = request.input();
//       final productData = request.input();

//       final existingProduct = await Product()
//           .query()
//           .where('name', '=', productData['name'])
//           .first();

//       if (existingProduct != null) {
//         return Response.json({
//           "message": "Produk dengan nama ini sudah ada",
//         }, 409);
//       }

//       productData['created_at'] = DateTime.now().toIso8601String();

//       await Product().query().create(productData);

//       return Response.json({
//         "message": "Product berhasil ditambahkan",
//         "data": productData,
//       }, 201);
//     } catch (e) {
//       return Response.json(
//         {
//           "message": "Error terjadi pada server, silahkan coba lagi nanti",
//         },
//         500,
//       );
//     }
//   }

//   Future<Response> store(Request request) async {
//     try {
//       request.validate({
//         'name': 'required',
//         'description': 'required',
//         'price': 'required',
//       }, {
//         'name.required': 'Nama produk tidak boleh kosong',
//         'name.string': 'Nama produk harus berupa text',
//         'name.max.length': 'Nama produk maksimal 100 karakter',
//         'description.required': 'Deskripsi produk tidak boleh kosong',
//         'description.string': 'Deskripsi produk harus berupa text',
//         'description.max.length': 'Nama produk maksimal 255 karakter',
//         'price.required': 'Harga produk tidak boleh kosong',
//         'price.numeric': 'Nama produk harus berupa angka',
//         'price.min': 'Harga produk tidak boleh kurang dari 0'
//       });
//       // final requestData = request.input();

//       final productData = request.input();

//       final existingProduct = await Product()
//           .query()
//           .where('name', '=', productData['name'])
//           .first();

//       if (existingProduct != null) {
//         return Response.json({
//           "message": "Produk dengan nama ini sudah ada",
//         }, 409);
//       }

//       productData['created_at'] = DateTime.now().toIso8601String();

//       await Product().query().create(productData);

//       return Response.json({
//         "message": "Product berhasil ditambahkan",
//         "data": productData,
//       }, 201);
//     } catch (e) {
//       return Response.json(
//         {
//           "message": "Error terjadi pada server, silahkan coba lagi nanti",
//         },
//         500,
//       );
//     }
//   }

//   Future<Response> show() async {
//     try {
//       final listProduct = await Product().query().get();
//       return Response.json({
//         "message": "Daftar produk",
//         "data": listProduct,
//       }, 200);
//     } catch (e) {
//       return Response.json({
//         'message': "Terjadi kesalahan saat mengambil data produk",
//         'error': e.toString(),
//       }, 500); // HTTP status code 500 Internal Server Error
//     }
//   }

//   Future<Response> edit(int id) async {
//     return Response.json({});
//   }

//   Future<Response> update(Request request, int id) async {
//     try {
//       // Validasi input dari pengguna
//       request.validate({
//         'name': 'required|string|max_length:100',
//         'description': 'required|string|max_length:255',
//         'price': 'required|numeric|min:0',
//       }, {
//         'name.required': 'Nama produk tidak boleh kosong',
//         'name.string': 'Nama produk harus berupa text',
//         'name.max.length': 'Nama produk maksimal 100 karakter',
//         'description.required': 'Deskripsi produk tidak boleh kosong',
//         'description.string': 'Deskripsi produk harus berupa text',
//         'description.max_length': 'Nama produk maksimal 255 karakter',
//         'price.required': 'Harga produk tidak boleh kosong',
//         'price.numeric': 'Nama produk harus berupa angka',
//         'price.min': 'Harga produk tidak boleh kurang dari 0'
//       });

//       // Ambil input data produk yang akan diupdate
//       final productData = request.input();
//       productData['updated_at'] = DateTime.now().toIso8601String();

//       //cari produk berdasarkan id
//       final product = await Product().query().where('id', '=', id).first();

//       if (product == null) {
//         return Response.json({
//           "message": "Produk dengan ID $id tidak ditemukan",
//         }, 404); // HTTP status code 404 not found
//       }

//       // Update data produk
//       await Product().query().where('id', '=', id).update(productData);

//       //mengembalikan respon sukses dengan status 200 OK
//       return Response.json({
//         "message": "Produk berhasil diupdate",
//         "data": productData,
//       }, 200);
//     } catch (e) {
//       //menangani kesalahan validasi
//       if (e is Exception) {
//         return Response.json({
//           'error': e.toString(),
//         }, 400);
//       } else {
//         //menangani kesalahan server
//         return Response.json({
//           'message': "Terjadi kesalahan pada server, silahkan coba lagi nanti",
//         }, 500); // HTTP status code 500 Internal Server Error
//       }
//     }
//   }

//   Future<Response> destroy(int id) async {
//     try {
//       // Cari produk berdasarkan ID
//       final product = await Product().query().where('id', '=', id).first();

//       if (product == null) {
//         return Response.json({
//           "message": "Produk dengan ID $id tidak ditemukan",
//         }, 404); // HTTP status code 404 not found
//       }

//       // Hapus product
//       await Product().query().where('id', '=', id).delete();

//       return Response.json({
//         'message': "Product berhasil dihapus",
//       }, 200);
//     } catch (e) {
//       return Response.json({
//         'message': "Terjadi kesalahan saat menghapus data produk",
//         'error': e.toString(),
//       }, 500); // HTTP status code 500 Internal Server Error
//     }
//   }
// }

// final ProductController productController = ProductController();
