import Foundation

// FiveInLine stones
enum Stones: Int {
    case black = 0
    case white = 1
}

// FiveInLine order
enum Order: Int {
    case first = 0
    case after = 1

    var stones : Stones {
        switch self {
        case .first :
            return Stones.black
        case .after:
            return Stones.white
        }
    }

    var description: String {
        switch self {
        case .first:
            return "first"
        case .after:
            return "after"
        }
    }

    mutating func next () {
        switch self {
        case .first:
            self = .after
        case .after:
            self = .first
        }
    }
}

// FiveInLine borad
class Board {

    private var size: Int = 5
    
    private var stonesNum = [Stones:Int]()
    
    private var board: [[Stones?]] {    
        didSet {
            self.stonesNum = [:]

            board.flatMap{$0}.forEach { self.addStonesNum(stones: $0!) }
        }
    }

    init (board: String? = nil) {

        var tmp = [[Stones?]]()

        guard let _ = board else {
            for _ in 1...size {
                tmp.append([Stones?](repeating: nil, count: size))
            }
            self.board = tmp
            return
        }

        self.board = tmp
    }

    func getStonesNum (stones: Stones) -> Int{
        return self.stonesNum[stones, default: 0]
    }

    func addStonesNum (stones: Stones) {
        self.stonesNum[stones, default: 0] += 1
    }

    func disp (display: (([[Stones?]]) -> Void)?) {
        display?(board)
    }

}

// FiveInLine system
class FiveInLine {

    var order: Order!
    var board: Board

    init (order: Order, boardStr: String? = nil) {
        self.order = order
        self.board = Board(board: boardStr)
        self.dispStatus()
    }

    private func dispStatus () {
        print("order: \(self.order.description)")
        print("black: \(self.board.getStonesNum(stones: Stones.black))")
        print("white: \(self.board.getStonesNum(stones: Stones.white))")
        print("board:")
        self.board.disp(){
            (board) in 
            for boardRow in board {
                print(boardRow.map{ $0?.rawValue ?? -1})
            }
        }
    }
}

// FiveInLine command
func main() -> Int {

    let argv = ProcessInfo.processInfo.arguments

    if argv.count != 4 { 
        print("argument err \(argv.count): FiveInLine [boardSize] [order] [boradFile]")
        return -1
    }

    let importURL: URL = URL(fileURLWithPath: argv[3])

    do {
        let _ = try String(contentsOf: importURL, encoding: String.Encoding.utf8)
        let _ = FiveInLine(order: .first)
    } catch {
        print("file import err¥n\(error)")
        return -1
    }

    return 0
}

_ = main()