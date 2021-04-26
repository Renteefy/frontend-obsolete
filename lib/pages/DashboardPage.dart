import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/BugReportPage.dart';
import 'package:frontend/pages/InviteUser.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:frontend/models/UserListing.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/services/UserHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/pages/EditProfile.dart';
import 'package:frontend/shared/alertBox.dart';
import 'package:frontend/pages/LandingPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                      UserInfoCard(),
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

class PlaceholderHorizontalView extends StatelessWidget {
  const PlaceholderHorizontalView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "look",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                child: Text(
                  "into the",
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white24),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 175.0,
              width: 175.0,
              color: Colors.white10,
              child: Center(
                  child: Text(
                "void",
                style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white24),
              )),
            ),
          )
        ],
      ),
    );
  }
}

class HorizontalCardViewBuilder extends StatelessWidget {
  HorizontalCardViewBuilder({
    Key key,
    @required this.res,
    this.type,
  }) : super(key: key);

  final List<SingleItem> res;
  final String type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (res == null)
          ? Center(child: CircularProgressIndicator())
          : (res.length == 0)
              ? Center(child: Text("Nothing to show here"))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: res.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print(res[index].itemID);
                          var route = MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    itemID: res[index].itemID,
                                    item: type,
                                  ));
                          Navigator.of(context).push(route);
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    flex: 10,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              url + res[index].url)),
                                    )),
                                Flexible(
                                  child: Text(res[index].title + "",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
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

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (userDetails == null)
        ? CircularProgressIndicator()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (userDetails.firstName == null &&
                            userDetails.lastName == null)
                        ? Text(userDetails.username,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ))
                        : Text(
                            userDetails.firstName + " " + userDetails.lastName,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(userDetails.email,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, color: kAccentColor3)),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                      firstName: userDetails.firstName,
                                      lastName: userDetails.lastName,
                                      url: userDetails.picture,
                                      username: userDetails.username));
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(Icons.email_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => InviteUser());
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(Icons.bug_report_outlined),
                            onPressed: () {
                              var route = MaterialPageRoute(
                                  builder: (context) => BugReportPage());
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            var route = MaterialPageRoute(
                                builder: (context) => LandingPage());
                            VoidCallback continueCallBack = () async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(userDetails.email)
                                  .set({"token": null});
                              store.write(key: 'username', value: null);
                              Navigator.of(context).pushReplacement(route);
                              // code on Okay comes here
                            };
                            BlurryDialog alert = BlurryDialog(
                                "Logout",
                                "Are you sure you want to logout?",
                                continueCallBack,
                                true);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: (userDetails.picture.startsWith("/static"))
                    ? NetworkImage(url + userDetails.picture)
                    : NetworkImage(userDetails.picture),
              ),
            ],
          );
  }
}
