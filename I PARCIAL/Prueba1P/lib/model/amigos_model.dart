class AmigosModel {
  // Calcula la suma de divisores propios de n
  // Divisores propios: 1 <= d < n, donde n % d == 0
  static int sumaDivisoresPropios(int n) {
    if (n <= 1) return 0;
    int suma = 1; // el 1 siempre es divisor propio de cualquier n > 1
    // Optimización: solo iteramos hasta sqrt(n)
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        suma += i;
        if (i != n ~/ i) {
          suma += n ~/ i;
        }
      }
    }
    return suma;
  }

  // Retorna un Map con toda la info del resultado
  static Map<String, dynamic> verificarAmigos(int a, int b) {
    int sumaA = sumaDivisoresPropios(a);
    int sumaB = sumaDivisoresPropios(b);
    bool sonAmigos = (sumaA == b) && (sumaB == a);

    return {
      "a": a,
      "b": b,
      "sumaA": sumaA,
      "sumaB": sumaB,
      "sonAmigos": sonAmigos,
    };
  }
}