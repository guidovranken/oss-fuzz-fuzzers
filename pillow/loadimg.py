import sys, os, warnings
import subprocess
from shutil import copyfile

copyfile(os.path.dirname(sys.executable) + '/libjpeg.so.8', '/usr/lib/x86_64-linux-gnu/libjpeg.so.8')
copyfile(os.path.dirname(sys.executable) + '/libtiff.so.5', '/usr/lib/x86_64-linux-gnu/libtiff.so.5')
copyfile(os.path.dirname(sys.executable) + '/libjbig.so.0', '/usr/lib/x86_64-linux-gnu/libjbig.so.0')

sys.path.append(os.path.join(os.path.dirname(sys.path[-1]), 'pillow/src/'))
warnings.simplefilter("ignore")

from PIL import Image, ImageFile

def FuzzerRunOne(FuzzerInput):
    p = ImageFile.Parser()
    try:
        p.feed(FuzzerInput)
    except:
        pass
