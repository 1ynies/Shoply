import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode _myFocusNode;
  bool _isFocused = false;

  late final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _myFocusNode = FocusNode();

    _myFocusNode.addListener(() {
      setState(() {
        _isFocused = _myFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: _myFocusNode,
      controller: _textController,
      maxLines: 1,
      cursorColor: Colors.black87,
      style: GoogleFonts.manrope(
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      decoration: InputDecoration(
        suffixIcon: _isFocused
            ? InkWell(
                onTap: () {
                  _textController.clear();
                },
                child: Padding(
                  padding: .all(10),
                  child: SvgPicture.asset(
                    'lib/assets/svg/delete.svg', 
                    width: 14.0, 
                    height: 14.0,
                    color: Color(0xff99A1AF),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        filled: true,
        fillColor: Color(0xffF3F4F6),
        prefixIcon: Padding(
          padding: .all(10),
          child: SvgPicture.asset(
            'lib/assets/svg/search.svg',
            width: 10,
            height: 10,
            color: Color(0xff99A1AF),
          ),
        ),
    
        hintText: 'Search',
        hintStyle: TextStyle(color: Color(0xFF99A1AF)),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff99A1AF)),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF3F4F6), width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF9AE600), width: 1.0),
    
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
