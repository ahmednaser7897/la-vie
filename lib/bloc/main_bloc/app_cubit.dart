import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_vie_app/model/forum.dart';
import 'package:le_vie_app/model/user.dart';
import 'package:le_vie_app/view/common_view/widgets.dart';
import 'package:le_vie_app/view/moble/screens/home/home.dart';

import 'package:le_vie_app/view/moble/screens/profile/profile.dart';
import 'package:le_vie_app/view/moble/screens/qr/qr.dart';

import '../../model/blogs.dart';
import '../../model/plantsModel.dart';
import '../../shared/database/database.dart';
import '../../shared/network/dio_helper.dart';
import '../../shared/services/signin_service.dart';

import '../../view/moble/screens/blogs/blogs.dart';
import '../../view/moble/screens/post/discussion.dart';

import '../../view/moble/screens/profile/profile_widgets.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitLogin());
  static AppCubit get(context) => BlocProvider.of(context);
  DataBase db = DataBase();

  List<Widget> screens = [
    const BlogsScreen(),
    const QRViewPlants(),
    const Home(),
    const DiscussionForums(),
    const ProfileScreen()
  ];

  int indix = 2;
  Future<void> changBottomBarIndix(value, context) async {
    indix = value;
    print("indix is $indix");
    if (indix == 0) {
      await getBlpgs(context);
    }
    if (indix == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const QRViewPlants()));
    }
    if (indix == 2) {
      await getProducts(ctx: context);
    }
    if (indix == 3) {
      await getUser(ctx: context);
      await getForums(context);
      await getMyForums(context);
    }
    if (indix == 4) {
      await getUser(ctx: context);
    }
    emit(ChangBottomBarIndix());
  }

//----------------------user fun----------------
  User? user;
  Future<void> getUser({ctx}) async {
    emit(LodingGetUserData());
    print("accessToken is " + accessToken);
    await DioHelper.getData(
      url: "api/v1/user/me",
      token: "Bearer $accessToken",
    ).then((value) {
      user = User.fromJson(value.data);
      print("data is " + value.data.toString());
      emit(ScGetUserData());
    }).catchError((onError) {
      if (ctx != null) {
        if (onError is DioError) {
          print("onError.message " + onError.message);
          if (onError.response != null) {
            print(onError.response!.data);
            if (onError.response!.data['message'] == 'Unauthorized') {
              showDialog(
                  context: ctx,
                  builder: (context) {
                    return logOut(context, text: "you must logout");
                  });
            }
          } else {
            buildToast(ctx, "Network Erorr");
          }
        }
      }

      print('error from ErrorGetUserData function ${onError.toString()}');
      emit(ErrorGetUserData());
    });
  }

  Future<void> updateUser(ctx,
      {String? email, String? fName, String? lName}) async {
    emit(LodingUpdateUserData());
    await DioHelper.patchData(
      data: {
        "firstName": fName ?? user!.data!.firstName,
        "lastName": lName ?? user!.data!.lastName,
        "email": email ?? user!.data!.email,
        "address": "asdfghhgfd"
      },
      url: "api/v1/user/me",
      token: "Bearer $accessToken",
    ).then((value) {
      print("user update data is " + value.data.toString());
      emit(ScUpdateUserData());
    }).catchError((onError) {
      if (onError is DioError) {
        if (onError.message == "Http status error [400]") {
          buildToast(ctx, "not valid data");
        } else {
          buildToast(ctx, "Network Erorr");
        }
      }
      print('error from ErrorUpdateUserData function ${onError.toString()}');
      emit(ErrorUpdateUserData());
    });
  }

  User? userById;
  Future<void> getUserById(String id, ctx) async {
    emit(LodingGetUserData());
    //print("accessToken is "+accessToken);
    await DioHelper.getData(
      url: "api/v1/user/reciepts/:recieptId",
      querys: {'recieptId': id},
      token: "Bearer $accessToken",
    ).then((value) {
      userById = User.fromJson(value.data);
      print("data is " + value.data.toString());
      emit(ScGetUserData());
    }).catchError((onError) {
      if (onError is DioError) {
        if (onError.message == "Http status error [404]") {
          buildToast(ctx, "User not found");
        } else {
          buildToast(ctx, "Network Erorr");
        }
      }
      print('error from ErrorGetUserData function ${onError.toString()}');
      emit(ErrorGetUserData());
    });
  }
