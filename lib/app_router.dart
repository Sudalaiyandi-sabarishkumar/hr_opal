import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'views/auth/change_password.dart';
import 'views/auth/forgot_password.dart';
import 'views/auth/init_page.dart';
import 'views/auth/landing_page.dart';
import 'views/auth/login_page.dart';
import 'views/auth/otp_page.dart';
import 'views/auth/reset_password.dart';
import 'views/auth/sign_in_page.dart';
import 'views/home/home_page.dart';
import 'views/home/main_shell.dart';
import 'views/leaves/my_leaves_page.dart';
import 'views/loader/app_loader.dart';
import 'views/more_options/announcements_page.dart';
import 'views/more_options/holiday_calender_page.dart';
import 'views/payroll/pay_breakdown_page.dart';
import 'views/payroll/pay_slips_page.dart';
import 'views/policies/policies.dart';
import 'views/profile/amendments.dart';
import 'views/profile/assets.dart';
import 'views/profile/document.dart';
import 'views/profile/family_address_details.dart';
import 'views/profile/job_details.dart';
import 'views/profile/my_team.dart';
import 'views/profile/profile_information.dart';
import 'views/profile/profile_page.dart';
import 'views/profile/qualifications_page.dart';
import 'views/profile/request_history.dart';
import 'views/profile/timeline_page.dart';
import 'views/request/asset_request.dart';
import 'views/request/attendance_regularization_request.dart';
import 'views/request/document_request.dart';
import 'views/request/encashment_request.dart';
import 'views/request/expense_request.dart';
import 'views/request/letter_request.dart';
import 'views/request/loan_request.dart';
import 'views/request/passport_request.dart';
import 'views/request/request_screen.dart';
import 'views/request/tax_request.dart';
import 'views/request/travel_request.dart';
import 'views/request/travel_settlement_request.dart';

class FirebaseUtils {
  static bool isFlutterTest = Platform.environment.containsKey('FLUTTER_TEST');
}

class RouteConstants {
  static String initPage = 'init';
  static String appLoaderPage = 'appLoader';
  static String landingPage = 'landing';
  static String signInPage = 'signIn';
  static String forgotPasswordPage = 'forgotPassword';
  static String otpPage = 'otp';
  static String resetPasswordPage = 'resetPassword';
  static String changePasswordPage = 'changePassword';
  static String loginPage = 'login';
  static String homePage = 'home';
  static String mainShellPage = 'mainShell';
  static String profilePage = 'profile';
  static String myteamPage = 'myteam';
  static String familyAddressPage = 'familyaddress';
  static String personalInformationPage = 'personalInformation';
  static String jobDetailsPage = 'jobdetails';
  static String amendmentsPage = 'amendments';
  static String requestHistoryPage = 'requestHistory';
  static String documentsPage = 'documents';
  static String assetsPage = 'assets';
  static String qualificationsPage = 'qualifications';
  static String timeleinePage = 'timeline';
  static String expenseRequest = 'expenseRequest';
  static String payslipsPage = 'payslips';
  static String payBreakdownPage = 'payBreakdown';
  static String holidayCalanderPage = 'holidayCalander';
  static String announcementsPage = 'announcements';
  static String requestPage = 'requests';
  static String loanRequestPage = 'loanRequest';
  static String assetRequestPage = 'assetRequest';
  static String letterRequestPage = 'letterRequest';
  static String travelRequestPage = 'travelRequest';
  static String travelSettlementRequestPage = 'travelSettlementRequest';
  static String documentRequestPage = 'documentRequest';
  static String passportRequestPage = 'passportRequest';
  static String encashmentRequestPage = 'encashmentRequest';
  static String taxRequestPage = 'taxRequest';
  static String attendanceRegularizationPage = 'attendanceRegularization';
  static String myLeavesPage = 'myLeaves';
  static String hrPoliciesPage = 'hrPolicies';
}

class GoRouterInit {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static String initialLocation = '/';
  static final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();
  static Object? initialExtra;

