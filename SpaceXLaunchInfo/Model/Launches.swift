
struct Launch: Decodable {
    let name: String
    let rocket: String
    let success: Bool?
    let dateLocal: String
}
