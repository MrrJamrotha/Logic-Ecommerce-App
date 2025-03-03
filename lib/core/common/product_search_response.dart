class ProductSearchResponse {
  final List<FacetCount> facetCounts;
  final int found;
  final List<Hit> hits;
  final int outOf;
  final int page;
  final RequestParams requestParams;
  final bool searchCutoff;
  final int searchTimeMs;

  ProductSearchResponse({
    required this.facetCounts,
    required this.found,
    required this.hits,
    required this.outOf,
    required this.page,
    required this.requestParams,
    required this.searchCutoff,
    required this.searchTimeMs,
  });

  factory ProductSearchResponse.fromJson(Map<String, dynamic> json) {
    return ProductSearchResponse(
      facetCounts: (json['facet_counts'] as List)
          .map((e) => FacetCount.fromJson(e))
          .toList(),
      found: json['found'],
      hits: (json['hits'] as List).map((e) => Hit.fromJson(e)).toList(),
      outOf: json['out_of'],
      page: json['page'],
      requestParams: RequestParams.fromJson(json['request_params']),
      searchCutoff: json['search_cutoff'],
      searchTimeMs: json['search_time_ms'],
    );
  }
}

class FacetCount {
  FacetCount();

  factory FacetCount.fromJson(Map<String, dynamic> json) {
    return FacetCount();
  }
}

class Hit {
  final Document document;
  final Map<String, dynamic> highlight;
  final List<dynamic> highlights;
  final int textMatch;
  final TextMatchInfo textMatchInfo;

  Hit({
    required this.document,
    required this.highlight,
    required this.highlights,
    required this.textMatch,
    required this.textMatchInfo,
  });

  factory Hit.fromJson(Map<String, dynamic> json) {
    return Hit(
      document: Document.fromJson(json['document']),
      highlight: Map<String, dynamic>.from(json['highlight']),
      highlights: List<dynamic>.from(json['highlights']),
      textMatch: json['text_match'],
      textMatchInfo: TextMatchInfo.fromJson(json['text_match_info']),
    );
  }
}

class Document {
  final String description;
  final String description2;
  final String id;
  final bool isActive;
  final String name;
  final String name2;

  Document({
    required this.description,
    required this.description2,
    required this.id,
    required this.isActive,
    required this.name,
    required this.name2,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      description: json['description'],
      description2: json['description_2'],
      id: json['id'],
      isActive: json['is_active'],
      name: json['name'],
      name2: json['name_2'],
    );
  }
}

class TextMatchInfo {
  final String bestFieldScore;
  final int bestFieldWeight;
  final int fieldsMatched;
  final int numTokensDropped;
  final String score;
  final int tokensMatched;
  final int typoPrefixScore;

  TextMatchInfo({
    required this.bestFieldScore,
    required this.bestFieldWeight,
    required this.fieldsMatched,
    required this.numTokensDropped,
    required this.score,
    required this.tokensMatched,
    required this.typoPrefixScore,
  });

  factory TextMatchInfo.fromJson(Map<String, dynamic> json) {
    return TextMatchInfo(
      bestFieldScore: json['best_field_score'],
      bestFieldWeight: json['best_field_weight'],
      fieldsMatched: json['fields_matched'],
      numTokensDropped: json['num_tokens_dropped'],
      score: json['score'],
      tokensMatched: json['tokens_matched'],
      typoPrefixScore: json['typo_prefix_score'],
    );
  }
}

class RequestParams {
  final String collectionName;
  final String firstQ;
  final int perPage;
  final String q;

  RequestParams({
    required this.collectionName,
    required this.firstQ,
    required this.perPage,
    required this.q,
  });

  factory RequestParams.fromJson(Map<String, dynamic> json) {
    return RequestParams(
      collectionName: json['collection_name'],
      firstQ: json['first_q'],
      perPage: json['per_page'],
      q: json['q'],
    );
  }
}
