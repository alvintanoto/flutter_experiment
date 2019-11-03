String convertFarenheitToCelcius(value) {
  value = value - 273.15;
  return "${value.round().toString()}\u2103";
}