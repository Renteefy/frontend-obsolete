import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/ItemListing.dart';
import 'package:frontend/models/UserListing.dart';
import 'package:frontend/services/ItemsHttpService.dart';
import 'package:frontend/services/UserHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/ProductDetails.dart';
import 'package:frontend/pages/EditProfile.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

UserListing userDetails;
final String url = "https://" + env['SERVER_URL'];
final itemService = ItemsHttpService();

class _DashboardPageState extends State<DashboardPage> {
  List<SingleItem> assetRes;
  List<SingleItem> serviceRes;
  List<SingleItem> rentedAssetRes;
  List<SingleItem> rentedServiceRes;

  @override
  void initState() {
    super.initState();
    fetchAssetRes();
    fetchRentedAssetRes();
    fetchServiceRes();
    fetchRentedServiceRes();
    fetchUserDetails();
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserInfoCard(),
          SizedBox(
            height: 40,
          ),
          TitleSection(
            title: "Your Assets",
            subtitle: "Your listed assets on Renteefy",
          ),
          HorizontalCardViewBuilder(res: assetRes),
          SizedBox(
            height: 40,
          ),
          TitleSection(
              title: "Your Services",
              subtitle: "Your listed services on Renteefy"),
          HorizontalCardViewBuilder(res: serviceRes),
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
          TitleSection(
              title: "Rented Assets", subtitle: "Assets you have rented"),
          HorizontalCardViewBuilder(res: rentedAssetRes),
          SizedBox(
            height: 40,
          ),
          TitleSection(
              title: "Rented Services", subtitle: "Service you have rented"),
          HorizontalCardViewBuilder(res: rentedServiceRes),
        ]),
      ),
    );
  }
}

class HorizontalCardViewBuilder extends StatelessWidget {
  HorizontalCardViewBuilder({
    Key key,
    @required this.res,
  }) : super(key: key);

  final List<SingleItem> res;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (res == null)
          ? Center(child: CircularProgressIndicator())
          : (res.length == 0)
              ? Text("This do be empty")
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
                    Text(userDetails.firstName + " " + userDetails.lastName,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        )),
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
                                      email: userDetails.email));
                              Navigator.of(context).push(route);
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            icon: Icon(Icons.email_outlined), onPressed: () {}),
                      ],
                    )
                  ],
                ),
              ),
              CircleAvatar(
                radius: 40,
                backgroundImage: (userDetails.picture != "/static/null")
                    ? NetworkImage(url + userDetails.picture)
                    : NetworkImage(
                        "https://ui-avatars.com/api/?name=Place+Holder"),
              ),
            ],
          );
  }
}
