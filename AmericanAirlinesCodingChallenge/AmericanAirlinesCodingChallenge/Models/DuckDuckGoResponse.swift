import Foundation

struct DuckDuckGoResponse: Codable {
    let abstract: String
    let abstractSource: String
    let abstractURL: String
    let heading: String
    let answer: String
    let answerType: String
    let definition: String
    let definitionSource: String
    let definitionURL: String
    let entity: String
    let image: String
    let imageHeight: Int
    let imageIsLogo: Int
    let imageWidth: Int
    let infobox: Infobox?
    let redirect: String
    let results: [Result]
    let relatedTopics: [RelatedTopic]
    let type: String
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case abstract = "Abstract"
        case abstractSource = "AbstractSource"
        case abstractURL = "AbstractURL"
        case heading = "Heading" 
        case answer = "Answer"
        case answerType = "AnswerType"
        case definition = "Definition"
        case definitionSource = "DefinitionSource"
        case definitionURL = "DefinitionURL"
        case entity = "Entity"
        case image = "Image"
        case imageHeight = "ImageHeight"
        case imageIsLogo = "ImageIsLogo"
        case imageWidth = "ImageWidth"
        case infobox = "Infobox"
        case redirect = "Redirect"
        case results = "Results"
        case relatedTopics = "RelatedTopics"
        case type = "Type"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode standard fields
        abstract = try container.decode(String.self, forKey: .abstract)
        abstractSource = try container.decode(String.self, forKey: .abstractSource)
        abstractURL = try container.decode(String.self, forKey: .abstractURL)
        heading = try container.decode(String.self, forKey: .heading)
        answer = try container.decode(String.self, forKey: .answer)
        answerType = try container.decode(String.self, forKey: .answerType)
        definition = try container.decode(String.self, forKey: .definition)
        definitionSource = try container.decode(String.self, forKey: .definitionSource)
        definitionURL = try container.decode(String.self, forKey: .definitionURL)
        entity = try container.decode(String.self, forKey: .entity)
        image = try container.decode(String.self, forKey: .image)
        
        // Handle imageHeight which could be Int or String
        if let heightInt = try? container.decode(Int.self, forKey: .imageHeight) {
            self.imageHeight = heightInt
        } else if let heightStr = try? container.decode(String.self, forKey: .imageHeight),
                  let height = Int(heightStr) {
            self.imageHeight = height
        } else {
            self.imageHeight = 0
        }
        
        // Handle imageIsLogo which could be Int or String
        if let isLogoInt = try? container.decode(Int.self, forKey: .imageIsLogo) {
            self.imageIsLogo = isLogoInt
        } else if let isLogoStr = try? container.decode(String.self, forKey: .imageIsLogo),
                  let isLogo = Int(isLogoStr) {
            self.imageIsLogo = isLogo
        } else {
            self.imageIsLogo = 0
        }
        
        // Handle imageWidth which could be Int or String
        if let widthInt = try? container.decode(Int.self, forKey: .imageWidth) {
            self.imageWidth = widthInt
        } else if let widthStr = try? container.decode(String.self, forKey: .imageWidth),
                  let width = Int(widthStr) {
            self.imageWidth = width
        } else {
            self.imageWidth = 0
        }
        
        redirect = try container.decode(String.self, forKey: .redirect)
        
        // Handle Infobox which could be a string or a complex object
        do {
            infobox = try container.decode(Infobox.self, forKey: .infobox)
        } catch {
            print("Error decoding Infobox: \(error)")
            infobox = nil
        }
        
        // Handle other collections
        results = try container.decode([Result].self, forKey: .results)
        
        do {
            relatedTopics = try container.decode([RelatedTopic].self, forKey: .relatedTopics)
        } catch {
            print("Error decoding RelatedTopics: \(error)")
            relatedTopics = []
        }
        
        type = try container.decode(String.self, forKey: .type)
        meta = try container.decode(Meta.self, forKey: .meta)
    }
}

struct Infobox: Codable {
    let content: [InfoboxContent]
    let meta: [InfoboxMeta]
    
    // Custom init to handle Infobox being a string in some responses
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            
            if let _ = try? container.decode(String.self) {
                // If Infobox is a string, initialize with empty arrays
                self.content = []
                self.meta = []
                return
            }
        } catch {
            // Fall through to try keyed container
        }
        
        do {
            // If it's the expected dictionary structure
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Handle content array which might have items with missing fields
            do {
                self.content = try container.decode([InfoboxContent].self, forKey: .content)
            } catch {
                print("Error decoding Infobox content: \(error)")
                self.content = []
            }
            
            // Handle meta array
            do {
                self.meta = try container.decode([InfoboxMeta].self, forKey: .meta)
            } catch {
                print("Error decoding Infobox meta: \(error)")
                self.meta = []
            }
        } catch {
            // If all decoding attempts fail, initialize with empty arrays
            print("Failed to decode Infobox in any format: \(error)")
            self.content = []
            self.meta = []
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case content
        case meta
    }
}

