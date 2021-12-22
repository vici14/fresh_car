import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_car/model/cart_model.dart';
import 'package:fresh_car/model/ordered_product_model.dart';
import 'package:fresh_car/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_car/model/user_model.dart';

class ServiceManager {
  static final ServiceManager _instance = ServiceManager._internal();
  static final fireStore = FirebaseFirestore.instance;
  final CollectionReference productsCollection =
      fireStore.collection('products');
  static final CollectionReference usersCollection =
      fireStore.collection('users');
  final userRef = usersCollection.withConverter<UserModel>(
    fromFirestore: (snapshot, _) =>
        UserModel.fromQuerySnapshot(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  factory ServiceManager() {
    //BEservice
    return _instance;
  }

  Future<DocumentReference<CartModel>> getUserCurrentCart(String uid) async {
    var _user = await usersCollection.where('uid', isEqualTo: uid).get();
    var _cart = await _user.docs.first.reference
        .collection('cart')
        .withConverter<CartModel>(
            fromFirestore: (snapshot, _) =>
                CartModel.fromQuerySnapshot(snapshot.data()!),
            toFirestore: (cart, _) => cart.toJson())
        .get();
    return _cart.docs.first.reference;
  }

  Future<DocumentReference<UserModel>> getCurrentUserDocument(
      String uid) async {
    var _user = await usersCollection
        .where('uid', isEqualTo: uid)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              UserModel.fromQuerySnapshot(snapshot.data()!),
          toFirestore: (UserModel user, _) => user.toJson(),
        )
        .get();
    return _user.docs.first.reference;
  }

  Future<DocumentReference<ProductModel>> getCurrentProductDocument(
      String id) async {
    var _product = await productsCollection
        .where('id', isEqualTo: id)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              ProductModel.fromQuerySnapshot(snapshot.data()!),
          toFirestore: (ProductModel prduct, _) => prduct.toJson(),
        )
        .get();
    return _product.docs.first.reference;
  }

  ServiceManager._internal() {
    //Singleton
    //create Firebase
    init();
  }

  void init() async {
    //create DB or sthg
  }

//====================PRODUCTS=======================
  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> list = [];
    var _products = await productsCollection.get();
    try {
      _products.docs.forEach((element) {
        var product = ProductModel.fromQuerySnapshot(
            element.data() as Map<String, dynamic>);
        list.add(product);
      });
      print('product ne :${_products}');
      return list;
    } catch (e) {
      print(e);
    }
    return [];
  }

//====================USER=======================

  Future<UserModel?> getCurrentUser() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var _currentUser = await getCurrentUserDocument(currentUser.uid);
      return _currentUser.get().then((value) => value.data());
    }
    return null;
  }

  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('signUpCredential${userCredential.credential?.token}');
      var isCreated = createUser(uid: userCredential.user!.uid, email: email);
      if (isCreated) {
        createCollectionCart(userCredential.user!.uid);
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  bool createUser({required String uid, required String email}) {
    userRef.add(UserModel.initial(uid: uid, email: email));
    return true;
  }

  Future<bool> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('signInCredential${userCredential.additionalUserInfo}');
      if (userCredential != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return false;
  }

  void likeProduct(
      {required String uid, required ProductModel productModel}) async {
    var _currentUser = await getCurrentUserDocument(uid);
    _currentUser.update({
      'favoriteProducts': FieldValue.arrayUnion([productModel.toJson()])
    }).then((value) {
      updateProductLiked(
          productId: productModel.id ?? '', status: productModel.isLiked);
      print('add to favorite success');
    }).catchError((onError) => print('failed add to favorite'));
  }

  void updateProductLiked(
      {required String productId, required bool status}) async {
    var _currentProduct = await getCurrentProductDocument(productId);
    _currentProduct
        .update({'isLiked': status})
        .then((value) => 'Update '
            'product  collection success')
        .catchError((onError) => print('failed '
            'to update collection'));
  }

  void unlikeProduct(
      {required String uid, required ProductModel productModel}) async {
    var _currentUser = await getCurrentUserDocument(uid);
    _currentUser.update({
      'favoriteProducts': FieldValue.arrayRemove([productModel.toJson()])
    }).then((value) {
      updateProductLiked(
          productId: productModel.id ?? '', status: productModel.isLiked);
      print('remove from favorite success');
    }).catchError((onError) => print('failed remove'));
  }

  Future<bool> updateProfile(
      {required String name,
      required String phone,
      required String address,
      required String uid}) async {
    try {
      var _currentUser = await getCurrentUserDocument(uid);
      _currentUser
          .update({'name': name, 'phone': phone, 'address': address})
          .then((value) => true)
          .onError((error, stackTrace) => false);
    } catch (e) {
      print('updateProfile:${e.toString()}');
    }
    return false;
  }

  void createCollectionCart(String uid) async {
    CartModel cartModel = CartModel.initial();
    var _currentUser = await getCurrentUserDocument(uid);
    _currentUser.collection('cart').add(cartModel.toJson());
  }

  void updateHistory(
      {required CartModel cartModel, required String uid}) async {
    var _currentUser = await getCurrentUserDocument(uid);
    _currentUser
        .update({
          'orderHistory': FieldValue.arrayUnion([cartModel.toJson()])
        })
        .then((value) => print('User Updated list'))
        .catchError((onError) => print('FAILED'));
  }

//====================CART=======================
  void createCartInRegisteredUser() {}

  void addToCart(
      {required ProductModel productModel,
      required int quantity,
      required String uid}) async {
    var orderItem = OrderedProductModel.fromProductModel(
        product: productModel, quantity: quantity);
    var _cart = await getUserCurrentCart(uid);
    _cart.update({
      'orderedItems': FieldValue.arrayUnion([orderItem.toJson()])
    });
    print(_cart);
  }

  Future<CartModel?> getCart(String uid) async {
    var _cart = await getUserCurrentCart(uid)
        .then((value) => value.get().then((vak) => vak.data()));
    return _cart;
  }

  Future<bool> checkOutCart({
    required CartModel cartModel,
    required String uid,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
  }) async {
    try {
      var _cart = await getUserCurrentCart(uid);
      await _cart
          .update(CartModel.initial().toJson())
          .onError((error, stackTrace) => false);
      await addToHistory(
              uid: uid,
              cartModel: cartModel,
              customerAddress: customerAddress,
              customerPhone: customerPhone,
              customerName: customerName)
          .onError((error, stackTrace) => false);
      return true;
    } catch (e) {
      print('checkOutCart error :${e.toString()}');
    }
    return false;
  }

  Future<void> addToHistory({
    required CartModel cartModel,
    required String uid,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
  }) async {
    var _currentUser = await getCurrentUserDocument(uid);
    _currentUser.update({
      'orderHistory': FieldValue.arrayUnion([
        cartModel
            .withShippingInformation(
                customerName: customerName,
                customerPhone: customerPhone,
                customerAddress: customerAddress)
            .toJson()
      ])
    });
  }
}
