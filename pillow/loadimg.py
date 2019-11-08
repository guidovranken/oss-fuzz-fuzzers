import sys, os, warnings
sys.path.append(os.path.join(os.path.dirname(sys.path[-1]), 'pillow/src/'))
warnings.simplefilter("ignore")

from PIL import Image, ImageFile

def FuzzerRunOne(FuzzerInput):
    p = ImageFile.Parser()
    try:
        p.feed(FuzzerInput)
    except:
        pass
