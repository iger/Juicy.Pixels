
import Data.Array.Unboxed
import Codec.Picture.Bitmap
import Codec.Picture.Png
import Codec.Picture.Types
-- import Codec.Picture.Jpg

-- import System.Environment
import System.FilePath
import qualified Data.ByteString as B
{-import qualified Data.ByteString.Lazy as Lb-}

convertPngToBmp :: FilePath -> IO ()
convertPngToBmp filePath = do
    file <- B.readFile filePath
    putStrLn $ "(?) Loading: " ++ filePath
    case loadPng file of
        Left err -> putStrLn $ "(X) PNG loading error: (" ++ filePath ++ ")" ++ err
        Right img -> writeBitmapFile (filePath ++ ".bmp") img

validTests :: [FilePath]
validTests = 
   ["PngSuite.png", "basi0g01.png", "basi0g02.png", "basi0g04.png", "basi0g08.png",
    "basi0g16.png", "basi2c08.png", "basi2c16.png", "basi3p01.png", "basi3p02.png",
    "basi3p04.png", "basi3p08.png", "basi4a08.png", "basi4a16.png", "basi6a08.png",
    "basi6a16.png", "basn0g01.png", "basn0g02.png", "basn0g04.png", "basn0g08.png",
    "basn0g16.png", "basn2c08.png", "basn2c16.png", "basn3p01.png", "basn3p02.png",
    "basn3p04.png", "basn3p08.png", "basn4a08.png", "basn4a16.png", "basn6a08.png",
    "basn6a16.png", "bgai4a08.png", "bgai4a16.png", "bgan6a08.png", "bgan6a16.png",
    "bgbn4a08.png", "bggn4a16.png", "bgwn6a08.png", "bgyn6a16.png", "ccwn2c08.png",
    "ccwn3p08.png", "cdfn2c08.png", "cdhn2c08.png", "cdsn2c08.png", "cdun2c08.png",
    "ch1n3p04.png", "ch2n3p08.png", "cm0n0g04.png", "cm7n0g04.png", "cm9n0g04.png",
    "cs3n2c16.png", "cs3n3p08.png", "cs5n2c08.png", "cs5n3p08.png", "cs8n2c08.png",
    "cs8n3p08.png", "ct0n0g04.png", "ct1n0g04.png", "cten0g04.png", "ctfn0g04.png",
    "ctgn0g04.png", "cthn0g04.png", "ctjn0g04.png", "ctzn0g04.png", "f00n0g08.png",
    "f00n2c08.png", "f01n0g08.png", "f01n2c08.png", "f02n0g08.png", "f02n2c08.png",
    "f03n0g08.png", "f03n2c08.png", "f04n0g08.png", "f04n2c08.png", "f99n0g04.png",
    "g03n0g16.png", "g03n2c08.png", "g03n3p04.png", "g04n0g16.png", "g04n2c08.png",
    "g04n3p04.png", "g05n0g16.png", "g05n2c08.png", "g05n3p04.png", "g07n0g16.png",
    "g07n2c08.png", "g07n3p04.png", "g10n0g16.png", "g10n2c08.png", "g10n3p04.png",
    "g25n0g16.png", "g25n2c08.png", "g25n3p04.png", "oi1n0g16.png", "oi1n2c16.png",
    "oi2n0g16.png", "oi2n2c16.png", "oi4n0g16.png", "oi4n2c16.png", "oi9n0g16.png",
    "oi9n2c16.png", "pp0n2c16.png", "pp0n6a08.png", "ps1n0g08.png", "ps1n2c16.png",
    "ps2n0g08.png", "ps2n2c16.png", "s01i3p01.png", "s01n3p01.png", "s02i3p01.png",
    "s02n3p01.png", "s03i3p01.png", "s03n3p01.png", "s04i3p01.png", "s04n3p01.png",
    "s05i3p02.png", "s05n3p02.png", "s06i3p02.png", "s06n3p02.png", "s07i3p02.png",
    "s07n3p02.png", "s08i3p02.png", "s08n3p02.png", "s09i3p02.png", "s09n3p02.png",
    "s32i3p04.png", "s32n3p04.png", "s33i3p04.png", "s33n3p04.png", "s34i3p04.png",
    "s34n3p04.png", "s35i3p04.png", "s35n3p04.png", "s36i3p04.png", "s36n3p04.png",
    "s37i3p04.png", "s37n3p04.png", "s38i3p04.png", "s38n3p04.png", "s39i3p04.png",
    "s39n3p04.png", "s40i3p04.png", "s40n3p04.png", "tbbn0g04.png", "tbbn2c16.png",
    "tbbn3p08.png", "tbgn2c16.png", "tbgn3p08.png", "tbrn2c08.png", "tbwn0g16.png",
    "tbwn3p08.png", "tbyn3p08.png", "tp0n0g08.png", "tp0n2c08.png", "tp0n3p08.png",
    "tp1n3p08.png", "z00n2c08.png", "z03n2c08.png", "z06n2c08.png", "z09n2c08.png"]

