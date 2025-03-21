type Position = (Int, Int)
data Color = W | B deriving (Eq, Show)
data Peg = Peg Position Color deriving (Eq, Show)
data Move = M Position deriving (Eq, Show)
type Board = [Peg]
data State = S Move Board deriving (Eq, Show)

createBoard :: Position -> Board
createBoard (x, y)  
					| elem (Peg (x,y) W) (createBoardHelper (x, y) (-3) (-1)) = createBoardHelper (x, y) (-3) (-1)
					| otherwise = error("The position is not valid.")

createBoardHelper :: Position -> Int -> Int -> Board
createBoardHelper (x, y) (-3) 2 = createBoardHelper (x, y) (-2) (-1)
createBoardHelper (x, y) (-2) 2 = createBoardHelper (x, y) (-1) (-3)
createBoardHelper (x, y) c1 4  = if (c1 >= (-1) && c1 < 1)  then createBoardHelper (x, y) (c1 + 1) (-3) else createBoardHelper (x, y) (c1 + 1) (-1)
createBoardHelper (x, y) (2) 2 = createBoardHelper (x, y) (3) (-1)
createBoardHelper (x, y) (3) 2 = []
createBoardHelper (x, y) 4 _ = []
createBoardHelper (x, y) c1 c2 
    | (c1 < (-1) || c1 > 1) && (c2 < 2 && c2 > (-2)) && (c1 == x && c2 == y) = Peg (c1, c2) W : createBoardHelper (x, y) c1 (c2 + 1)
    | (c1 < (-1) || c1 > 1) && (c2 < 2 && c2 > (-2)) = Peg (c1, c2) B : createBoardHelper (x, y) c1 (c2 + 1)
    | (c2 < 4) && (c1 == x && c2 == y) = Peg (c1, c2) W : createBoardHelper (x, y) c1 (c2 + 1)
    | (c2 < 4) = Peg (c1, c2) B : createBoardHelper (x, y) c1 (c2 + 1)
	
	
isValidMove:: Move -> Board -> Bool
isValidMove (M(x,y)) z 
								| elem (Peg (x,y) W) z = False
								| elem (Peg ((x+1),y) W)  z = True
								| elem (Peg ((x-1),y) W)  z = True
								| elem (Peg (x,(y+1)) W)  z = True
								| elem (Peg (x,(y-1)) W)  z = True
								| otherwise = False

								
isGoal:: Board -> Bool
isGoal [] = True
isGoal ((Peg (x,y) z):t) = if z==W then isGoal t else False

showPossibleNextStates:: Board -> [State]
showPossibleNextStates b 
						| isGoal b =  error("No Possible States Exist.")
						| otherwise = helper b  b

helper:: Board -> Board -> [State]						
helper [] _ = []
helper ((Peg (x,y) B):t) b   | isValidMove (M (x,y)) b == True = S (M(x,y)) (change (x,y) b)	: helper t b 
							 | otherwise = helper t b
							 
helper ((Peg (x,y) W):t) b = helper t b



change (x,y) ((Peg (a,b) c):t) |a==x&&b==y =   (Peg (a,b) W):t
		| otherwise = (Peg (a,b) c): change (x,y) t
