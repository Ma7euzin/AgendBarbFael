import 'package:agendfael/consts/consts.dart';

class CustomButtom extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const CustomButtom({super.key, required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenWidth,
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        onPressed: onTap,
        child: buttonText.text.make(),
      ),
    );
  }
}