sizeNonInterlaced, basicNonInterlaced, paletteTest, filterTest, chunkOrderingTest, compressionTest :: [FilePath]
basicNonInterlaced = [ "basn0g01.png", "basn0g02.png", "basn0g04.png", "basn0g08.png",
                       "basn0g16.png", "basn2c08.png", "basn2c16.png", "basn3p01.png",
                       "basn3p02.png", "basn3p04.png", "basn3p08.png", "basn4a08.png",
                       "basn4a16.png", "basn6a08.png", "basn6a16.png"]
sizeNonInterlaced = [ "s01n3p01.png", "s02n3p01.png", "s03n3p01.png", "s04n3p01.png",
                      "s05n3p02.png", "s06n3p02.png", "s07n3p02.png", "s08n3p02.png",
                      "s09n3p02.png", "s32n3p04.png", "s33n3p04.png", "s34n3p04.png",
                      "s35n3p04.png", "s36n3p04.png", "s37n3p04.png", "s38n3p04.png",
                      "s39n3p04.png", "s40n3p04.png"]

paletteTest = ["pp0n2c16.png", "pp0n6a08.png", "ps1n0g08.png", "ps1n2c16.png", "ps2n0g08.png", "ps2n2c16.png"]
filterTest = [ "f00n0g08.png", "f01n0g08.png", "f02n0g08.png", "f03n0g08.png", 
               "f04n0g08.png", "f00n2c08.png", "f01n2c08.png", "f02n2c08.png", 
               "f03n2c08.png", "f04n2c08.png" ]

chunkOrderingTest = [ "oi1n0g16.png", "oi2n0g16.png", "oi4n0g16.png", "oi9n0g16.png", 
                      "oi1n2c16.png", "oi2n2c16.png", "oi4n2c16.png", "oi9n2c16.png" ]

compressionTest = ["z00n2c08.png", "z03n2c08.png", "z06n2c08.png", "z09n2c08.png"]

invalidTests :: [FilePath]
invalidTests =
   ["xc1n0g08.png", "xc9n2c08.png", "xcrn0g04.png", "xcsn0g01.png", "xd0n2c08.png",
    "xd3n2c08.png", "xd9n2c08.png", "xdtn0g01.png", "xhdn0g08.png", "xlfn0g04.png",
    "xs1n0g01.png", "xs2n0g01.png", "xs4n0g01.png", "xs7n0g01.png"]


exportBmpWitness :: IO ()
exportBmpWitness = writeBitmapFile "wintess.bmp" $ img 232 241
    where img w h = array ((0,0), (w - 1, h - 1)) $ pixels w h
          pixels w h = [((x,y), pixel x y) | y <- [0 .. h-1], x <- [0 .. w-1] ]
          pixel x y = PixelRGBA8 128 (fromIntegral x) (fromIntegral y) 255

main :: IO ()
main = do
    exportBmpWitness
    putStrLn ">>>> Valid instances"
    {-mapM_ (convertPngToBmp . (("tests" </> "pngsuite") </>)) validTests-}
    mapM_ (convertPngToBmp . (("tests" </> "pngsuite") </>)) -- ["basn0g08.png"]
            $ basicNonInterlaced ++ sizeNonInterlaced ++ filterTest ++ paletteTest ++ chunkOrderingTest ++ compressionTest
    -- putStrLn ">>>> invalid instances"
    -- mapM_ (convertPngToBmp . (("tests" </> "pngsuite") </>)) invalidTests
