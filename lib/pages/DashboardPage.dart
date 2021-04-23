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
    setState(() {
      loading = false;
    });
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
        ? CircularProgressIndicator()
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInfoCard(),
                    SizedBox(
                      height: 40,
                    ),
                    (assetRes.length == 0)
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleSection(
                                title: "Your Assets",
                                subtitle: "Your listed assets on Renteefy",
                              ),
                              HorizontalCardViewBuilder(res: assetRes),
                            ],
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    (serviceRes.length == 0)
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleSection(
                                  title: "Your Services",
                                  subtitle: "Your listed services on Renteefy"),
                              HorizontalCardViewBuilder(
                                  res: serviceRes, type: "service"),
                              SizedBox(
                                height: 40,
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                    (rentedAssetRes.length == 0)
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleSection(
                                  title: "Rented Assets",
                                  subtitle: "Assets you have rented"),
                              HorizontalCardViewBuilder(
                                res: rentedAssetRes,
                                type: "asset",
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    (rentedServiceRes.length == 0)
                        ? SizedBox(height: 0)
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleSection(
                                  title: "Rented Services",
                                  subtitle: "Service you have rented"),
                              HorizontalCardViewBuilder(
                                  res: rentedServiceRes, type: "service"),
                            ],
                          ),
                  ]),
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
        Text(title,
            style:
                GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900)),
        Text(subtitle,
            style: GoogleFonts.inter(
                color: kAccentColor3,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
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
                    Text("Hey there,",
                        style: GoogleFonts.inter(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kAccentColor1)),
                    SizedBox(
                      height: 10,
                    ),
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
