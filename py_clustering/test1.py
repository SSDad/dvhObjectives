import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import glob
import os

struct = "Rectum"
fn = 'Objectives_relative_1_100.csv'
ffn = os.path.join(os.getcwd(), fn)ffn
T = pd.read_csv(ffn)
junk = T.StructureId;
# T.StructureId = lower(erase(T.StructureId, '_'));
a = 1
