import 'package:business_menagament/features/models/business_model.dart';
import 'package:business_menagament/features/presentation/providers/business_provider.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/screens/super_admin/new_business_screen.dart';
import 'package:business_menagament/features/presentation/screens/super_admin/request_business__screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    businessProvider.getAllBusinesses(context);
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  getBusinesses() {
    var businessProvider =
        Provider.of<BusinessProvider>(context, listen: false);
    businessProvider.getAllBusinesses(context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var businessProvider = Provider.of<BusinessProvider>(context);
    var currentUser = Provider.of<CurrentUser>(context);
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/background.jpeg"))),
          ),
        ),
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentUser.getBusinessAdmin() == null
                  ? ""
                  : currentUser.getBusinessAdmin()?.user?.fullName ?? "",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
            Text(
              "Administrator",
              style: GoogleFonts.poppins(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              controller: _tabController,
              tabs: const [
                Tab(text: 'Aktive'),
                Tab(text: 'Pasive'),
                Tab(text: 'Kerkesat'),
                Tab(text: 'Testim'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 39,
              width: MediaQuery.of(context).size.width - 30,
              child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'search',
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.search))),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  tabelat(businessProvider.getActiveBusinesses()),
                  tabPassive(businessProvider.getExpiredBusinesses()),
                  tabreq(businessProvider.getRequestBusinesses()),
                  testBusinesses(businessProvider.getTestBusinesses()),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
          width: 300,
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 13, right: 13),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/background.jpeg"))),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Smart management',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(
                                width: 3,
                              ),
                            ],
                          ),
                          Text(
                              currentUser.getBusinessAdmin() == null
                                  ? ""
                                  : currentUser.getBusinessAdmin()?.user?.fullName ?? "",
                              style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    child: ListTile(
                  hoverColor: Colors.black12,
                  title: const Text(
                    'Regjistro Biznese',
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewBusinessScreen(),
                        ));
                  },
                )),
                GestureDetector(
                    onTap: () {

                    },
                    child: const ListTile(
                      hoverColor: Colors.black12,
                      title: Text('Statistikat'),
                    )),
                GestureDetector(
                  onTap: () async {
                    await currentUser.removeBusinessAdmin(context);
                  },
                  child: const ListTile(
                    hoverColor: Colors.black12,
                    title: Text('Logout'),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget tabelat(List<BusinessModel> businesses) {
    return RefreshIndicator(
      onRefresh: () async {
        getBusinesses();
      },
      child: ListView.builder(
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            var business = businesses[index];
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
                                image: AssetImage(
                                    "assets/images/background.jpeg"))),
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
    );
  }

  Widget tabPassive(List<BusinessModel> businesses) {
    return RefreshIndicator(
      onRefresh: () async {
        getBusinesses();
      },
      child: ListView.builder(
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            var business = businesses[index];
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
                                image: AssetImage(
                                    "assets/images/background.jpeg"))),
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
    );
  }

  Widget tabreq(List<BusinessModel> businesses) {
    return RefreshIndicator(
      onRefresh: () async {
        getBusinesses();
      },
      child: ListView.builder(
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            var business = businesses[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => RequestBusinessScreen(businessModel: businesses[index])));
                },
                child: Container(
                  color: Colors.transparent,
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
                                    image: AssetImage(
                                        "assets/images/background.jpeg"))),
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
                ),
              ),
            );
          }),
    );
  }
  Widget testBusinesses(List<BusinessModel> businesses) {
    return RefreshIndicator(
      onRefresh: () async {
        getBusinesses();
      },
      child: ListView.builder(
          itemCount: businesses.length,
          itemBuilder: (context, index) {
            var business = businesses[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: GestureDetector(
                onTap: (){
                 },
                child: Container(
                  color: Colors.transparent,
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
                                    image: AssetImage(
                                        "assets/images/background.jpeg"))),
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
                ),
              ),
            );
          }),
    );
  }
}
