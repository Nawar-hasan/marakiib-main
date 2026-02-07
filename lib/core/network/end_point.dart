  class EndPoints {
    static const String baseUrl = 'https://api.marakiib.com/api/';
    static const String loginEndPoint = 'login';
    static const String registerEndPoint = 'register';
    static const String verifyOtpEndPoint = 'verify-otp';
    static const String popularCars = 'public/cars/popular';
    static const String recommendedCars = 'customer/suggested-cars';
    static const String carDetails = 'public/cars';
    static const String categories = 'public/categories';
    static const String addCar = 'cars';
    static const String myCar = 'my-cars';
    static const String mypFeatures = 'public/public/features';
    static const String forgetPassword = 'forgot-password';
    static const String restPassword = 'reset-password';
    static const String getUser = 'user';
    static const String updateUser = 'user/update';
    static const String myBooking = 'bookings';
    static const String walletBalance = 'wallet/balance';
    static const String sendFcmToken = 'device/token';
    static const String unreadCount = 'notifications/unread-count';


    static const String search = 'customer/search';
    static const String viewConversations = 'conversations';
    static const String getChat = 'conversations/';
    static const String addBooking = 'bookings';
    static const String userBooking = 'bookings';
    static const String startnewchat = 'chat/start';
    static const String getfavourites = 'favourites';
    static const String getFeatures = 'public/features';
    static const String carsAvailable = 'public/cars/available';
    static const String resendotp = 'resend-otp';
    static const String pagesPrivacy = 'pages/privacy';
    static const String pageSupport = 'pages/support';
    static const String pagesAboutus = 'pages/about-us';
    static const String commissions = 'public/commissions-plans';
    static const String financings = 'financings';
    static const String financingPlans = 'public/financing-plans';
    static const String financedCars = 'public/financed-cars';
    static const String payment = 'payment/mobile/create';
    static const String getnotifications = 'notifications/notifications-without-progrss';
    static const String withdrawalMethods = 'withdrawal-methods';
    static const String withdraw = 'withdraw';
    static const String wallethistory = 'wallet-history';
    static const String subscriptionsStatus = 'subscriptions/status';
        static const String subscriptionsplans = 'subscriptions/plans';
    static const String subscriptionsPurchase = 'subscriptions/purchase';
    static const String banners = 'public/banners';



    static String favouriteToggle(int carId) => 'customer/favourite/$carId/favourite-toggle';
    static String isfavorite(int carId) => 'customer/favourite/$carId/isfavorite';







    static const String favourites = 'favourites';
  }
