const String emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
const String phonePattern = r"/\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/";
const String base64Pattern =
    r"^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{4})$";

const String urlPattern =
    r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$";

const String phoneNumberPattern =
    r"(?:\b|[^0-9])((0|84|\+84)(\s?)([2-9]|1[0-9])(\d(\s|\.)?){8})(?:\b|[^0-9])";
