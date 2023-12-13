class TutorialPaymentVaModel {
  List<String>? tabs;
  List<Tab1>? tab1;
  List<Tab2>? tab2;
  List<Tab3>? tab3;
  List<Tab4>? tab4;

  TutorialPaymentVaModel(
      {this.tabs, this.tab1, this.tab2, this.tab3, this.tab4});

  TutorialPaymentVaModel.fromJson(Map<String, dynamic> json) {
    tabs = json['tabs'].cast<String>();
    if (json['tab1'] != null) {
      tab1 = <Tab1>[];
      json['tab1'].forEach((v) {
        tab1!.add(Tab1.fromJson(v));
      });
    }
    if (json['tab2'] != null) {
      tab2 = <Tab2>[];
      json['tab2'].forEach((v) {
        tab2!.add(Tab2.fromJson(v));
      });
    }
    if (json['tab3'] != null) {
      tab3 = <Tab3>[];
      json['tab3'].forEach((v) {
        tab3!.add(Tab3.fromJson(v));
      });
    }
    if (json['tab4'] != null) {
      tab4 = <Tab4>[];
      json['tab4'].forEach((v) {
        tab4!.add(Tab4.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tabs'] = tabs;
    if (tab1 != null) {
      data['tab1'] = tab1!.map((v) => v.toJson()).toList();
    }
    if (tab2 != null) {
      data['tab2'] = tab2!.map((v) => v.toJson()).toList();
    }
    if (tab3 != null) {
      data['tab3'] = tab3!.map((v) => v.toJson()).toList();
    }
    if (tab4 != null) {
      data['tab4'] = tab4!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tab1 {
  String? title;
  List<String>? content;

  Tab1({this.title, this.content});

  Tab1.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

class Tab2 {
  String? title;
  List<String>? content;

  Tab2({this.title, this.content});

  Tab2.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

class Tab3 {
  String? title;
  List<String>? content;

  Tab3({this.title, this.content});

  Tab3.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}

class Tab4 {
  String? title;
  List<String>? content;

  Tab4({this.title, this.content});

  Tab4.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    return data;
  }
}