//----------------------------------------------------------------

//----------------------blogs fun----------------
  Blogs? blogs;
  Future<void> getBlpgs(ctx) async {
    emit(LodingGetBlpgsData());
    print("accessToken is " + accessToken);
    await DioHelper.getData(
      url: "api/v1/products/blogs",
      token: "Bearer $accessToken",
    ).then((value) {
      //googelLogein=Autogenerated.fromJson(value.data);
      blogs = Blogs.fromJson(value.data);
      print("data is " + value.data.toString());
      emit(ScGetBlpgsData());
    }).catchError((onError) {
      if (onError is DioError) {
        buildToast(ctx, "Network Erorr, can not get Blogs");
      }
      print('error from ErrorGetBlpgsData function ${onError.toString()}');
      emit(ErrorGetBlpgsData());
    });
  }
//--------------------------------------------------------------------

//----------------------products fun----------------
  Products? products;
  List<Product> plants = [];
  List<Product> seeds = [];
  List<Product> tools = [];
  Future<void> getProducts({ctx}) async {
    emit(LodingGetProductsData());
    print("accessToken is " + accessToken);
    await DioHelper.getData(
      url: "api/v1/products",
      token: "Bearer $accessToken",
    ).then((value) async {
      products = Products.fromJson(value.data);
      for (var item in products!.data!) {
        //print(item.imageurl);
        if (item.plant != null) {
          if (!plants.contains(item)) {
            plants.add(item);
          }
        } else if (item.seed != null) {
          if (!seeds.contains(item)) {
            seeds.add(item);
          }
        } else {
          if (!tools.contains(item)) {
            tools.add(item);
          }
        }
      }
      print("products data is " + value.data.toString());
      await getfavoriteProducts();
      emit(ScGetProductsData());
    }).catchError((onError) {
      if (ctx != null) {
        if (onError is DioError) {
          buildToast(ctx, "Network Erorr, can not get products");
        }
      }

      print('error from ErrorGetProductsData function ${onError.toString()}');
      emit(ErrorGetProductsData());
    });
  }

  Product? productId;
  Future<void> getProductById(String id, ctx) async {
    emit(LodingGetProductByIdData());
    await DioHelper.getData(
      url: "api/v1/products/$id",
      token: "Bearer $accessToken",
    ).then((value) async {
      productId = Product.fromJson(value.data['data']);
      print("products id data is " + value.data.toString());
      await getfavoriteProducts();
      emit(ScGetProductByIdData());
    }).catchError((onError) {
      if (onError is DioError) {
        if (onError.message == "Http status error [404]") {
          buildToast(ctx, "Plant not found");
        } else {
          buildToast(ctx, "Network Erorr");
        }
      } else {
        buildToast(ctx, "try agen");
      }
      print(
          'error from ErrorGetProductsData by $id function ${onError.toString()}');
      emit(ErrorGetProductByIdData());
    });
  }

  void endQrRead() {
    productId = null;
    emit(EndQrRead());
  }

  List<Product> myCarts = [];
  Future<void> inMyCart(Product product, ctx) async {
    if (myCarts.contains(product)) {
      await product.deletfromFav();
      myCarts.remove(product);
      buildToast(ctx, "${product.name} removed from  your cart");
    } else {
      await product.addToFav();
      myCarts.add(product);
      buildToast(ctx, "${product.name} added to  your cart");
    }
    emit(ScMyCart());
  }

  List favoriteProducts = [];
  Future<void> getfavoriteProducts() async {
    emit(LoadingGetFavCart());
    favoriteProducts = [];
    myCarts = [];
    try {
      List fav = await db.getFavProduct();
      print("fav is " + fav.toString());
      if (fav.isNotEmpty) {
        for (var item in fav) {
          print(item["id"]);
          Product p =
              products!.data!.firstWhere((element) => element.id == item["id"]);
          p.indx = item["i"];
          myCarts.add(p);
        }
      }
      emit(ScGetFavCart());
    } catch (e) {
      print("error ErrorGetFavCart: $e");
      emit(ErrorGetFavCart());
    }
  }

  void removeALLMyCard() {
    for (var element in myCarts) {
      element.deletfromFav();
    }
    myCarts = [];
    emit(RemoveALLMyCard());
  }

  List<Product> foundproducts = [];
  void searchProducts(String value) {
    emit(LoadingSearchProducts());
    foundproducts = [];
    foundproducts.addAll(products!.data!.where((element) {
      if (element.name!.contains(value)) {
        return true;
      }
      return false;
    }));

    emit(ScSearchProducts());
  }

  removeSearch() {
    foundproducts = [];
    emit(ScSearchProducts());
  }
