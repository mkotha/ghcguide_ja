{-# LANGUAGE ScopedTypeVariables #-}
module XMLFormat(format, ContentView(..), Element(..)) where

import Data.List(groupBy, findIndex)
import Data.Maybe(mapMaybe)
import Data.Char

data ContentView element
  = Child element
  | Other String

instance Element a => Show (ContentView a) where
  show = view_to_str

class Element a where
  tag :: a -> String
  attr :: a -> [(String, String)]
  content :: a -> [ContentView a]
  noEmpty :: a -> Bool
  isVerbatim :: a -> Bool

as_str :: (Element a) => a -> String
as_str x = "(ELM " ++ tag x ++ show (attr x) ++ concatMap view_to_str (content x) ++ ") "

view_to_str :: (Element a) => ContentView a -> String
view_to_str (Child element) = "Child " ++ as_str element
view_to_str (Other s) = "Other " ++ show s

isText :: ContentView a -> Bool
isText (Child _) = False
isText _ = True

fromText :: ContentView a -> Maybe String
fromText (Other s) = Just s
fromText _ = Nothing

breakAndIndent :: String -> Bool
breakAndIndent ('\n':cs) = all isSpace cs
breakAndIndent _ = False

isLeaf :: (Element a) => a -> Bool
isLeaf = null . content

type SS = String -> String

(+++) :: SS -> SS -> SS
(+++) = (.)

lit :: String -> SS
lit = (++)

cmap :: Bool -> (a -> SS) -> [ContentView a] -> SS
cmap verbatim f = foldr (+++) id . map ff
  where
    ff (Child e) = f e
    ff (Other str)
      | verbatim = lit str
      | otherwise  = lit $ normalize_white str

to_str :: SS -> String
to_str = ($"")

format :: forall a. (Element a) => a -> String
format root = to_str $ fmt 0 root
  where
    fmt :: Int -> a -> SS
    fmt level x
      | isLeaf x = indent $ leaf x +++ lit "\n"
      | isVerbatim x = if elem '\n' verbatim_content
          then lit "\n" +++ open_tag x +++ lit "\n" +++ lit verbatim_content +++ lit "\n" +++ close +++ lit "\n"
          else indent $ open_tag x +++ lit verbatim_content +++ close
      | any isText cont = indent $ open_tag x +++ inline_content +++ close
      | otherwise = indent (open_tag x) +++ lit "\n" +++ block_content +++ indent close
      where
        indent = (lit (replicate (2*level) ' ')+++)
        close = close_tag x +++ lit "\n"

        verbatim_content = fmt_verbatim_content cont
        inline_content = lit $ trim $ to_str $ cmap False (fmt_inline False) cont
        block_content = cmap True (fmt (level + 1)) cont
        cont = remove_extra_space $ content x
        remove_extra_space cs
          | all (maybe True breakAndIndent . fromText) cs = filter (maybe True (not . breakAndIndent) . fromText) cs
          | otherwise = cs

    fmt_inline :: Bool -> a -> SS
    fmt_inline verbatim x
      | isLeaf x = leaf x
      | isVerbatim x = open_tag x +++ lit (fmt_verbatim_content (content x)) +++ close
      | otherwise = open_tag x +++ inline_content +++ close
      where
        close = close_tag x
        inline_content = cmap verbatim (fmt_inline verbatim) (content x)

    leaf x
      | noEmpty x = open_tag x +++ close_tag x
      | otherwise = open_tag_open x +++ lit " />\n"

    fmt_verbatim_content cont =
        cut_indent $ to_str $ cmap True (fmt_inline True) cont

    open_tag_open x = lit $ unwords $ ("<" ++ tag x) : map format_attr (attr x)
    open_tag x = open_tag_open x +++ lit ">"
    close_tag x = lit ("</" ++ tag x ++ ">")

cut_indent :: String -> String
cut_indent = init . unlines . fixTop . cut . fixBottom . lines
  where
    fixTop (first:ls)
      | null (trim first) = ls
    fixTop ls = ls
    fixBottom ls = reverse $ fixTop $ reverse ls
    cut [] = []
    cut (first:ls)
      | all empty ls = first:map (const "") ls
      | otherwise = first:map (drop depth) ls
      where
        depth = minimum $ mapMaybe prec ls
        prec = findIndex (/=' ')
    empty = all (==' ')

normalize_white :: String -> String
normalize_white = concat . map to_space . groupBy weq
  where
    weq x y = white x == white y
    to_space s
      | white (head s) = " "
      | otherwise = s

drop_white :: String -> String
drop_white = dropWhile white

trim :: String -> String
trim = drop_white . reverse . drop_white . reverse

white :: Char -> Bool
white ' ' = True
white '\n' = True
white '\t' = True
white _ = False

format_attr :: (String, String) -> String
format_attr (k, v) = k ++ "=\"" ++ v ++ "\""
