import Foundation

enum Stones: Int {
    case black = 0
    case white = 1
}

enum Turn: Int {
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

class Board {

    private var size: Int = 5
    private var board = [[Stones?]]()

    init (board: String? = nil) {

        guard let _ = board else {
            for _ in 1...size {
                self.board.append([Stones?](repeating: nil, count: size))
            }
            return
        }
    }

    internal func disp () {
        for boardRow in board {
            print(boardRow)
        }
    }

}

class FiveInLine {

    var turn: Turn!
    var board: Board

    init (turn: Turn, boardStr: String? = nil) {
        self.turn = turn
        self.board = Board(board: boardStr)
    }

    internal func disp () {
        print("turn: \(self.turn.description)")
        self.board.disp()
    }
}

func main() -> Int {

    let argv = ProcessInfo.processInfo.arguments

    if argv.count != 4 { 
        print("argument err \(argv.count): FiveInLine [boardSize] [turn] [boradFile]")
        return -1
    }

    let importURL:URL = URL(fileURLWithPath: argv[3])
    do {
        let _ = try String( contentsOf: importURL, encoding: String.Encoding.utf8)
        let fiveInLine = FiveInLine(turn: .first)
        fiveInLine.disp()
    } catch {
        print("file import err¥n\(error)")
        return -1
    }

    return 0
}

_ = main()