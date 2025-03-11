import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iptv_mobile/screens/packages/package_preview_screen.dart';
import '../../models/listItemPackage.dart';
import '../../models/package.dart';
import '../../providers/login_provider.dart';
import '../../providers/packages_provider.dart';
import '../../widgets/exyutv_drawer.dart';

class PackageListScreen extends StatefulWidget {
  static const String routeName = "packages";

  @override
  _PackageListScreenState createState() => _PackageListScreenState();
}

class _PackageListScreenState extends State<PackageListScreen> {
  final PackageProvider _packageProvider = PackageProvider();
  final TextEditingController _searchController = TextEditingController();
  List<Package> data = [];
  List<ListItemPackage> recommendedPackages = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int pageSize = 10;
  int totalRecordCounts = 0;
  String searchFilter = '';
  int numberOfPages = 2;
  int currentPage = 1;
  bool isLoading = true;
  bool deleteList = false;
  final apiUrl = dotenv.env['API_URL']!;
  int _currentIndexPackage = 0;

  @override
  void initState() {
    super.initState();
    loadData(searchFilter, page, pageSize);
    loadRecommendedPackages();
    scrollController.addListener(_scrollListener);
  }

  Future<void> loadData(String searchFilter, int page, int pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _packageProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      if (searchFilter != '' || deleteList) {
        data = response?.items as List<Package>;
        if (searchFilter == '') {
          deleteList = false;
        }
      } else {
        data.addAll(response?.items as List<Package>);
      }
    });
    totalRecordCounts = response?.totalCount as int;
    numberOfPages = ((totalRecordCounts - 1) / pageSize).toInt() + 1;
    setState(() {
      isLoading = false;
    });
  }

  Future loadRecommendedPackages() async {
    var response = await _packageProvider?.getRecommendedPackages(LoginProvider.authResponse!.userId.toString());
    setState(() {
      if (response != null) {
        recommendedPackages = response;
      } else {
        recommendedPackages = [];
      }
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paketi"),
      ),
      drawer: ExyutvDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildChildSearch(),
          if(recommendedPackages.length > 0)
            Center(child:
            Text(
              "Preporučeni paketi",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            )),
          recommendedPackages.isNotEmpty ? CarouselSlider(
            options: CarouselOptions(
              height: 80.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndexPackage = index;
                });
              },
            ),
            items: recommendedPackages.map((package){
              return Builder(
                  builder:(BuildContext context){
                    return       GestureDetector(
                      child: Card (
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        elevation: 20,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon (
                                  Icons.card_giftcard,
                                  color: Colors.lightBlueAccent,
                                  size: 45
                              ),
                              title: Text(
                                package.label,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }).toList(),
          ) : Center(child: CircularProgressIndicator()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(recommendedPackages, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndexPackage == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final package = data[index];
                return _buildPackageCard(package);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "Paketi",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildChildSearch() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: _searchController,
        onChanged: (value) async {
          if (value.isEmpty) {
            setState(() {
              deleteList = true;
              page = 1;
            });
          } else {
            setState(() {
              deleteList = false;
            });
          }
          searchFilter = value.toString();
          await loadData(searchFilter, page, pageSize);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          hintText: "Pretraga",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
        ),
      ),
    );
  }

  Widget _buildPackageCard(Package package) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.grey[200],
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PackagePreviewScreen(package: package),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              if (package.iconUrl != null && package.iconUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  apiUrl + package.iconUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/smart-tv.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
              else
                Image.asset(
                  'assets/images/smart-tv.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 18,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Cijena: ${package.price} KM",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    if (package.discount != null && package.discount! > 0)
                      Row(
                        children: [
                          Icon(
                            Icons.local_offer,
                            size: 18,
                            color: Colors.green,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Popust: ${package.discount} %",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    if (package.isPromotional)
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Promocija",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!deleteList) {
        page++;
        loadData(searchFilter, page, pageSize);
      }
    }
  }
}