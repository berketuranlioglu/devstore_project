import 'package:flutter/material.dart';
import 'package:devstore_project/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

final productText = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.bold,
  color: AppColors.textColor,
);

final categoriesText = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.normal, //favorites, campaigns, recommended banner
  color: AppColors.primaryColor,
);

final fav_camp_recomBanner = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //favorites, campaigns, recommended banner
  color: AppColors.textColor,
);

final fav_camp_recomEmpty = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.bold, //favorites, campaigns, recommended if empty
  color: AppColors.textColor,
);

final feed_searchBar = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //search bar text
  color: AppColors.feedPageSearchBar,
);

final feed_devstoreBold = GoogleFonts.openSans(
  fontSize: 28,
  fontWeight: FontWeight.bold, //feed page, dev store bold version
  color: AppColors.primaryColor,
);

final feed_devstore = GoogleFonts.openSans(
  fontSize: 28,
  fontWeight: FontWeight.normal, //feed page, dev store normal
  color: AppColors.primaryColor,
);

final loginPage_WelcomeRegular = GoogleFonts.openSans(
  fontSize: 28,
  fontWeight: FontWeight.normal, //login page welcome text
);

final loginPage_WelcomeBold = GoogleFonts.openSans(
  fontSize: 28,
  fontWeight: FontWeight.bold, //login page welcome text
);

final loginPage_ExistingAcc = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.normal, //login page, for the existing account text
  color: AppColors.loginSubTextColor,
);

final loginPage_ForgotPass = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.bold, //login page, 'forgot password?' text
  color: AppColors.textColor,
);

final loginPage_OtherConnections = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.normal, //login page, 'or connect using text'
  color: AppColors.loginSubTextColor,
);

final loginPage_SignUpRegular = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight
      .normal, //login page dont have acc option Fontweight is mixed, use it for regular
  color: AppColors.textColor,
);

final loginPage_SignUpBold = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight
      .bold, //login page dont have acc option fontweight is mixed, use it for bold
  color: AppColors.primaryColor,
);

final signupPage_InfoSentence1 = GoogleFonts.openSans(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
  color: AppColors.appBarColor, //signup page text 'lets get started'
);

final signupPage_InfoSentence2 = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight
      .normal, //signup page text 'create an account to get all features'
);

final signupPage_ButtonTxts = GoogleFonts.openSans(
  color: AppColors.secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 13.0, //signup page, texts inside the user info lines
);

final signupPage_SignUpButton = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.bold, //signup button text
);

final signupPage_LogInRegular = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight.normal, //fontweight is mixed, use it for regular
);

final signupPage_LogInBold = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight.bold, //fontweight is mixed, use bold it for bold
);

final homePage_SearchBar = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //homepage search text inside search bar
);

final searchPage_EmptySearchBold = GoogleFonts.openSans(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final searchPage_EmptySearchNormal = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.normal,
);

final welcomePage_LogIn = GoogleFonts.openSans(
  textStyle: TextStyle(color: AppColors.primaryColor),
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

final welcomePage_SignUp = GoogleFonts.openSans(
  textStyle: TextStyle(color: AppColors.secondaryColor),
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

/*final homePage_Ads = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.normal, //homepage ads, commented out because ads will be inserted there
);*/

final homePage_VisitedandRecommended = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //homepage visited and recommended texts
);

final TabBar = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.normal, //tab bar texts
);

final PreviousPage = GoogleFonts.openSans(
  fontSize: 20,
  fontWeight: FontWeight
      .w600, //texts for the previous page such as; discounts & offer, categories, my cart...
);

final categoriesOption2_Categories = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.w600, //categories page-option 2 categories' text
);

final categoriesTitle = GoogleFonts.openSans(
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

/*final DiscountsOffers_DiscountBanner = GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.normal, //discounts and offer page banner, commented out because banners will be added
);*/

final ShoppingCartEmpty = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.normal, //information text empty shopping cart
);

final ShoppingCart_ItemName = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.w600, //item name in shopping cart
);

final ItemBrandandPrice = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight:
      FontWeight.normal, //item brand, price to be used in every necessary page
);

final ShoppingCart_PaymentRegular = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight
      .normal, //shopping cart checkout prices fontweight is mixed, use bold it for regular
);

final ShoppingCart_PaymentBold = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight
      .bold, //shopping cart checkout prices fontweight is mixed, use bold it for bold
);

final ShoppingCart_Checkout = GoogleFonts.openSans(
  fontSize: 13,
  fontWeight: FontWeight.w600, //checkout button text
);

final Settings_NameSurname = GoogleFonts.openSans(
  fontSize: 18,
  fontWeight: FontWeight.w600, //settings page name surname
);

final Settings_Username = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.w300, //settings page username
);

final Settings_Table = GoogleFonts.openSans(
  fontSize: 16,
  fontWeight: FontWeight.normal, //settings page username
);

final Product_Name = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //product name
);

final Product_BrandandDetails = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight
      .normal, //product; name, overview, details, comments bar and description
);

final Product_Comments = GoogleFonts.openSans(
  fontSize: 9,
  fontWeight: FontWeight.normal, //product comments
);

final Product_PriceandDiscount = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //product price and discount amounts
);

final Product_AddtoCart = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //product add to cart
);

final SellerProfile_Name = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //seller profile name
);

final SellerProfile_Stars = GoogleFonts.roboto(
  fontSize: 10,
  fontWeight: FontWeight.bold, //seller profile stars
);

final SellerProfile_HeaderSelling = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.bold, //seller profile selling
);

final SellerProfile_HeaderSold = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //seller profile sold
);

final SellerProfile_ItemRatingandDiscount = GoogleFonts.openSans(
  fontSize: 10,
  fontWeight: FontWeight.w600, //seller profile rating and discount numbers
);

final SellerProfile_ItemPrice = GoogleFonts.openSans(
  fontSize: 20,
  fontWeight: FontWeight.w600, //seller profile on sale item price
);

final AddtoCart_Buttons = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight: FontWeight.w600, //add to cart buttons
);

final SellerProfile2_NotAvailable = GoogleFonts.openSans(
  fontSize: 12,
  fontWeight:
      FontWeight.w600, //seller profile2 page not available to adding cart
);

final FavoritesPage_ItemNames = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.w600, //fav page item names
);

final OrdersPage_Date = GoogleFonts.openSans(
  fontSize: 15,
  fontWeight: FontWeight.normal, //orders page order date
);

final OrdersPage_DeliveryInfo = GoogleFonts.openSans(
  fontSize: 14,
  fontWeight: FontWeight.w600, //orders delivery status texts
);

//onboarding pages props
final walkthroughHeading = GoogleFonts.openSans(
  //main heading title in the onboarding page
  color: AppColors.textColor.withOpacity(0.9),
  fontSize: 25,
);

final walkthroughNavButton = GoogleFonts.openSans(
  //main heading title in the onboarding page
  fontSize: 15,
  color: AppColors.secondaryColor,
);
