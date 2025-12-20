/// Model untuk response check ongkir V2 dengan sistem tiered pricing
/// Mendukung Google Maps distance calculation & time slot management
class OngkirV2Response {
  DistanceInfo? distance;
  PricingInfo? pricing;

  OngkirV2Response({
    this.distance,
    this.pricing,
  });

  OngkirV2Response.fromJson(Map<String, dynamic> json) {
    distance = json['distance'] != null
        ? DistanceInfo.fromJson(json['distance'])
        : null;
    pricing =
        json['pricing'] != null ? PricingInfo.fromJson(json['pricing']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (distance != null) {
      data['distance'] = distance!.toJson();
    }
    if (pricing != null) {
      data['pricing'] = pricing!.toJson();
    }
    return data;
  }
}

/// Informasi jarak dari Google Maps atau Haversine fallback
class DistanceInfo {
  int? meters; // Jarak dalam meter (450)
  String? text; // Format readable "450 m" atau "5.5 km"
  String? duration; // Estimasi durasi "3 menit" atau "15 menit"
  String? source; // "google_maps" atau "haversine"

  DistanceInfo({
    this.meters,
    this.text,
    this.duration,
    this.source,
  });

  DistanceInfo.fromJson(Map<String, dynamic> json) {
    meters = json['meters'];
    text = json['text'];
    duration = json['duration'];
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meters'] = meters;
    data['text'] = text;
    data['duration'] = duration;
    data['source'] = source;
    return data;
  }
}

/// Informasi pricing tier dan biaya pengiriman
class PricingInfo {
  int? tierId; // ID pricing tier
  String? tierName; // Nama tier "Free Delivery (0-500m)"
  int? rate; // Total ongkir (0 untuk gratis, atau nilai calculated)
  bool? isFreeOngkir; // Apakah gratis ongkir?
  bool? requireTimeSlot; // Apakah perlu pilih time slot?
  int? extraDistanceMeters; // Extra jarak untuk variable pricing
  int? extraCharge; // Extra charge untuk variable pricing
  List<TimeSlot>? timeSlots; // Array time slots (jika free ongkir)
  PricingBreakdown? breakdown; // Breakdown untuk variable pricing

  // NEW: Minimum purchase fields for free ongkir
  int? minPurchase; // Minimum purchase amount untuk free ongkir (e.g., 50000)
  String? minPurchaseText; // Formatted: "Rp50.000"
  bool? isEligibleFreeOngkir; // Apakah customer memenuhi syarat min_purchase
  bool? isInFreeOngkirRange; // Apakah jarak dalam range tier free ongkir

  PricingInfo({
    this.tierId,
    this.tierName,
    this.rate,
    this.isFreeOngkir,
    this.requireTimeSlot,
    this.extraDistanceMeters,
    this.extraCharge,
    this.timeSlots,
    this.breakdown,
    this.minPurchase,
    this.minPurchaseText,
    this.isEligibleFreeOngkir,
    this.isInFreeOngkirRange,
  });

  PricingInfo.fromJson(Map<String, dynamic> json) {
    tierId = json['tier_id'];
    tierName = json['tier_name'];
    rate = json['rate'];
    isFreeOngkir = json['is_free_ongkir'];
    requireTimeSlot = json['require_time_slot'];
    extraDistanceMeters = json['extra_distance_meters'];
    extraCharge = json['extra_charge'];

    // NEW: Parse min_purchase fields
    minPurchase = json['min_purchase'];
    minPurchaseText = json['min_purchase_text'];
    isEligibleFreeOngkir = json['is_eligible_free_ongkir'];
    isInFreeOngkirRange = json['is_in_free_ongkir_range'];

    if (json['time_slots'] != null) {
      timeSlots = <TimeSlot>[];
      json['time_slots'].forEach((v) {
        timeSlots!.add(TimeSlot.fromJson(v));
      });
    }

    breakdown = json['breakdown'] != null
        ? PricingBreakdown.fromJson(json['breakdown'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tier_id'] = tierId;
    data['tier_name'] = tierName;
    data['rate'] = rate;
    data['is_free_ongkir'] = isFreeOngkir;
    data['require_time_slot'] = requireTimeSlot;
    data['extra_distance_meters'] = extraDistanceMeters;
    data['extra_charge'] = extraCharge;

    // NEW: Add min_purchase fields
    data['min_purchase'] = minPurchase;
    data['min_purchase_text'] = minPurchaseText;
    data['is_eligible_free_ongkir'] = isEligibleFreeOngkir;
    data['is_in_free_ongkir_range'] = isInFreeOngkirRange;

    if (timeSlots != null) {
      data['time_slots'] = timeSlots!.map((v) => v.toJson()).toList();
    }

    if (breakdown != null) {
      data['breakdown'] = breakdown!.toJson();
    }

    return data;
  }
}

/// Time slot untuk pengiriman gratis
class TimeSlot {
  int? id;
  String? name; // "Pagi (08:00 - 10:00)"
  String? startTime; // "08:00:00"
  String? endTime; // "10:00:00"
  int? maxOrders; // Maksimal order per slot (10)
  int? currentOrders; // Current jumlah order (5)
  int? remainingQuota; // Sisa quota (5)

  TimeSlot({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.maxOrders,
    this.currentOrders,
    this.remainingQuota,
  });

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    maxOrders = json['max_orders'];
    currentOrders = json['current_orders'];
    remainingQuota = json['remaining_quota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['max_orders'] = maxOrders;
    data['current_orders'] = currentOrders;
    data['remaining_quota'] = remainingQuota;
    return data;
  }

  /// Get quota percentage (0-100)
  double get quotaPercentage {
    if (maxOrders == null || maxOrders == 0) return 0;
    return ((currentOrders ?? 0) / maxOrders!) * 100;
  }

  /// Check if slot is full
  bool get isFull => remainingQuota == null || remainingQuota! <= 0;

  /// Check if slot is almost full (<= 2 remaining)
  bool get isAlmostFull =>
      remainingQuota != null && remainingQuota! > 0 && remainingQuota! <= 2;

  /// Get status text
  String get statusText {
    if (isFull) return 'PENUH';
    if (isAlmostFull) return 'Hampir Penuh';
    return 'Tersedia';
  }
}

/// Breakdown pricing untuk variable pricing (jarak jauh)
class PricingBreakdown {
  int? basePrice; // Harga dasar Rp 12.000
  int? extraKm; // Extra kilometer (3 km)
  int? extraCharge; // Extra charge Rp 10.500
  int? perKmPrice; // Harga per km (Rp 3.500)

  PricingBreakdown({
    this.basePrice,
    this.extraKm,
    this.extraCharge,
    this.perKmPrice,
  });

  PricingBreakdown.fromJson(Map<String, dynamic> json) {
    basePrice = json['base_price'];
    extraKm = json['extra_km'];
    extraCharge = json['extra_charge'];
    perKmPrice = json['per_km_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_price'] = basePrice;
    data['extra_km'] = extraKm;
    data['extra_charge'] = extraCharge;
    data['per_km_price'] = perKmPrice;
    return data;
  }
}
