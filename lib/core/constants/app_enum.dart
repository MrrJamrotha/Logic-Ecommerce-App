enum LanguageType {
  en,
  km,
}

enum ThemeType {
  light,
  dark,
}

enum BubbleType { sendBubble, receiverBubble }

enum MessageStatus {
  success,
  error,
  warning,
}

enum OrderColorStatus {
  pending,
  confirm,
  delivery,
  delivered,
}

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
  location,
}

// Product','Category','Brand','Merchant','Promotion','Coupon
//display_type = 'NewProduct','Promotion','Coupon','NewCategory','NewBrand'
enum SlideShowType {
  category,
  product,
  brand,
  merchant,
  promotion,
  coupon,
}

enum DisplayType {
  newProduct,
  promotion,
  coupon,
  newCategory,
  newBrand,
}

enum ErrorType {
  notFound,
  empty,
  serverError,
}

enum OrderStatus {
  pending,
  processing,
  delivery,
  completed,
}

enum FetchingType {
  recommented,
  baseSeller,
  newArrival,
  wishlist,
  spacialOffers,
  relatedProducts,
}

enum ListProductType {
  category,
  brand,
}

enum StateType {
  created,
  updated,
}
