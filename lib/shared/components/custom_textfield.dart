
import 'package:flutter/material.dart';
//import 'package:my_test_shop/shared/cubit/login_cubit/login_cubit.dart';

 // ignore: non_constant_identifier_names
 Widget CustomTextField(
  { @required String hint,
    @required IconData icon,
    @required String  validatorT,
    bool visable,
   
    @required TextInputType type,
     TextEditingController controller,
    
    Function onClick,
     
    IconData passIcon,
  }
 ){
   return 
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        
        
        validator: (value) {
          
          if (value.isEmpty) {
            return validatorT;
            // ignore: missing_return
          }
        },
        
        // obscureText: hint == 'password' ? true : false,
        
        obscureText:visable ,
        decoration: InputDecoration(
          hintText: hint,
          
          
          suffixIcon: IconButton(
            onPressed: onClick,
            icon: Icon(
              passIcon,
              color: Colors.lightBlueAccent
            ),
          ),

          prefixIcon: Icon(
            icon,
            color: Colors.lightBlueAccent
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );

   
 }

// class CustomTextField extends StatelessWidget {
//   final String hint;
//   final IconData icon;
//   final Function onClick;
//   String _errorMessage(String str) {
//     switch (hint) {
//       case 'Enter your name':
//         return 'Name is empty !';
//       case 'Enter your email':
//         return 'Email is empty !';
//       case 'Enter your password':
//         return 'Password is empty !';
//     }
//   }

//   CustomTextField(
//       {@required this.onClick, @required this.icon, @required this.hint});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: TextFormField(
//         validator: (value) {
//           if (value.isEmpty) {
//             return _errorMessage(hint);
//             // ignore: missing_return
//           }
//         },
//         onSaved: onClick,
//         obscureText: hint == 'Enter your password' ? true : false,
//         cursorColor: kMainColor,
//         decoration: InputDecoration(
//           hintText: hint,
//           prefixIcon: Icon(
//             icon,
//             color: kMainColor,
//           ),
//           filled: true,
//           fillColor: kSecondaryColor,
//           enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(color: Colors.white)),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(color: Colors.white)),
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(20),
//               borderSide: BorderSide(color: Colors.white)),
//         ),
//       ),
//     );
//   }
// }
