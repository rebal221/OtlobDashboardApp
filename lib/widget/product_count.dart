// ignore_for_file: must_be_immutable

import 'package:otlab_controller/my_library.dart';

class ProductCount extends StatelessWidget {
  final IconData icon;
  void Function() count;

  ProductCount({super.key, required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: count,
      child: Card(
        color: AppColors.greyE,
        elevation: 3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Padding(
          padding: EdgeInsets.all(3.r),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