struct InfoboxContent: Codable {
    let dataType: String
    let label: String
    let value: InfoboxValue
    let wikiOrder: InfoboxOrder
    
    enum CodingKeys: String, CodingKey {
        case dataType = "data_type"
        case label
        case value
        case wikiOrder = "wiki_order"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle data_type field which might be missing
        dataType = try container.decodeIfPresent(String.self, forKey: .dataType) ?? ""
        
        // Handle label field which might be missing
        label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
        
        // Handle value field with our custom InfoboxValue type
        do {
            value = try container.decode(InfoboxValue.self, forKey: .value)
        } catch {
            value = .string("")
        }
        
        // Handle wiki_order field which might be missing
        do {
            wikiOrder = try container.decode(InfoboxOrder.self, forKey: .wikiOrder)
        } catch {
            wikiOrder = .int(0)
        }
    }
}

enum InfoboxValue: Codable {
    case string(String)
    case stringArray([String])
    case dictionary([String: String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else if let arrayValue = try? container.decode([String].self) {
            self = .stringArray(arrayValue)
        } else if let dictValue = try? container.decode([String: String].self) {
            self = .dictionary(dictValue)
        } else {
            // Default to empty string if we can't decode
            self = .string("")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let string):
            try container.encode(string)
        case .stringArray(let array):
            try container.encode(array)
        case .dictionary(let dict):
            try container.encode(dict)
        }
    }
}

enum InfoboxOrder: Codable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let stringValue = try? container.decode(String.self) {
            self = .string(stringValue)
        } else {
            self = .int(0)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}

struct InfoboxMeta: Codable {
    let dataType: String
    let label: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case dataType = "data_type"
        case label
        case value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle missing fields with default values
        dataType = try container.decodeIfPresent(String.self, forKey: .dataType) ?? ""
        label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
        value = try container.decodeIfPresent(String.self, forKey: .value) ?? ""
    }
}

struct Result: Codable, Identifiable {
    var id: UUID { UUID() }
    let firstURL: String
    let icon: Icon
    let result: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

enum RelatedTopic: Codable, Identifiable {
    case topic(DirectTopic)
    case category(CategoryTopic)
    
    var id: UUID {
        switch self {
        case .topic(let topic):
            return topic.id
        case .category(let category):
            return category.id
        }
    }
    
    // Access FirstURL whether it's a direct topic or contained in a category
    var firstURL: String {
        switch self {
        case .topic(let topic):
            return topic.firstURL
        case .category:
            return "" // Categories don't have a firstURL
        }
    }
    
    // Access text whether it's a direct topic or contained in a category
    var text: String {
        switch self {
        case .topic(let topic):
            return topic.text
        case .category(let category):
            return category.name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let directTopic = try? container.decode(DirectTopic.self) {
            self = .topic(directTopic)
        } else if let categoryTopic = try? container.decode(CategoryTopic.self) {
            self = .category(categoryTopic)
        } else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode RelatedTopic"
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .topic(let topic):
            try container.encode(topic)
        case .category(let category):
            try container.encode(category)
        }
    }
}

// For direct topics without nesting
struct DirectTopic: Codable, Identifiable {
    var id: UUID { UUID() }
    let firstURL: String
    let icon: Icon
    let result: String
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

// For category topics with a Name and Topics array
struct CategoryTopic: Codable, Identifiable {
    var id: UUID { UUID() }
    let name: String
    let topics: [DirectTopic]
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case topics = "Topics"
    }
}

struct Icon: Codable {
    let height: String
    let url: String
    let width: String
    
    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case url = "URL"
        case width = "Width"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Handle height which could be a string or number
        if let heightInt = try? container.decode(Int.self, forKey: .height) {
            self.height = String(heightInt)
        } else {
            self.height = try container.decodeIfPresent(String.self, forKey: .height) ?? ""
        }
        
        // Handle URL
        self.url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        
        // Handle width which could be a string or number
        if let widthInt = try? container.decode(Int.self, forKey: .width) {
            self.width = String(widthInt)
        } else {
            self.width = try container.decodeIfPresent(String.self, forKey: .width) ?? ""
        }
    }
}

