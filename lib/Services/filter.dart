String categoryFilter(String category) {
  if (category == "Cocuk-ve-Genclik") {
    return "Çocuk ve Gençlik";
  } else if (category == "Prestij-Kitaplari") {
    return "Prestij Kitapları";
  } else if (category == "Edebiyat") {
    return "Edebiyat";
  } else if (category == "Egitim-Basvuru") {
    return "Eğitim Başvuru";
  } else if (category == "Mitoloji-Efsane") {
    return "Mitoloji Efsane";
  } else if (category == "Arastirma-Tarih") {
    return "Araştırma-Tarih";
  } else if (category == "Din-Tasavvuf") {
    return "Din Tasavvuf";
  } else if (category == "Sanat-Tasarim") {
    return "Sanat-Tasarım";
  } else if (category == "Felsefe") {
    return "Felsefe";
  } else if (category == "Cizgi-Roman") {
    return "Çizgi Roman";
  } else if (category == "Hobi") {
    return "Hobi";
  } else if (category == "Bilim") {
    return "Bilim";
  } else if (category == "Mizah") {
    return "Mizah";
  } else {
    return "Bilinmiyor";
  }
}

kitapYayinevi(kitap) {
    if (kitap.length == 1) {
      return kitap[0];
    } else if (kitap.length == 2) {
      return kitap[1];
    } else {
      return kitap[2];
    }
  }