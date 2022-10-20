import 'package:otlab_controller/my_library.dart';

class Loading2 extends StatelessWidget {
  const Loading2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.w,
      ),
    );
  }
}