  static GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    observers: <NavigatorObserver>[
      GoRouterInit.routeObserver,
      if (!FirebaseUtils.isFlutterTest)
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
    ],
    initialLocation: initialLocation,
    initialExtra: initialExtra,
    navigatorKey: navigatorKey,
    routes: <RouteBase>[
      // Init Page
      GoRoute(
        path: '/',
        name: RouteConstants.initPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<InitPage>(child: InitPage()),
      ),
      GoRoute(
        path: '/loader',
        name: RouteConstants.appLoaderPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AppLoader>(child: AppLoader()),
      ),
      GoRoute(
        path: '/profile',
        name: RouteConstants.profilePage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<ProfilePage>(child: ProfilePage()),
      ),
      GoRoute(
        path: '/auth/landing',
        name: RouteConstants.landingPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<LandingPage>(child: LandingPage()),
      ),
      GoRoute(
        path: '/auth/sign-in',
        name: RouteConstants.signInPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<SignInPage>(child: SignInPage()),
      ),
      GoRoute(
        path: '/auth/sign-in/forgot-password',
        name: RouteConstants.forgotPasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<ForgotPasswordPage>(child: ForgotPasswordPage()),
      ),
      GoRoute(
        path: '/auth/otp',
        name: RouteConstants.otpPage,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> data =
              (state.extra as Map<String, dynamic>?) ?? <String, dynamic>{};

          return MaterialPage<OtpPage>(
            child: OtpPage(
              email: (data['email'] as String?) ?? '',
              maskedMobileNumber:
                  (data['maskedMobileNumber'] as String?) ?? '966*******56',
              onVerify: data['on_verify'] as OtpVerificationCallback?,
              successRoute:
                  (data['success_route'] as String?) ??
                  RouteConstants.resetPasswordPage,
            ),
          );
        },
      ),
      GoRoute(
        path: '/auth/login',
        name: RouteConstants.loginPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<LoginPage>(child: LoginPage()),
      ),
      GoRoute(
        path: '/auth/reset-password',
        name: RouteConstants.resetPasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<ResetPasswordPage>(child: ResetPasswordPage()),
      ),
      GoRoute(
        path: '/auth/change-password',
        name: RouteConstants.changePasswordPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<ChangePasswordPage>(child: ChangePasswordPage()),
      ),
      GoRoute(
        path: '/main',
        name: RouteConstants.mainShellPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<MainShell>(child: MainShell()),
      ),
      GoRoute(
        path: '/home',
        name: RouteConstants.homePage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<HomePage>(child: HomePage()),
      ),
      GoRoute(
        path: '/familyaddress',
        name: RouteConstants.familyAddressPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<FamilyAddressPage>(child: FamilyAddressPage()),
      ),
      GoRoute(
        path: '/myteam',
        name: RouteConstants.myteamPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<MyTeamScreen>(child: MyTeamScreen()),
      ),
      GoRoute(
        path: '/requestHistory',
        name: RouteConstants.requestHistoryPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<RequestsHistoryScreen>(
              child: RequestsHistoryScreen(),
            ),
      ),
      GoRoute(
        path: '/jobdetails',
        name: RouteConstants.jobDetailsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<JobDetailsScreen>(child: JobDetailsScreen()),
      ),
      GoRoute(
        path: '/assets',
        name: RouteConstants.assetsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AssetsScreen>(child: AssetsScreen()),
      ),
      GoRoute(
        path: '/qualifications',
        name: RouteConstants.qualificationsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<QualificationsPage>(child: QualificationsPage()),
      ),
      GoRoute(
        path: '/timeline',
        name: RouteConstants.timeleinePage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<TimelinePage>(child: TimelinePage()),
      ),
      GoRoute(
        path: '/documents',
        name: RouteConstants.documentsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<DocumentsScreen>(child: DocumentsScreen()),
      ),
      GoRoute(
        path: '/personalInformation',
        name: RouteConstants.personalInformationPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<PersonalInformationScreen>(
              child: PersonalInformationScreen(),
            ),
      ),
      GoRoute(
        path: '/amendments',
        name: RouteConstants.amendmentsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AmendmentsScreen>(child: AmendmentsScreen()),
      ),
      GoRoute(
        path: '/requests',
        name: RouteConstants.requestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<RequestPage>(child: RequestPage()),
      ),
      GoRoute(
        path: '/loanRequest',
        name: RouteConstants.loanRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<LoanRequest>(child: LoanRequest()),
      ),
      GoRoute(
        path: '/assetRequest',
        name: RouteConstants.assetRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AssetRequest>(child: AssetRequest()),
      ),
      GoRoute(
        path: '/letterRequest',
        name: RouteConstants.letterRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<LetterRequest>(child: LetterRequest()),
      ),
      GoRoute(
        path: '/travelRequest',
        name: RouteConstants.travelRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<TravelRequest>(child: TravelRequest()),
      ),
      GoRoute(
        path: '/travelSettlementRequest',
        name: RouteConstants.travelSettlementRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<TravelSettlementRequest>(
              child: TravelSettlementRequest(),
            ),
      ),
      GoRoute(
        path: '/documentRequest',
        name: RouteConstants.documentRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<DocumentRequest>(child: DocumentRequest()),
      ),
      GoRoute(
        path: '/passportRequest',
        name: RouteConstants.passportRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<PassportRequest>(child: PassportRequest()),
      ),
      GoRoute(
        path: '/encashmentRequest',
        name: RouteConstants.encashmentRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<EncashmentRequest>(child: EncashmentRequest()),
      ),
      GoRoute(
        path: '/taxRequest',
        name: RouteConstants.taxRequestPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<TaxRequest>(child: TaxRequest()),
      ),
      GoRoute(
        path: '/attendanceRegularization',
        name: RouteConstants.attendanceRegularizationPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AttendanceRegularizationRequest>(
              child: AttendanceRegularizationRequest(),
            ),
      ),
      GoRoute(
        path: '/myLeaves',
        name: RouteConstants.myLeavesPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<MyLeavesPage>(child: MyLeavesPage()),
      ),
      GoRoute(
        path: '/hrPolicies',
        name: RouteConstants.hrPoliciesPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<HrPoliciesPage>(child: HrPoliciesPage()),
      ),
      GoRoute(
        path: '/expenseRequest',
        name: RouteConstants.expenseRequest,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<ExpenseRequest>(child: ExpenseRequest()),
      ),
      GoRoute(
        path: '/payslips',
        name: RouteConstants.payslipsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<PaySlipsPage>(child: PaySlipsPage()),
      ),
      GoRoute(
        path: '/payBreakdown',
        name: RouteConstants.payBreakdownPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<PayBreakdownPage>(child: PayBreakdownPage()),
      ),
      GoRoute(
        path: '/holidayCalander',
        name: RouteConstants.holidayCalanderPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<HolidayCalenderPage>(
              child: HolidayCalenderPage(),
            ),
      ),
      GoRoute(
        path: '/announcements',
        name: RouteConstants.announcementsPage,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            const MaterialPage<AnnouncementsPage>(child: AnnouncementsPage()),
      ),
    ],
  );
}
