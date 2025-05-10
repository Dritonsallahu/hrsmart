import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_sq.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('nl'),
    Locale('sq')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @startedPrice.
  ///
  /// In en, this message translates to:
  /// **'Started price'**
  String get startedPrice;

  /// No description provided for @dailyTransactions.
  ///
  /// In en, this message translates to:
  /// **'Daily transactions'**
  String get dailyTransactions;

  /// No description provided for @dailyActivity.
  ///
  /// In en, this message translates to:
  /// **'Daily activity'**
  String get dailyActivity;

  /// No description provided for @noActitivy.
  ///
  /// In en, this message translates to:
  /// **'No activity'**
  String get noActitivy;

  /// No description provided for @addEmployee.
  ///
  /// In en, this message translates to:
  /// **'Add employee'**
  String get addEmployee;

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @dailyReport.
  ///
  /// In en, this message translates to:
  /// **'Daily reports'**
  String get dailyReport;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @employeeActivity.
  ///
  /// In en, this message translates to:
  /// **'Employee activity'**
  String get employeeActivity;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @employeeNumber.
  ///
  /// In en, this message translates to:
  /// **'Employees number'**
  String get employeeNumber;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @searchEmployee.
  ///
  /// In en, this message translates to:
  /// **'Search employee'**
  String get searchEmployee;

  /// No description provided for @debtValue.
  ///
  /// In en, this message translates to:
  /// **'Debt value'**
  String get debtValue;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @addTransaction.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get addTransaction;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @outcome.
  ///
  /// In en, this message translates to:
  /// **'Outcome'**
  String get outcome;

  /// No description provided for @gross.
  ///
  /// In en, this message translates to:
  /// **'Gross'**
  String get gross;

  /// No description provided for @net.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get net;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current balance'**
  String get currentBalance;

  /// No description provided for @openCashboxText.
  ///
  /// In en, this message translates to:
  /// **'Open cashbox to continue with daily transactions'**
  String get openCashboxText;

  /// No description provided for @openedCashboxText.
  ///
  /// In en, this message translates to:
  /// **'Last day cashbox not closed yet, close it to open new one to continue'**
  String get openedCashboxText;

  /// No description provided for @openCashbox.
  ///
  /// In en, this message translates to:
  /// **'Open cashbox'**
  String get openCashbox;

  /// No description provided for @closeCashbox.
  ///
  /// In en, this message translates to:
  /// **'Close cashbox'**
  String get closeCashbox;

  /// No description provided for @openedCashbox.
  ///
  /// In en, this message translates to:
  /// **'Cashbox open'**
  String get openedCashbox;

  /// No description provided for @closedCashbox.
  ///
  /// In en, this message translates to:
  /// **'Cashbox closed'**
  String get closedCashbox;

  /// No description provided for @cashboxDetails.
  ///
  /// In en, this message translates to:
  /// **'Cashbox details'**
  String get cashboxDetails;

  /// No description provided for @startedDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get startedDate;

  /// No description provided for @closedDate.
  ///
  /// In en, this message translates to:
  /// **'Closed date'**
  String get closedDate;

  /// No description provided for @startPrice.
  ///
  /// In en, this message translates to:
  /// **'Open price'**
  String get startPrice;

  /// No description provided for @closedPrice.
  ///
  /// In en, this message translates to:
  /// **'Closed price'**
  String get closedPrice;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @seeCashboxList.
  ///
  /// In en, this message translates to:
  /// **'See cashbox list'**
  String get seeCashboxList;

  /// No description provided for @cashboxList.
  ///
  /// In en, this message translates to:
  /// **'Cashbox list'**
  String get cashboxList;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions'**
  String get noTransactions;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @deleteTransactionTextAlert.
  ///
  /// In en, this message translates to:
  /// **'Shpenzimi do te fshihet, a jeni i sigurt ?'**
  String get deleteTransactionTextAlert;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @nextVersionMessage.
  ///
  /// In en, this message translates to:
  /// **'We are preparing this feature for next update, we kindly ask for your patience'**
  String get nextVersionMessage;

  /// No description provided for @noEmployee.
  ///
  /// In en, this message translates to:
  /// **'No employee added!'**
  String get noEmployee;

  /// No description provided for @salary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get salary;

  /// No description provided for @widthdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get widthdraw;

  /// No description provided for @monthlyBalance.
  ///
  /// In en, this message translates to:
  /// **'Monthly balance'**
  String get monthlyBalance;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total balance'**
  String get totalBalance;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @opsions.
  ///
  /// In en, this message translates to:
  /// **'Opsions'**
  String get opsions;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get edit;

  /// No description provided for @waiter.
  ///
  /// In en, this message translates to:
  /// **'Waiter'**
  String get waiter;

  /// No description provided for @manager.
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get manager;

  /// No description provided for @minus.
  ///
  /// In en, this message translates to:
  /// **'Minus'**
  String get minus;

  /// No description provided for @withPayment.
  ///
  /// In en, this message translates to:
  /// **'In salary'**
  String get withPayment;

  /// No description provided for @withoutPayment.
  ///
  /// In en, this message translates to:
  /// **'Out salary'**
  String get withoutPayment;

  /// No description provided for @deleteAlertText.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this employee?'**
  String get deleteAlertText;

  /// No description provided for @allowedMinus.
  ///
  /// In en, this message translates to:
  /// **'Allowed minus'**
  String get allowedMinus;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @closeMonth.
  ///
  /// In en, this message translates to:
  /// **'Close month'**
  String get closeMonth;

  /// No description provided for @closedMonth.
  ///
  /// In en, this message translates to:
  /// **'Closed month'**
  String get closedMonth;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @noClosingMonthPrice.
  ///
  /// In en, this message translates to:
  /// **'Please press the price for closing this month'**
  String get noClosingMonthPrice;

  /// No description provided for @deletedEmployee.
  ///
  /// In en, this message translates to:
  /// **'Employee successfully deleted.'**
  String get deletedEmployee;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @thisMonthSalaryIs.
  ///
  /// In en, this message translates to:
  /// **'This month salary is:'**
  String get thisMonthSalaryIs;

  /// No description provided for @leftDebtIs.
  ///
  /// In en, this message translates to:
  /// **'Left debt is: '**
  String get leftDebtIs;

  /// No description provided for @completeFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all fields!'**
  String get completeFields;

  /// No description provided for @successUpdate.
  ///
  /// In en, this message translates to:
  /// **'Data successfully updated.'**
  String get successUpdate;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @minusUntil.
  ///
  /// In en, this message translates to:
  /// **'Max minus'**
  String get minusUntil;

  /// No description provided for @loadingEmployee.
  ///
  /// In en, this message translates to:
  /// **'Loading employees'**
  String get loadingEmployee;

  /// No description provided for @exceedCheckoutValueText.
  ///
  /// In en, this message translates to:
  /// **'The given value exceeds the checkout amount\nnThe remaining amount in the checkout:'**
  String get exceedCheckoutValueText;

  /// No description provided for @reachedLimit.
  ///
  /// In en, this message translates to:
  /// **'has reached the withdrawal limit within the month.'**
  String get reachedLimit;

  /// No description provided for @aboveLimit.
  ///
  /// In en, this message translates to:
  /// **'The given value is greater than the allowed limit'**
  String get aboveLimit;

  /// No description provided for @oldCheckoutOpen.
  ///
  /// In en, this message translates to:
  /// **'The opened cash register is not from today, please close the old cash register and open a new one to add new spending.'**
  String get oldCheckoutOpen;

  /// No description provided for @closedCheckoutMessage.
  ///
  /// In en, this message translates to:
  /// **'You cannot add spending without opening the cash register!'**
  String get closedCheckoutMessage;

  /// No description provided for @doYouWantToOpenCheckout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to open checkout ?'**
  String get doYouWantToOpenCheckout;

  /// No description provided for @doYouWantToCloseCheckout.
  ///
  /// In en, this message translates to:
  /// **'Do you want to close checkout ?'**
  String get doYouWantToCloseCheckout;

  /// No description provided for @checkoutCalculatingError.
  ///
  /// In en, this message translates to:
  /// **'There is an error in the checkout calculation\nnPlease contact the administration for details!'**
  String get checkoutCalculatingError;

  /// No description provided for @branches.
  ///
  /// In en, this message translates to:
  /// **'Branches'**
  String get branches;

  /// No description provided for @packets.
  ///
  /// In en, this message translates to:
  /// **'Packets'**
  String get packets;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @startPriceCheckoutAlert.
  ///
  /// In en, this message translates to:
  /// **'The initial amount must be set at the checkout!'**
  String get startPriceCheckoutAlert;

  /// No description provided for @laterDateNeeded.
  ///
  /// In en, this message translates to:
  /// **'The date must be greater than today'**
  String get laterDateNeeded;

  /// No description provided for @biggerDateAlert.
  ///
  /// In en, this message translates to:
  /// **'The date must not be less than today'**
  String get biggerDateAlert;

  /// No description provided for @dateBiggerThanCheckoutDate.
  ///
  /// In en, this message translates to:
  /// **'ATTENTION!\nYou have chosen a date greater than the checkout start date'**
  String get dateBiggerThanCheckoutDate;

  /// No description provided for @incomeValue.
  ///
  /// In en, this message translates to:
  /// **'Entry value'**
  String get incomeValue;

  /// No description provided for @closingValue.
  ///
  /// In en, this message translates to:
  /// **'Closing value'**
  String get closingValue;

  /// No description provided for @filterByDate.
  ///
  /// In en, this message translates to:
  /// **'Filter by date'**
  String get filterByDate;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryName;

  /// No description provided for @addCategory.
  ///
  /// In en, this message translates to:
  /// **'Add category'**
  String get addCategory;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @catgories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get catgories;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @closedTime.
  ///
  /// In en, this message translates to:
  /// **'Closed time'**
  String get closedTime;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'nl', 'sq'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'nl': return AppLocalizationsNl();
    case 'sq': return AppLocalizationsSq();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
