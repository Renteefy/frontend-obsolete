import 'package:flutter/material.dart';
import 'package:frontend/pages/AssetsCatalogPage.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/AssetListing.dart';
import 'package:frontend/services/AssetsHttpService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/pages/ProductDetails.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<SingleAsset> assetRes;
  @override
  void initState() {
    super.initState();
    fetchAssetRes();
  }

  void fetchAssetRes() async {
    List<SingleAsset> tmp = await AssetsHttpService().getUserAssets();
    setState(() {
      assetRes = tmp;
    });
  }

  // final List<SingleAsset> assetRes = [
  //   SingleAsset(
  //       description: "This is some description",
  //       price: "300",
  //       url: "https://via.placeholder.com/230",
  //       title: "This is title",
  //       interval: "some interval",
  //       owner: "yojat",
  //       renter: "tester1",
  //       assetID: "12"),
  // ];

  final List<SingleAsset> serviceRes = [
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        owner: "yojat",
        renter: "tester1",
        assetID: "12"),
  ];

  final List<SingleAsset> rentedAssetRes = [
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        owner: "yojat",
        renter: "tester1",
        assetID: "12"),
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        owner: "yojat",
        renter: "tester1",
        assetID: "12"),
  ];

  final List<SingleAsset> rentedServiceRes = [
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        owner: "yojat",
        renter: "tester1",
        assetID: "12"),
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        owner: "yojat",
        renter: "tester1",
        assetID: "12"),
  ];

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

  final List<SingleAsset> res;
  final String url = "https://" + env['SERVER_URL'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (res == null)
          ? CircularProgressIndicator()
          : (res.length == 0)
              ? Text("Assets Illa")
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: res.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          print(res[index].assetID);
                          var route = MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                    assetID: res[index].assetID,
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
    return Row(
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
              Text("Yajat Vishwakarma",
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  )),
              Text("yojat@gmail.com",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, color: kAccentColor3)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(icon: Icon(Icons.edit_outlined), onPressed: () {}),
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
          backgroundImage:
              NetworkImage("https://ui-avatars.com/api/?name=John+Doe"),
        ),
      ],
    );
  }
}
