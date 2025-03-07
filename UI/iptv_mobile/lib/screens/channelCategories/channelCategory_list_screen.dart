import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iptv_mobile/providers/channelCategory_provider.dart';
import '../../models/channelCategory.dart';
import '../../widgets/exyutv_drawer.dart';
import 'channelCategory_preview_screen.dart';

class ChannelCategoryListScreen extends StatefulWidget {
  static const String routeName = "channelCategories";

  @override
  _ChannelCategoryListScreenState createState() => _ChannelCategoryListScreenState();
}

class _ChannelCategoryListScreenState extends State<ChannelCategoryListScreen> {
  final ChannelCategoryProvider _channelCategoryProvider = ChannelCategoryProvider();
  final TextEditingController _searchController = TextEditingController();
  List<ChannelCategory> data = [];
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

  @override
  void initState() {
    super.initState();
    loadData(searchFilter, page, pageSize);
    scrollController.addListener(_scrollListener);
  }

  Future<void> loadData(String searchFilter, int page, int pageSize) async {
    if (searchFilter != '') {
      page = 1;
    }
    var response = await _channelCategoryProvider?.getForPagination({
      'SearchFilter': searchFilter.toString() ?? "",
      'PageNumber': page.toString(),
      'PageSize': pageSize.toString()
    });
    setState(() {
      if (searchFilter != '' || deleteList) {
        data = response?.items as List<ChannelCategory>;
        if (searchFilter == '') {
          deleteList = false;
        }
      } else {
        data.addAll(response?.items as List<ChannelCategory>);
      }
    });
    totalRecordCounts = response?.totalCount as int;
    numberOfPages = ((totalRecordCounts - 1) / pageSize).toInt() + 1;
    setState(() {
      isLoading = false;
    });
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
        title: Text("Pregled kategorija kanala"),
      ),
      drawer: ExyutvDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildSearch(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final channelCategory = data[index];
                return _buildCard(channelCategory);
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
        "Kategorije kanala",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildSearch() {
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

  Widget _buildCard(ChannelCategory channelCategory) {
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
              builder: (context) => ChannelCategoryPreviewScreen(channelCategory: channelCategory),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channelCategory.name,
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
                          "Redni broj: ${channelCategory.orderNumber}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    if (channelCategory.isActive)
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Aktivan",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50], // Svijetloplava pozadina za oznaku
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "Neaktivan",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[800],
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