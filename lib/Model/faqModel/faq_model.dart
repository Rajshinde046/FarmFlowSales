class FaqModel {
  int? status;
  bool? success;
  Data? data;
  String? message;

  FaqModel({this.status, this.success, this.data, this.message});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Faqs>? faqs;

  Data({this.faqs});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['faqs'] != null) {
      faqs = <Faqs>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faqs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (faqs != null) {
      data['faqs'] = faqs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Faqs {
  int? id;
  String? question;
  String? answer;
  int? faqCategoryXid;
  String? faqCategory;

  Faqs(
      {this.id,
      this.question,
      this.answer,
      this.faqCategoryXid,
      this.faqCategory});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    faqCategoryXid = json['faq_category_xid'];
    faqCategory = json['faq_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['faq_category_xid'] = faqCategoryXid;
    data['faq_category'] = faqCategory;
    return data;
  }
}
