import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/widget/card_review.dart';
import 'package:restaurant_app/utils/style/styles.dart';
import 'package:restaurant_app/utils/providers/restaurant_detail_provider.dart';

class ReviewPage extends StatefulWidget {
  static const routeName = '/review_page';

  final String restaurantId;
  ReviewPage({@required this.restaurantId});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final provider = RestaurantDetailProvider(apiService: ApiService());

  @override
  void initState() {
    provider.fetchDetailRestaurant(widget.restaurantId);
    super.initState();
  }

  void _addReview(Map data) {
    provider.addReview(data);
    provider.fetchDetailRestaurant(widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => provider,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: toscaColor,
          title: Text("Review customer"),
          centerTitle: true,
        ),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, value, _) {
            switch (value.state) {
              case ResultState.Loading:
                return Center(child: CircularProgressIndicator());
                break;

              case ResultState.HasData:
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: CardReview(
                    listReview: value.result.restaurant.customerReviews,
                  ),
                );
                break;
              case ResultState.NoData:
                return Center(child: Text(value.message));
                break;

              case ResultState.Error:
                return Center(child: Text(value.message));
                break;

              default:
                return Center(child: Text(''));
                break;
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add review",
          backgroundColor: toscaColor,
          child: Icon(Icons.edit, color: primaryColor),
          onPressed: () => showFormDialog(context),
        ),
      ),
    );
  }

  Future<void> showFormDialog(BuildContext context) async => await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _namaController = TextEditingController();
        final TextEditingController _reviewController = TextEditingController();

        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tambah review',
                  style: TextStyle(fontSize: 20, color: darkColor),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    return value.isNotEmpty ? null : "Nama wajib diisi";
                  },
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: 'Masukkan nama',
                    hintStyle: TextStyle(color: darkColor),
                    labelStyle: TextStyle(color: darkColor),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    return value.isNotEmpty ? null : "Invalid field";
                  },
                  minLines: 3,
                  maxLines: 5,
                  controller: _reviewController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    labelText: 'Masukkan review',
                    hintStyle: TextStyle(color: darkColor),
                    labelStyle: TextStyle(color: darkColor),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: darkColor),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _addReview({
                    'id': widget.restaurantId,
                    'name': _namaController.text,
                    'review': _reviewController.text
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(color: darkColor),
              ),
            ),
          ],
        );
      });
}