//---------------------------------------------------------------

//----------------------Forums fun----------------
  Forums? forums;
  Future<void> getForums(ctx) async {
    emit(LodingGetForumsData());
    //print("accessToken is "+accessToken);
    await DioHelper.getData(
      url: "api/v1/forums",
      token: "Bearer $accessToken",
    ).then((value) {
      forums = Forums.fromJson(value.data);
      print(forums!.forum);
      /*for (var item in forums!.forum!) {
        for (var item2 in item.forumLikes!) {
          if(item2.userId==user!.data!.userId!){
            item.fav=true;
          }
        }
      }*/
      print("forums forums data is " + value.data.toString());
      emit(ScGetForumsData());
    }).catchError((onError) {
      if (onError is DioError) {
        buildToast(ctx, "Network Erorr, can not get forums");
      }
      print('error from ErrorGetForumsData function ${onError.toString()}');
      emit(ErrorGetForumsData());
    });
  }

  Forums? searchForums;
  Future<void> getsearchForums({String search = ''}) async {
    emit(LodingGetForumsData());
    //print("accessToken is "+accessToken);
    await DioHelper.getData(
        url: "api/v1/forums",
        token: "Bearer $accessToken",
        querys: {"search": search}).then((value) {
      searchForums = Forums.fromJson(value.data);
      for (var item in searchForums!.forum!) {
        for (var item2 in item.forumLikes!) {
          if (item2.userId == user!.data!.userId!) {
            item.fav = true;
          }
        }
      }
      print("forums search data is " + value.data.toString());
      emit(ScGetForumsData());
    }).catchError((onError) {
      print('error from ErrorGetForumsData function ${onError.toString()}');
      emit(ErrorGetForumsData());
    });
  }

  void searchFourmByApi(String value) {
    emit(LoadingSearchFourm());
    getsearchForums(search: value);
    emit(ScSearchFourm());
  }

  List<Forum> foundFourms = [];
  void searchFourms(String value) {
    emit(LoadingSearchFourm());
    foundFourms = [];
    if (value != "") {
      foundFourms.addAll(forums!.forum!.where((element) {
        if (element.title!.contains(value) ||
            element.description!.contains(value)) {
          return true;
        }
        return false;
      }));
    }
    emit(ScSearchFourm());
  }

  removeSearchFourms() {
    foundFourms = [];
    emit(ScSearchFourm());
  }

  Forum? forumById;
  Future<void> getfouemById(String id, ctx) async {
    emit(LodingGetForumsData());
    await DioHelper.getData(
      url: "api/v1/forums/:forumId",
      querys: {'recieptId': id},
      token: "Bearer $accessToken",
    ).then((value) {
      print("data is " + value.data.toString());
      emit(ScGetForumsData());
    }).catchError((onError) {
      if (onError is DioError) {
        if (onError.message == "Http status error [404]") {
          buildToast(ctx, "Forum not found");
        } else {
          buildToast(ctx, "Network Erorr");
        }
      }
      print('error from ErrorGetUserData function ${onError.toString()}');
      emit(ErrorGetForumsData());
    });
  }

  Future<void> setLike(Forum forum) async {
    if (forum.fav == false) {
      forum.fav = true;
      forum.forumLikes!
          .add(ForumLikes(forumId: forum.forumId, userId: user!.data!.userId));
      await sendLike(forum.forumId!);
    } else {
      forum.fav = false;
      forum.forumLikes!.removeAt(0);
    }

    emit(ScSetLike());
  }

  Future<void> sendLike(String forumId) async {
    emit(LoadingSendLike());
    print(forumId);
    await DioHelper.postData(
        url: "api/v1/forums/$forumId/like",
        token: "Bearer $accessToken",
        data: {}).then((value) async {
      print("ScSendLike data is " + value.data.toString());
      emit(ScSendLike());
    }).catchError((onError) {
      if (onError is DioErrorType) {
        print("onError " + onError.name);
      }
      print('error from ErrorSendLike function ${onError.toString()}');
      emit(ErrorSendLike());
    });
  }

  Future<void> setcomment(Forum forum, String comment) async {
    ForumComments forumComments = ForumComments(
        comment: comment,
        forumId: forum.forumId!,
        userId: user!.data!.userId!,
        forumCommentId: "");
    forum.forumComments!.add(forumComments);
    await sendComment(forum.forumId!, comment);
    emit(ScSetComment());
  }

  Future<void> sendComment(String forumId, String comment) async {
    emit(LoadingSendComment());
    await DioHelper.postData(
        url: "api/v1/forums/$forumId/comment",
        query: {'forumId': forumId},
        token: "Bearer $accessToken",
        data: {"comment": comment}).then((value) async {
      print("ScSendcomment data is " + value.data.toString());
      emit(ScSendComment());
    }).catchError((onError) {
      if (onError is DioErrorType) {
        print("onError " + onError.name);
      }
      print('error from ErrorSendComment function ${onError.toString()}');
      emit(ErrorSendComment());
    });
  }

  void deleteComment(ForumComments comment, Forum forum) {
    forum.forumComments!.remove(comment);
    emit(ScDeleteComment());
  }

  Forums? myForums;
  Future<void> getMyForums(ctx) async {
    emit(LodingGetForumsData());
    print("accessToken is " + accessToken);
    await DioHelper.getData(
      url: "api/v1/forums/me",
      token: "Bearer $accessToken",
    ).then((value) {
      myForums = Forums.fromJson(value.data);
      print("myForums!.message! " + myForums!.message!);
      //print("myForumsdata is " + value.data.toString());
      emit(ScGetForumsData());
    }).catchError((onError) {
      if (onError is DioError) {
        buildToast(ctx, "Network Erorr, can not get my forums");
      }
      print('error from ErrorGetForumsData function ${onError.toString()}');
      emit(ErrorGetForumsData());
    });
  }

  Future<void> addPost(
      String title, String description, String imageBase64, ctx) async {
    emit(LodingAddPostData());
    //print("accessToken is "+accessToken);
    await DioHelper.postData(
      url: "api/v1/forums",
      data: {
        "title": title,
        "description": description,
        "imageBase64": imageBase64
      },
      token: "Bearer $accessToken",
    ).then((value) async {
      print("PostData " + value.data.toString());
      buildToast(ctx, value.data["message"]);
      emit(ScAddPostData());
    }).catchError((onError) {
      print('error from ErrorAddPostData function ${onError.toString()}');
      emit(ErrorAddPostData());
    });
  }
//---------------------------------------------------------------

  Future<void> logeout() async {
    emit(LodingLogeOut());
    SigninService googleService = SigninService();
    try {
      await logeOut();
      await googleService.googelSignOut();
      //await googleService.facebooklSignOut();
      emit(ScLogeOut());
    } catch (e) {
      print("erorr in ErrorLogeOut is " + e.toString());
      emit(ErrorLogeOut(e.toString()));
    }
  }
}
