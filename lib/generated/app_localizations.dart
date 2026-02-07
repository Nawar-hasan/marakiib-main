import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the Terms & Conditions'**
  String get acceptTerms;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @additionalFees.
  ///
  /// In en, this message translates to:
  /// **'Additional fees'**
  String get additionalFees;

  /// No description provided for @additionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInfo;

  /// No description provided for @additionalInformation.
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionalInformation;

  /// No description provided for @addressError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get addressError;

  /// No description provided for @addressFetchError.
  ///
  /// In en, this message translates to:
  /// **'Error fetching address'**
  String get addressFetchError;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressHint;

  /// No description provided for @addressNotFound.
  ///
  /// In en, this message translates to:
  /// **'Address not found'**
  String get addressNotFound;

  /// No description provided for @adminNotes.
  ///
  /// In en, this message translates to:
  /// **'Admin Notes'**
  String get adminNotes;

  /// No description provided for @alerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get alerts;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @availabilityEndHint.
  ///
  /// In en, this message translates to:
  /// **'Availability End'**
  String get availabilityEndHint;

  /// No description provided for @availabilityPeriod.
  ///
  /// In en, this message translates to:
  /// **'Availability Period'**
  String get availabilityPeriod;

  /// No description provided for @availabilityStartHint.
  ///
  /// In en, this message translates to:
  /// **'Availability Start'**
  String get availabilityStartHint;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @availableFor.
  ///
  /// In en, this message translates to:
  /// **'Available for'**
  String get availableFor;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @basePrice.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get basePrice;

  /// No description provided for @basicCarInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Car Information'**
  String get basicCarInfo;

  /// No description provided for @basicCarInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Car Information'**
  String get basicCarInformation;

  /// No description provided for @bestPlatformCarRental.
  ///
  /// In en, this message translates to:
  /// **'The Best Platform for Car Rental'**
  String get bestPlatformCarRental;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @bookingAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Booking added successfully ✅'**
  String get bookingAddedSuccess;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking confirmed ✅'**
  String get bookingConfirmed;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @bookingError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String bookingError(Object error);

  /// No description provided for @bookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to perform action ❌'**
  String get bookingFailed;

  /// No description provided for @bookingRejected.
  ///
  /// In en, this message translates to:
  /// **'Booking rejected ❌'**
  String get bookingRejected;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @carAvailabilityStatus.
  ///
  /// In en, this message translates to:
  /// **'Car availability status'**
  String get carAvailabilityStatus;

  /// No description provided for @carCondition.
  ///
  /// In en, this message translates to:
  /// **'Car Condition'**
  String get carCondition;

  /// No description provided for @carConditionAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get carConditionAvailable;

  /// No description provided for @carConditionReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get carConditionReserved;

  /// No description provided for @carDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Car deleted successfully'**
  String get carDeletedSuccessfully;

  /// Title for car details screen
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get carDetails;

  /// No description provided for @carFeatures.
  ///
  /// In en, this message translates to:
  /// **'Car Features'**
  String get carFeatures;

  /// Label for car information section
  ///
  /// In en, this message translates to:
  /// **'Car Information'**
  String get carInfo;

  /// No description provided for @carLicenseExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Car License Expiry Date'**
  String get carLicenseExpiryDate;

  /// No description provided for @carModelOrRegistration.
  ///
  /// In en, this message translates to:
  /// **'Car Model/Registration Number'**
  String get carModelOrRegistration;

  /// No description provided for @carModelRegistrationHint.
  ///
  /// In en, this message translates to:
  /// **'Car Model'**
  String get carModelRegistrationHint;

  /// No description provided for @carName.
  ///
  /// In en, this message translates to:
  /// **'Car Name'**
  String get carName;

  /// No description provided for @carNameHint.
  ///
  /// In en, this message translates to:
  /// **'Vehicle type/ class'**
  String get carNameHint;

  /// No description provided for @carNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your car ability, durability etc...'**
  String get carNotesHint;

  /// No description provided for @carRentalEaseInfo.
  ///
  /// In en, this message translates to:
  /// **'Ease of doing a car rental safely\nand reliably. Of course at a low price.'**
  String get carRentalEaseInfo;

  /// No description provided for @carStatusAndOptions.
  ///
  /// In en, this message translates to:
  /// **'Car Status & Options'**
  String get carStatusAndOptions;

  /// No description provided for @carStatusOptions.
  ///
  /// In en, this message translates to:
  /// **'Car Status & Options'**
  String get carStatusOptions;

  /// No description provided for @carUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Car updated successfully'**
  String get carUpdatedSuccessfully;

  /// No description provided for @carfeatures.
  ///
  /// In en, this message translates to:
  /// **'Car features'**
  String get carfeatures;

  /// No description provided for @cars.
  ///
  /// In en, this message translates to:
  /// **'cars'**
  String get cars;

  /// No description provided for @carsAllowed.
  ///
  /// In en, this message translates to:
  /// **'{maxCars} cars allowed'**
  String carsAllowed(Object maxCars);

  /// No description provided for @carsAvailable.
  ///
  /// In en, this message translates to:
  /// **'Cars Available'**
  String get carsAvailable;

  /// No description provided for @categorySelection.
  ///
  /// In en, this message translates to:
  /// **'Category Selection'**
  String get categorySelection;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'Change profile picture'**
  String get changeProfilePicture;

  /// No description provided for @chats.
  ///
  /// In en, this message translates to:
  /// **'Chats'**
  String get chats;

  /// No description provided for @checkEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your Email'**
  String get checkEmailTitle;

  /// No description provided for @chooseAccountType.
  ///
  /// In en, this message translates to:
  /// **'What type of account would you like to create?'**
  String get chooseAccountType;

  /// No description provided for @chooseMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Withdrawal Method'**
  String get chooseMethod;

  /// No description provided for @choosePlan.
  ///
  /// In en, this message translates to:
  /// **'Choose Plan'**
  String get choosePlan;

  /// No description provided for @chooseVerificationMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose Verification Method'**
  String get chooseVerificationMethod;

  /// No description provided for @commercial.
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get commercial;

  /// No description provided for @commercialRegError.
  ///
  /// In en, this message translates to:
  /// **'Please enter commercial registration number'**
  String get commercialRegError;

  /// No description provided for @commercialRegHint.
  ///
  /// In en, this message translates to:
  /// **'Commercial Registration Number'**
  String get commercialRegHint;

  /// No description provided for @commission.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commission;

  /// No description provided for @commissionAmount.
  ///
  /// In en, this message translates to:
  /// **'Commission'**
  String get commissionAmount;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @confirmFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to confirm ❌'**
  String get confirmFailed;

  /// No description provided for @confirmPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmPasswordError;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordHint;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get confirmPasswordRequired;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @congratulationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulationsTitle;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @createPayment.
  ///
  /// In en, this message translates to:
  /// **'Create Payment'**
  String get createPayment;

  /// No description provided for @createPaymentSession.
  ///
  /// In en, this message translates to:
  /// **'Create Payment Session'**
  String get createPaymentSession;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'JOD'**
  String get currency;

  /// No description provided for @currentCars.
  ///
  /// In en, this message translates to:
  /// **'Current Cars'**
  String get currentCars;

  /// No description provided for @dailyPrice.
  ///
  /// In en, this message translates to:
  /// **'Daily Price'**
  String get dailyPrice;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @days_count.
  ///
  /// In en, this message translates to:
  /// **'Number of Days'**
  String get days_count;

  /// No description provided for @deals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get deals;

  /// No description provided for @deleteCar.
  ///
  /// In en, this message translates to:
  /// **'Delete car'**
  String get deleteCar;

  /// No description provided for @deleteCarConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this car?'**
  String get deleteCarConfirmation;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionHint;

  /// No description provided for @descriptions.
  ///
  /// In en, this message translates to:
  /// **'Descriptions'**
  String get descriptions;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'{value} km'**
  String distanceKm(Object value);

  /// No description provided for @drivingLicenseError.
  ///
  /// In en, this message translates to:
  /// **'Please select your license image'**
  String get drivingLicenseError;

  /// No description provided for @drivingLicensePrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap to select Driving License Image'**
  String get drivingLicensePrompt;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @eWallet.
  ///
  /// In en, this message translates to:
  /// **'E-Wallet'**
  String get eWallet;

  /// No description provided for @easeOfCarRentalSafely.
  ///
  /// In en, this message translates to:
  /// **'Ease of doing a car rental safely\nand reliably. Of course at a low price.'**
  String get easeOfCarRentalSafely;

  /// No description provided for @editCar.
  ///
  /// In en, this message translates to:
  /// **'Edit Car'**
  String get editCar;

  /// No description provided for @editCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Car'**
  String get editCarTitle;

  /// No description provided for @editNow.
  ///
  /// In en, this message translates to:
  /// **'Edit Now'**
  String get editNow;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailErrorEmpty;

  /// No description provided for @emailErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get emailErrorInvalid;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @emailHint1.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone number'**
  String get emailHint1;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalid;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date:'**
  String get endDate;

  /// No description provided for @endDateCannotBeBeforeStartDate.
  ///
  /// In en, this message translates to:
  /// **'End date cannot be before start date'**
  String get endDateCannotBeBeforeStartDate;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @enterMaxPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter maximum price'**
  String get enterMaxPrice;

  /// No description provided for @enterMinPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter minimum price'**
  String get enterMinPrice;

  /// No description provided for @enterNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get enterNameValidation;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'❌ Enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enter_days_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter the required number of days'**
  String get enter_days_hint;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorCarFeatures.
  ///
  /// In en, this message translates to:
  /// **'Please select car features'**
  String get errorCarFeatures;

  /// No description provided for @errorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Not enough balance, please top up'**
  String get errorInsufficientBalance;

  /// No description provided for @errorMainImage.
  ///
  /// In en, this message translates to:
  /// **'Please select a valid main image'**
  String get errorMainImage;

  /// No description provided for @errorNoValidExtraImages.
  ///
  /// In en, this message translates to:
  /// **'No valid extra images selected'**
  String get errorNoValidExtraImages;

  /// No description provided for @errorPreparingFormData.
  ///
  /// In en, this message translates to:
  /// **'Error preparing form data: {error}'**
  String errorPreparingFormData(Object error);

  /// No description provided for @errorTermsNotAccepted.
  ///
  /// In en, this message translates to:
  /// **'You must accept terms to continue'**
  String get errorTermsNotAccepted;

  /// No description provided for @exitAppQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit the app?'**
  String get exitAppQuestion;

  /// No description provided for @extraImages.
  ///
  /// In en, this message translates to:
  /// **'Extra Images'**
  String get extraImages;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @favoriteCars.
  ///
  /// In en, this message translates to:
  /// **'Favorite Cars'**
  String get favoriteCars;

  /// No description provided for @favouritesError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String favouritesError(Object error);

  /// Label for car features section
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @fewDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String fewDays(String count);

  /// No description provided for @financedCar.
  ///
  /// In en, this message translates to:
  /// **'Financed Car'**
  String get financedCar;

  /// No description provided for @financedCars.
  ///
  /// In en, this message translates to:
  /// **'Financed Cars'**
  String get financedCars;

  /// No description provided for @financingDuration.
  ///
  /// In en, this message translates to:
  /// **'Financing Duration'**
  String get financingDuration;

  /// No description provided for @fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get fixed;

  /// No description provided for @forgetPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone number to reset the password'**
  String get forgetPasswordMessage;

  /// No description provided for @forgetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPasswordTitle;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forgotPassword;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @funder.
  ///
  /// In en, this message translates to:
  /// **'Funder'**
  String get funder;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// Label for image gallery
  ///
  /// In en, this message translates to:
  /// **'Image Gallery'**
  String get imageGallery;

  /// No description provided for @imageSelected.
  ///
  /// In en, this message translates to:
  /// **'Image Selected ✅'**
  String get imageSelected;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @insuranceTypeComprehensive.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive'**
  String get insuranceTypeComprehensive;

  /// No description provided for @insuranceTypeFullCoverage.
  ///
  /// In en, this message translates to:
  /// **'Full Coverage'**
  String get insuranceTypeFullCoverage;

  /// No description provided for @insuranceTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Insurance Type'**
  String get insuranceTypeHint;

  /// No description provided for @insuranceTypeThirdParty.
  ///
  /// In en, this message translates to:
  /// **'Third Party'**
  String get insuranceTypeThirdParty;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @invalidEmailValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmailValidation;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @invalidPhoneValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneValidation;

  /// No description provided for @invoiceDetails.
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetails;

  /// No description provided for @isCarActiveQ.
  ///
  /// In en, this message translates to:
  /// **'Is car active?'**
  String get isCarActiveQ;

  /// No description provided for @isCarActiveQuestion.
  ///
  /// In en, this message translates to:
  /// **'Is car available?'**
  String get isCarActiveQuestion;

  /// No description provided for @jodPerDays.
  ///
  /// In en, this message translates to:
  /// **'{price} JOD / {duration} days'**
  String jodPerDays(Object price, Object duration);

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @licensePhoto.
  ///
  /// In en, this message translates to:
  /// **'License Photo'**
  String get licensePhoto;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadingAddress.
  ///
  /// In en, this message translates to:
  /// **'Loading address...'**
  String get loadingAddress;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up now and enjoy rental ease like never before.'**
  String get loginSubtitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginTitle;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @logoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get logoutDialogContent;

  /// No description provided for @logoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Logout?'**
  String get logoutDialogTitle;

  /// No description provided for @longTermGuarantee.
  ///
  /// In en, this message translates to:
  /// **'Available for long-term guarantee (Dhaman)?'**
  String get longTermGuarantee;

  /// No description provided for @longTermGuaranteeQ.
  ///
  /// In en, this message translates to:
  /// **'Is the car available for long-term guarantee (Dhamaan)?'**
  String get longTermGuaranteeQ;

  /// No description provided for @longTermGuaranteeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Is the car available for long-term guarantee (Dhamaan)?'**
  String get longTermGuaranteeQuestion;

  /// No description provided for @mainImage.
  ///
  /// In en, this message translates to:
  /// **'Main Image'**
  String get mainImage;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @manyDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String manyDays(String count);

  /// No description provided for @maxCars.
  ///
  /// In en, this message translates to:
  /// **'Maximum Cars'**
  String get maxCars;

  /// No description provided for @maxPrice.
  ///
  /// In en, this message translates to:
  /// **'Max Price'**
  String get maxPrice;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Type your message here'**
  String get messageHint;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @messageValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your message'**
  String get messageValidation;

  /// No description provided for @minPrice.
  ///
  /// In en, this message translates to:
  /// **'Min Price'**
  String get minPrice;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @monthlySubscription.
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get monthlySubscription;

  /// No description provided for @mustAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'You must accept terms to continue'**
  String get mustAcceptTerms;

  /// No description provided for @myBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get myBookings;

  /// No description provided for @myFinancings.
  ///
  /// In en, this message translates to:
  /// **'My Financings'**
  String get myFinancings;

  /// No description provided for @mySubscription.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get mySubscription;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get myWallet;

  /// No description provided for @nameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get nameError;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameHint;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nearestToMyLocation.
  ///
  /// In en, this message translates to:
  /// **'Nearest to my location'**
  String get nearestToMyLocation;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordHint;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get newPasswordRequired;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you have account?'**
  String get noAccount;

  /// No description provided for @noActiveSubscription.
  ///
  /// In en, this message translates to:
  /// **'🚫 No active subscription'**
  String get noActiveSubscription;

  /// No description provided for @noBookingsFound.
  ///
  /// In en, this message translates to:
  /// **'No bookings found'**
  String get noBookingsFound;

  /// No description provided for @noCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No cars available.'**
  String get noCarsAvailable;

  /// No description provided for @noCarsFound.
  ///
  /// In en, this message translates to:
  /// **'No cars found'**
  String get noCarsFound;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @noFavouritesFound.
  ///
  /// In en, this message translates to:
  /// **'No favourites found'**
  String get noFavouritesFound;

  /// No description provided for @noFeaturesSelected.
  ///
  /// In en, this message translates to:
  /// **'No features selected - Tap to select'**
  String get noFeaturesSelected;

  /// No description provided for @noFinancedCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No financed cars available'**
  String get noFinancedCarsAvailable;

  /// No description provided for @noFinancingsFound.
  ///
  /// In en, this message translates to:
  /// **'No financings found'**
  String get noFinancingsFound;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'No history available'**
  String get noHistory;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @noRecommendedCarsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No recommended cars available.'**
  String get noRecommendedCarsAvailable;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results 😢'**
  String get noResults;

  /// Message shown when there are no reviews for a car
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @numberOfDays.
  ///
  /// In en, this message translates to:
  /// **'Number of days\n'**
  String get numberOfDays;

  /// No description provided for @oneDay.
  ///
  /// In en, this message translates to:
  /// **'1 day'**
  String get oneDay;

  /// No description provided for @orSignInWith.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get orSignInWith;

  /// No description provided for @otpDescription.
  ///
  /// In en, this message translates to:
  /// **'We sent you a code, please enter the 6-digit code.'**
  String get otpDescription;

  /// No description provided for @otpErrorIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Enter full 6 digit OTP'**
  String get otpErrorIncomplete;

  /// No description provided for @otpInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter full 6 digit OTP'**
  String get otpInvalid;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to {email}, please enter the 6 digit code from your email.'**
  String otpMessage(Object email);

  /// No description provided for @otpResendAction.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get otpResendAction;

  /// No description provided for @otpResendPrompt.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get otpResendPrompt;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify the code sent to you'**
  String get otpTitle;

  /// No description provided for @owner.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @passwordErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordErrorEmpty;

  /// No description provided for @passwordErrorShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordErrorShort;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment methods'**
  String get paymentMethods;

  /// No description provided for @paymentSessionCreated.
  ///
  /// In en, this message translates to:
  /// **'✔ Payment session created successfully'**
  String get paymentSessionCreated;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentage;

  /// No description provided for @phoneError.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get phoneError;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pickupAndDelivery.
  ///
  /// In en, this message translates to:
  /// **'Pickup & Delivery'**
  String get pickupAndDelivery;

  /// No description provided for @pickupDelivery.
  ///
  /// In en, this message translates to:
  /// **'Pickup and delivery available?'**
  String get pickupDelivery;

  /// No description provided for @pickupDeliveryPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Pickup & Delivery Price (Jod)'**
  String get pickupDeliveryPriceHint;

  /// No description provided for @pickupDeliveryQ.
  ///
  /// In en, this message translates to:
  /// **'Do you provide pick-up and delivery service?'**
  String get pickupDeliveryQ;

  /// No description provided for @pickupDeliveryQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you provide pick-up and delivery service?'**
  String get pickupDeliveryQuestion;

  /// Shows plan name and daily price
  ///
  /// In en, this message translates to:
  /// **'Plan: {planName}\nDaily price: {dailyPrice} JOD'**
  String planDetails(Object planName, Object dailyPrice);

  /// No description provided for @planName.
  ///
  /// In en, this message translates to:
  /// **'Plan Name'**
  String get planName;

  /// No description provided for @plateType.
  ///
  /// In en, this message translates to:
  /// **'Plate Type'**
  String get plateType;

  /// No description provided for @plateTypeCommercial.
  ///
  /// In en, this message translates to:
  /// **'white'**
  String get plateTypeCommercial;

  /// No description provided for @plateTypeGovernment.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get plateTypeGovernment;

  /// No description provided for @plateTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Plate Type'**
  String get plateTypeHint;

  /// No description provided for @plateTypePrivate.
  ///
  /// In en, this message translates to:
  /// **'green'**
  String get plateTypePrivate;

  /// No description provided for @pleaseAddRatingAndReview.
  ///
  /// In en, this message translates to:
  /// **'Please add rating and review'**
  String get pleaseAddRatingAndReview;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseSelectBookingDates.
  ///
  /// In en, this message translates to:
  /// **'Please select booking dates'**
  String get pleaseSelectBookingDates;

  /// No description provided for @popularCar.
  ///
  /// In en, this message translates to:
  /// **'Popular Car'**
  String get popularCar;

  /// No description provided for @popularCarError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String popularCarError(Object message);

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @previousRent.
  ///
  /// In en, this message translates to:
  /// **'Previous Rent'**
  String get previousRent;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @pricePerDay.
  ///
  /// In en, this message translates to:
  /// **'Enter the price per day'**
  String get pricePerDay;

  /// No description provided for @pricePerDayHint.
  ///
  /// In en, this message translates to:
  /// **'Enter the price per day'**
  String get pricePerDayHint;

  /// No description provided for @pricingInfo.
  ///
  /// In en, this message translates to:
  /// **'Pricing Information'**
  String get pricingInfo;

  /// No description provided for @pricingInformation.
  ///
  /// In en, this message translates to:
  /// **'Pricing Information'**
  String get pricingInformation;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @private.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private;

  /// No description provided for @privateRenter.
  ///
  /// In en, this message translates to:
  /// **'Private Renter'**
  String get privateRenter;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @recommendationCars.
  ///
  /// In en, this message translates to:
  /// **'Recommendation Cars'**
  String get recommendationCars;

  /// No description provided for @recommendedCarError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String recommendedCarError(Object message);

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejectFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to reject ❌'**
  String get rejectFailed;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @rentNow.
  ///
  /// In en, this message translates to:
  /// **'Rent Now'**
  String get rentNow;

  /// No description provided for @rentalDateTime.
  ///
  /// In en, this message translates to:
  /// **'Rental Date & Time'**
  String get rentalDateTime;

  /// No description provided for @rentalOffice.
  ///
  /// In en, this message translates to:
  /// **'Rental Office'**
  String get rentalOffice;

  /// No description provided for @renter.
  ///
  /// In en, this message translates to:
  /// **'Renter'**
  String get renter;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resendCode;

  /// No description provided for @resendPrompt.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get resendPrompt;

  /// No description provided for @reserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get reserved;

  /// No description provided for @resetPasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordBtn;

  /// Label for reviews section
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String reviews(Object count);

  /// No description provided for @saveEdit.
  ///
  /// In en, this message translates to:
  /// **'Save Edit'**
  String get saveEdit;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchFilter.
  ///
  /// In en, this message translates to:
  /// **'Search Filter'**
  String get searchFilter;

  /// No description provided for @searchForCar.
  ///
  /// In en, this message translates to:
  /// **'Search for a car'**
  String get searchForCar;

  /// No description provided for @searchKeyword.
  ///
  /// In en, this message translates to:
  /// **'Keyword'**
  String get searchKeyword;

  /// No description provided for @searchOrSelectFilter.
  ///
  /// In en, this message translates to:
  /// **'Search or select a filter first'**
  String get searchOrSelectFilter;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @searchSomethingHere.
  ///
  /// In en, this message translates to:
  /// **'Search something here'**
  String get searchSomethingHere;

  /// No description provided for @selectCarFeatures.
  ///
  /// In en, this message translates to:
  /// **'Select Car Features'**
  String get selectCarFeatures;

  /// No description provided for @selectCategoryHint.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategoryHint;

  /// No description provided for @selectEndDate.
  ///
  /// In en, this message translates to:
  /// **'Select End Date'**
  String get selectEndDate;

  /// No description provided for @selectExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Please select expiry date'**
  String get selectExpiryDate;

  /// No description provided for @selectStartDate.
  ///
  /// In en, this message translates to:
  /// **'Select Start Date'**
  String get selectStartDate;

  /// No description provided for @selectedFeatures.
  ///
  /// In en, this message translates to:
  /// **'Selected Features:'**
  String get selectedFeatures;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sendReview.
  ///
  /// In en, this message translates to:
  /// **'SEND REVIEW'**
  String get sendReview;

  /// No description provided for @send_financing_request.
  ///
  /// In en, this message translates to:
  /// **'Send Financing Request'**
  String get send_financing_request;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'SENDING...'**
  String get sending;

  /// No description provided for @setNewPasswordMessage.
  ///
  /// In en, this message translates to:
  /// **'Create a new password. Ensure it differs from previous ones for security'**
  String get setNewPasswordMessage;

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set A New Password'**
  String get setNewPasswordTitle;

  /// No description provided for @shareYourOpinion.
  ///
  /// In en, this message translates to:
  /// **'Please share your opinion\nabout the product'**
  String get shareYourOpinion;

  /// No description provided for @signInBtn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInBtn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpBtn.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpBtn;

  /// No description provided for @signUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign up now and enjoy rental ease like never before.'**
  String get signUpDescription;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpTitle;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @sponsored.
  ///
  /// In en, this message translates to:
  /// **'Sponsored Ad'**
  String get sponsored;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date:'**
  String get startDate;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @subjectHint.
  ///
  /// In en, this message translates to:
  /// **'Write a subject'**
  String get subjectHint;

  /// No description provided for @subjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subjectLabel;

  /// No description provided for @subjectValidation.
  ///
  /// In en, this message translates to:
  /// **'Please write a subject'**
  String get subjectValidation;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @subscribeNow.
  ///
  /// In en, this message translates to:
  /// **'Subscribe now'**
  String get subscribeNow;

  /// No description provided for @subscriptionInfo.
  ///
  /// In en, this message translates to:
  /// **'You must subscribe to access all features and start using the app.'**
  String get subscriptionInfo;

  /// No description provided for @subscriptionPlan.
  ///
  /// In en, this message translates to:
  /// **'Subscription Plan'**
  String get subscriptionPlan;

  /// No description provided for @subscriptionPrice.
  ///
  /// In en, this message translates to:
  /// **'Subscription Price'**
  String get subscriptionPrice;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription Plans'**
  String get subscriptionTitle;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @termsAndSubmit.
  ///
  /// In en, this message translates to:
  /// **'Terms & Submit'**
  String get termsAndSubmit;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @topUpFirst.
  ///
  /// In en, this message translates to:
  /// **'Top up first'**
  String get topUpFirst;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @touristOffice.
  ///
  /// In en, this message translates to:
  /// **'Tourist Office'**
  String get touristOffice;

  /// No description provided for @tryAdjustingSearchOrFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters'**
  String get tryAdjustingSearchOrFilters;

  /// No description provided for @twoDays.
  ///
  /// In en, this message translates to:
  /// **'2 days'**
  String get twoDays;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @updateCar.
  ///
  /// In en, this message translates to:
  /// **'Update Car'**
  String get updateCar;

  /// No description provided for @updatePasswordBtn.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePasswordBtn;

  /// No description provided for @updating.
  ///
  /// In en, this message translates to:
  /// **'Updating...'**
  String get updating;

  /// No description provided for @uploadCarImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Car Images'**
  String get uploadCarImages;

  /// No description provided for @uploadCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Car'**
  String get uploadCarTitle;

  /// No description provided for @uploadDrivingLicens.
  ///
  /// In en, this message translates to:
  /// **'Upload National ID'**
  String get uploadDrivingLicens;

  /// No description provided for @uploadDrivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Upload Office License'**
  String get uploadDrivingLicense;

  /// No description provided for @uploadNow.
  ///
  /// In en, this message translates to:
  /// **'Upload Now'**
  String get uploadNow;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @usageTypeBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get usageTypeBusiness;

  /// No description provided for @usageTypeCommercial.
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get usageTypeCommercial;

  /// No description provided for @usageTypeFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get usageTypeFamily;

  /// No description provided for @usageTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Nature of use'**
  String get usageTypeHint;

  /// No description provided for @usageTypePersonal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get usageTypePersonal;

  /// No description provided for @userBtn.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get userBtn;

  /// No description provided for @vendorBtn.
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendorBtn;

  /// Label for vendor details section
  ///
  /// In en, this message translates to:
  /// **'Vendor Details'**
  String get vendorDetails;

  /// No description provided for @verifyCodeBtn.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyCodeBtn;

  /// No description provided for @verifyOtpBtn.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verifyOtpBtn;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @walletHistory.
  ///
  /// In en, this message translates to:
  /// **'Wallet History'**
  String get walletHistory;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @whatIsYourRate.
  ///
  /// In en, this message translates to:
  /// **'What is your rate?'**
  String get whatIsYourRate;

  /// No description provided for @withdrawFailure.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal failed'**
  String get withdrawFailure;

  /// No description provided for @withdrawSuccess.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal successful'**
  String get withdrawSuccess;

  /// No description provided for @withdrawal.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal'**
  String get withdrawal;

  /// No description provided for @withdrawalPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Methods'**
  String get withdrawalPageTitle;

  /// No description provided for @writeASubject.
  ///
  /// In en, this message translates to:
  /// **'Write a subject'**
  String get writeASubject;

  /// No description provided for @writeReview.
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReview;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get yourLocation;

  /// No description provided for @yourReview.
  ///
  /// In en, this message translates to:
  /// **'Your review'**
  String get yourReview;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