struct Meta: Codable {
    let attribution: String?
    let blockgroup: String?
    let createdDate: String?
    let description: String
    let designer: String?
    let devDate: String?
    let devMilestone: String
    let developer: [Developer]
    let exampleQuery: String
    let id: String
    let isStackexchange: String?
    let jsCallbackName: String
    let liveDate: String?
    let maintainer: Maintainer
    let name: String
    let perlModule: String
    let producer: String?
    let productionState: String
    let repo: String
    let signalFrom: String
    let srcDomain: String
    let srcId: Int
    let srcName: String
    let srcOptions: SrcOptions
    let srcUrl: String?
    let status: String?
    let tab: String?
    let topic: [String]
    let unsafe: Int
    
    enum CodingKeys: String, CodingKey {
        case attribution
        case blockgroup
        case createdDate = "created_date"
        case description
        case designer
        case devDate = "dev_date"
        case devMilestone = "dev_milestone"
        case developer
        case exampleQuery = "example_query"
        case id
        case isStackexchange = "is_stackexchange"
        case jsCallbackName = "js_callback_name"
        case liveDate = "live_date"
        case maintainer
        case name
        case perlModule = "perl_module"
        case producer
        case productionState = "production_state"
        case repo
        case signalFrom = "signal_from"
        case srcDomain = "src_domain"
        case srcId = "src_id"
        case srcName = "src_name"
        case srcOptions = "src_options"
        case srcUrl = "src_url"
        case status
        case tab
        case topic
        case unsafe
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        attribution = try container.decodeIfPresent(String.self, forKey: .attribution)
        blockgroup = try container.decodeIfPresent(String.self, forKey: .blockgroup)
        createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        description = try container.decode(String.self, forKey: .description)
        designer = try container.decodeIfPresent(String.self, forKey: .designer)
        devDate = try container.decodeIfPresent(String.self, forKey: .devDate)
        devMilestone = try container.decode(String.self, forKey: .devMilestone)
        developer = try container.decode([Developer].self, forKey: .developer)
        exampleQuery = try container.decode(String.self, forKey: .exampleQuery)
        id = try container.decode(String.self, forKey: .id)
        
        // Handle isStackexchange which could be string, number or null
        if let stringValue = try? container.decodeIfPresent(String.self, forKey: .isStackexchange) {
            isStackexchange = stringValue
        } else if let intValue = try? container.decodeIfPresent(Int.self, forKey: .isStackexchange) {
            isStackexchange = String(intValue)
        } else {
            isStackexchange = nil
        }
        
        jsCallbackName = try container.decode(String.self, forKey: .jsCallbackName)
        liveDate = try container.decodeIfPresent(String.self, forKey: .liveDate)
        maintainer = try container.decode(Maintainer.self, forKey: .maintainer)
        name = try container.decode(String.self, forKey: .name)
        perlModule = try container.decode(String.self, forKey: .perlModule)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        productionState = try container.decode(String.self, forKey: .productionState)
        repo = try container.decode(String.self, forKey: .repo)
        signalFrom = try container.decode(String.self, forKey: .signalFrom)
        srcDomain = try container.decode(String.self, forKey: .srcDomain)
        srcId = try container.decode(Int.self, forKey: .srcId)
        srcName = try container.decode(String.self, forKey: .srcName)
        srcOptions = try container.decode(SrcOptions.self, forKey: .srcOptions)
        srcUrl = try container.decodeIfPresent(String.self, forKey: .srcUrl)
        status = try container.decodeIfPresent(String.self, forKey: .status)
        tab = try container.decodeIfPresent(String.self, forKey: .tab)
        topic = try container.decode([String].self, forKey: .topic)
        unsafe = try container.decode(Int.self, forKey: .unsafe)
    }
}

struct Developer: Codable {
    let name: String
    let type: String
    let url: String
}

struct Maintainer: Codable {
    let github: String
}

struct SrcOptions: Codable {
    let directory: String
    let isFanon: Int
    let isMediawiki: Int
    let isWikipedia: Int
    let language: String
    let minAbstractLength: String
    let skipAbstract: Int
    let skipAbstractParen: Int
    let skipEnd: String
    let skipIcon: Int
    let skipImageName: Int
    let skipQr: String
    let sourceSkip: String
    let srcInfo: String
    
    enum CodingKeys: String, CodingKey {
        case directory
        case isFanon = "is_fanon"
        case isMediawiki = "is_mediawiki"
        case isWikipedia = "is_wikipedia"
        case language
        case minAbstractLength = "min_abstract_length"
        case skipAbstract = "skip_abstract"
        case skipAbstractParen = "skip_abstract_paren"
        case skipEnd = "skip_end"
        case skipIcon = "skip_icon"
        case skipImageName = "skip_image_name"
        case skipQr = "skip_qr"
        case sourceSkip = "source_skip"
        case srcInfo = "src_info"
    }
} 