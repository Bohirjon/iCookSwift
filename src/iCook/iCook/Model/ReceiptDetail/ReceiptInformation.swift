
import Foundation

// MARK: - ReceiptInformation
struct ReceiptInformation: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy, cheap, veryPopular, sustainable: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let lowFodmap: Bool
    let aggregateLikes, spoonacularScore, healthScore: Int
    let creditsText, license, sourceName: String
    let pricePerServing: Double
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let image: String
    let imageType, summary: String
    let cuisines, dishTypes, diets: [String]
    let instructions: String
    
    let analyzedInstructions: [AnalyzedInstruction]
    let extendedIngredients: [ExtendedIngredient]
    //    let winePairing: WinePairing
    //    let spoonacularSourceURL: String
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable, Identifiable {
    var id:  UUID  {
        UUID()
    }
    
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

// MARK: - Ent
struct Ent: Codable {
    let id: Int
    let name, localizedName, image: String
    let temperature: Length?
}

// MARK: - Length
struct Length: Codable {
    let number: Int
    let unit: String
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Identifiable {
    let id: Int
    let aisle, image, consistency, name: String
    let original, originalString, originalName: String
    let amount: Int
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

//// MARK: - WinePairing
//struct WinePairing: Codable {
//    let pairedWines: [String]
//    let pairingText: String
//    let productMatches: [ProductMatch]
//}
//
//// MARK: - ProductMatch
//struct ProductMatch: Codable {
//    let id: Int
//    let title, price: String
//    let productMatchDescription : String!
//
//    let imageURL: String
//    let averageRating: Double
//    let ratingCount: Int
//    let score: Double
//    let link: String
//}
