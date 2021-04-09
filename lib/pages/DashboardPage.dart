import 'package:flutter/material.dart';
import 'package:frontend/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/AssetListing.dart';

class DashboardPage extends StatelessWidget {
  final List<SingleAsset> assetres = [
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        username: "yojat",
        assetID: "12"),
    SingleAsset(
        description: "This is some description",
        price: "300",
        url: "https://via.placeholder.com/230",
        title: "This is title",
        interval: "some interval",
        username: "yojat",
        assetID: "12"),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          UserInfoCard(),
          TitleSection(),
          SizedBox(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                itemCount: assetres.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  image: NetworkImage(assetres[index].url)),
                            )),
                            Flexible(
                              child: Text(
                                  assetres[index].title +
                                      "ajsdfnaskldfansdlnfa asdfnasdlkfnlk",
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    )),
          )
        ]),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Your Assets",
            style:
                GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w900)),
        Text("Your asset listings on Renteefy",
            style:
                GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500)),
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
