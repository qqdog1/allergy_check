enum AllergenLevel {
//  輕微：Mild
//  中等：Moderate
//  嚴重：Severe
//  危險：Very severe
  mild, moderate, severe, verySevere
}

// AllergenLevel getAllergenLevel(int score) {
//   if (score < 199) {
//     return AllergenLevel.mild;
//   } else if (score >= 199 && score <= 266) {
//     return AllergenLevel.moderate;
//   } else if (score >= 267 && score <= 322) {
//     return AllergenLevel.severe;
//   } else {
//     return AllergenLevel.verySevere;
//   }
// }