import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BusinessesListScreen extends StatefulWidget {
  const BusinessesListScreen({Key? key}) : super(key: key);

  @override
  State<BusinessesListScreen> createState() => _BusinessesListScreenState();
}

class _BusinessesListScreenState extends State<BusinessesListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldK = GlobalKey<ScaffoldState>();
  TextEditingController search = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    return Scaffold(
      key: _scaffoldK,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bizneset",
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: FormWidget(
              isReadOnly: false,
              enabled: true,
              hasPrefix: false,
              hasSufix: false,
              hintText: "Kerko biznesin",isPassword: false,textEditingController:search ,
              onChange: (value){
                businessProvider.filter(value,1);
              },
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: businessProvider.getActiveBusinesses().length,
              itemBuilder: (context, index) {
              var business = businessProvider.getActiveBusinesses()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                    AssetImage("assets/images/background.jpeg"))),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                business.name!,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                              ),
                              Text(
                                "${business.city!} - ${business.country!}",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Icon(Icons.arrow_forward)
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
