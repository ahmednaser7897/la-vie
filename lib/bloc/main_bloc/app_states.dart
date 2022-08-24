

abstract class AppStates {}

class InitLogin extends AppStates {}

class LoadingAppState extends AppStates {}

class ScAppState extends AppStates {}

class ErrorAppState extends AppStates {}

class Mood extends AppStates {}

class LodingLogeOut extends AppStates{}
 class ScLogeOut extends AppStates{

 }
 class ErrorLogeOut extends AppStates{
  final String error;
  ErrorLogeOut(this.error);
 }
class ChangBottomBarIndix extends AppStates{}

 class LodingGetUserData extends AppStates{}
 class ScGetUserData extends AppStates{}
 class ErrorGetUserData extends AppStates{}

 class LodingUpdateUserData extends AppStates{}
 class ScUpdateUserData extends AppStates{}
 class ErrorUpdateUserData extends AppStates{}


 class LodingGetBlpgsData extends AppStates{}
 class ScGetBlpgsData extends AppStates{}
 class ErrorGetBlpgsData extends AppStates{}

 class LodingGetProductsData extends AppStates{}
 class ScGetProductsData extends AppStates{}
 class ErrorGetProductsData extends AppStates{}

 class LodingGetProductByIdData extends AppStates{}
 class ScGetProductByIdData extends AppStates{}
 class ErrorGetProductByIdData extends AppStates{}

 class LoadingSearchProducts extends AppStates{}
 class ScSearchProducts extends AppStates{}

  class LoadingSearchFourms extends AppStates{}
 class ScSearchFourms extends AppStates{}

 class ScDeleteComment extends AppStates{}
 class LoadingSearchFourm extends AppStates{}
 class ScSearchFourm extends AppStates{}

 class LodingGetForumsData extends AppStates{}
 class ScGetForumsData extends AppStates{}
 class ErrorGetForumsData extends AppStates{}
 
 class ScSetLike extends AppStates{}
 class ScSetComment extends AppStates{}
 class ScMyCart extends AppStates{}

 class LodingAddPostData extends AppStates{}
 class ScAddPostData extends AppStates{}
 class ErrorAddPostData extends AppStates{}


class LoadingGetFavCart extends AppStates {}
class ScGetFavCart extends AppStates {}
class ErrorGetFavCart extends AppStates {}

class ChangeCart extends AppStates {}
class RemoveALLMyCard extends AppStates {}


class LoadingSendLike extends AppStates {}
class ScSendLike extends AppStates {}
class ErrorSendLike extends AppStates {}

class LoadingSendComment extends AppStates {}
class ScSendComment extends AppStates {}
class ErrorSendComment extends AppStates {}

class EndQrRead extends AppStates {}




