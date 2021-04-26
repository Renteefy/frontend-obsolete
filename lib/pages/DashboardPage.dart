import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:frontend/models/UserListing.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/services/UserHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:frontend/pages/components/UserInfoCard.dart';
import 'package:frontend/pages/components/PlaceHolder.dart';
import 'package:frontend/pages/components/HorizontalCard.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

UserListing userDetails;
final String url = "https://" + env['SERVER_URL'];
final itemService = ItemsHttpService();
bool loading = true;
final store = new FlutterSecureStorage();

class _DashboardPageState extends State<DashboardPage> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<SingleItem> assetRes = [];
  List<SingleItem> serviceRes = [];
  List<SingleItem> rentedAssetRes = [];
  List<SingleItem> rentedServiceRes = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAssetRes();
    fetchRentedAssetRes();
    fetchServiceRes();
    fetchRentedServiceRes();
    fetchUserDetails();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void onRefresh() async {
    setState(() {
      fetchAssetRes();
      fetchRentedAssetRes();
      fetchServiceRes();
      fetchRentedServiceRes();
      fetchUserDetails();
    });
    refreshController.refreshCompleted();
  }

  void fetchAssetRes() async {
    List<SingleItem> tmp = await itemService.getUserItems("asset");
    setState(() {
      assetRes = tmp;
    });
  }

  void fetchServiceRes() async {
    List<SingleItem> tmp = await itemService.getUserItems("service");
    setState(() {
      serviceRes = tmp;
    });
  }

  void fetchRentedAssetRes() async {
    List<SingleItem> tmp = await itemService.getUserRentedItems("asset");
    setState(() {
      rentedAssetRes = tmp;
    });
  }

  void fetchRentedServiceRes() async {
    List<SingleItem> tmp = await itemService.getUserRentedItems("service");
    setState(() {
      rentedServiceRes = tmp;
    });
  }

  void fetchUserDetails() async {
    UserListing tmp = await UserHttpService().getUserDetails();
    setState(() {
      userDetails = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading ||
            assetRes == null ||
            serviceRes == null ||
            rentedAssetRes == null ||
            rentedServiceRes == null)
        ? Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            onRefresh: onRefresh,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInfoCard(userDetails: userDetails),
                      TitleSection(
                        title: "Your Assets",
                        subtitle: "Your listed assets on Renteefy",
                      ),
                      (assetRes.length == 0)
                          ? PlaceholderHorizontalView()
                          : HorizontalCardViewBuilder(
                              res: assetRes, type: "asset"),
                      TitleSection(
                          title: "Your Services",
                          subtitle: "Your listed services on Renteefy"),
                      (serviceRes.length == 0)
                          ? PlaceholderHorizontalView()
                          : HorizontalCardViewBuilder(
                              res: serviceRes, type: "service"),
                      TitleSection(
                          title: "Rented Assets",
                          subtitle: "Assets you have rented"),
                      (rentedAssetRes.length == 0)
                          ? PlaceholderHorizontalView()
                          : HorizontalCardViewBuilder(
                              res: rentedAssetRes,
                              type: "asset",
                            ),
                      TitleSection(
                          title: "Rented Services",
                          subtitle: "Service you have rented"),
                      (rentedServiceRes.length == 0)
                          ? PlaceholderHorizontalView()
                          : HorizontalCardViewBuilder(
                              res: rentedServiceRes, type: "service"),
                    ]),
              ),
            ),
          );
  }
}

class TitleSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const TitleSection({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(title,
            style:
                GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900)),
        Text(subtitle,
            style: GoogleFonts.inter(
                color: kAccentColor3,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
